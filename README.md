# Fleet Tracker (Android)

Production-ready **GPS vehicle-tracking app** — the Flutter client for the
fleet-tracking assessment (the other repository is the FastAPI + PostgreSQL
backend). This is not a code demo: a signed release APK is attached to every
GitHub release, the cloud backend is live, and four demo vehicles drive
around Chennai 24/7.

**Backend API (live):** https://fleet-tracking-api.onrender.com
**Backend repo:** https://github.com/shakeelscribes/fleet-tracking-backend

---

## ⚡ Try it in 60 seconds — no setup required

1. Open [**Releases**](../../releases) and download `fleet-tracker.apk`
   from the latest release.
2. Copy it to any Android 7.0+ phone (or just `adb install fleet-tracker.apk`
   on an emulator) and open it — allow "install unknown apps" if Android asks.
3. Sign in with one of the demo accounts. The live cloud URL is **baked into
   the APK** — nothing to configure.

| Role | Email | Password | What you'll see |
| --- | --- | --- | --- |
| Driver | `ravi@fleet.com` | `password123` | Route A · BUS-001 "Chennai Express", live map, own history |
| Driver | `priya@fleet.com` | `password123` | Route B · BUS-002 "OMR Flier" |
| Driver | `arun@fleet.com` | `password123` | Route C · BUS-003 "Marina Cruiser" |
| Driver | `divya@fleet.com` | `password123` | Route D · BUS-004 "Guindy Shuttle" |
| Fleet admin | `admin@fleet.com` | `password123` | All four vehicles on one live map |

> ⏳ **First sign-in can take 30–60 s.** The free-tier Render backend sleeps
> after ~15 minutes idle and cold-boots on the first request. If sign-in
> spins, give it a moment and retry once — every later request is fast.
> (A keep-alive job pings the API every 10 minutes to minimise this.)

## What you get

- **Driver experience** — assigned route + vehicle card, live telemetry
  (speed, last fix, coordinates) polled every 5 s, the route as a polyline on
  OpenStreetMap with a live bus marker, and a 24-hour location history
  (newest-first, with direction-of-travel needles). Swipe horizontally
  between the three driver tabs.
- **Fleet-admin overview** — every vehicle on one live map with a glass
  legend of live status chips (moving / idle / offline — server-derived).
- **Server-enforced isolation** — the client never decides permissions: the
  API returns each driver *strictly their own* route/vehicle/history and
  answers `403 no_assignment` otherwise; `/admin/vehicles` is admin-only.
  Role routing uses `GET /me/profile`, not JWT decoding.
- **Honest error states** — network failures, expired sessions and empty
  data each get a localized, retryable screen (never a raw stack trace).
- **Zero map billing** — OSM raster tiles via `flutter_map`; no Google Maps
  key, no credit card, works out of the box.
- **Secure sessions** — JWT pair in `flutter_secure_storage` (Android
  Keystore), silent one-shot refresh on 401.

## Application flow (PDF requirement)

```
Splash ──> Login ──┬── role: driver ──> Driver shell (bottom nav + swipe)
                   │                     ├── Home      - assigned route + vehicle
                   │                     │               + live GPS status (5s poll)
                   │                     ├── Map       - route polyline (OpenStreetMap)
                   │                     │               + live bus marker
                   │                     └── History   - GPS trail of own vehicle
                   │
                   └── role: admin ───> Fleet overview
                                         - all vehicles on one live map
                                         - status chips (moving/idle/offline)
                                         - server-derived status per vehicle
```

**Terminology:** the task PDF says "assign one bus route and vehicle to each
user"; the app models that party as the **driver** role — `ravi@fleet.com` is
the PDF's "User A" (Route A + BUS-001).

## Screens

| Screen | What it shows |
| --- | --- |
| Login | Email/password + one-tap demo chips (driver / admin) |
| Home | Hero assignment card + live telemetry (big speed readout, coords) |
| Map | Route polyline with teal halo + live bus marker (OSM tiles) |
| History | Own vehicle's fixes, newest-first, bearing needles, pull-to-refresh |
| Fleet (admin) | Every vehicle on a live map + glass legend of status chips |

## Where the data lives

- **All fleet data is server-side, in PostgreSQL** — users, routes,
  vehicles, GPS history and current positions (SQLAlchemy + Alembic
  migrations; the live demo runs Render's free Postgres). The device is a
  thin client: **the only thing it stores is the encrypted JWT token pair**;
  there is no local fleet-data cache.
- **GPS points** are produced by the backend's MQTT simulator driving each
  vehicle along its route (≈ a fix every 3 s) and stored by the API —
  which is why history and the live marker move on their own.
- Local/self-hosted: `docker-compose up` in the backend repo starts
  PostgreSQL 16 + Mosquitto + the API.
- ⚠️ Render's **free** Postgres expires after 30 days — fine for the
  assessment window. For a longer-lived demo, point `DATABASE_URL` at a free
  Neon/Supabase Postgres in the Render dashboard (see backend README).

## Run from source (Android)

Prerequisites: **Flutter 3.47 / Dart 3.13** (or newer), Android SDK
(accept licenses), a device/emulator on API 24+.

```bash
git clone https://github.com/shakeelscribes/fleet-tracking-frontend.git
cd fleet-tracking-frontend
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed/retrofit/riverpod codegen
flutter run                                                # on emulator or device
```

- `.env` is **optional** (the live API is the default). To run against a
  local backend, copy `.env.example` → `.env` and set e.g.
  `API_BASE_URL=http://10.0.2.2:8000/api/v1` (Android-emulator loopback).
- Quality gates:

```bash
flutter analyze                       # 0 issues expected
flutter test --exclude-tags=live      # 23 unit/widget tests
flutter test --tags=live              # smoke test against the live cloud API
```

### Android-only, on purpose

The assessment targets Android, so only the `android/` platform folder is
present (`ios/`, `web/`, desktop runners were removed to keep the repo
lean and the CI surface honest). All Dart code is platform-portable if this
ever needs to change; `minSdk 24`.

### App icon

`assets/icon/app_icon.png` (1024×1024) is the master icon; launcher icons +
the Android adaptive icon are generated with
[flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons):

```bash
dart run flutter_launcher_icons     # after replacing the master icon
```

## Architecture

```
lib/
├── core/                        # framework-agnostic app layer
│   ├── errors/                  # sealed AppException + Dio error mapper
│   │                            #   (understands {"error":{code,message}})
│   ├── models/                  # Freezed DTOs, snake_case via @JsonKey
│   ├── network/                 # Dio (auth interceptor + one-shot 401
│   │                            #   refresh), Retrofit APIs
│   ├── providers/               # AuthController (keepAlive session)
│   ├── routing/                 # typed GoRouter (go_router_builder) with
│   │                            #   role-aware auth guard
│   ├── theme/                   # transit-teal palette, Inter+Space Grotesk,
│   │                            #   tabular data styles, 8pt grid,
│   │                            #   dark-first + styled light theme
│   ├── utils/                   # constants (API base URL), l10n extension
│   └── widgets/                 # AppBackground, AppErrorWidget, StatusChip
│                                #   (pulsing status dot)
└── features/
    ├── auth/                    # Login (hooks + validation), Splash
    ├── tracking/                # Home / Map / History + 5s poll providers
    └── fleet/                   # admin overview + poll provider
```

- **State:** Riverpod (annotation-based, generated) + flutter_hooks.
- **Networking:** Dio + Retrofit + Freezed codegen (`build_runner`).
- **Errors:** sealed `AppException` union; providers never leak Dio types;
  every screen has loading / error / empty states with localized copy (ARB).
- **Localization:** `flutter gen-l10n` (`lib/l10n/app_en.arb`).

## Release

`release-apk.yml` builds the release APK on every `v*` tag (and manual
dispatch) and publishes it to GitHub Releases — that's where the prebuilt
`fleet-tracker.apk` comes from. Local equivalent: `flutter build apk --release`.

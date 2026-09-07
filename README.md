# Fleet Tracker (Flutter)

GPS vehicle-tracking client for the **fleet-tracking-backend** assessment
(FastAPI backend, this repo = the second of the two submitted GitHub
repositories). Built with Flutter + Riverpod per the project's
architecture/design skills.

**Backend API (live):** https://fleet-tracking-api.onrender.com
**Backend repo:** https://github.com/shakeelscribes/fleet-tracking-backend

---

## Application flow (PDF requirement)

```
Splash ──> Login ──┬── role: driver ──> Driver shell (bottom nav)
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

- **Auth is server-enforced.** The client never decides permissions: the
  backend returns each driver *strictly their own* route/vehicle/history
  (`403 no_assignment` otherwise) and gates `/admin/vehicles` to admins.
- **Role routing** uses `GET /me/profile` (`is_admin`), not JWT decoding.
- **Zero-setup demo:** the release APK has the live cloud URL baked in.
  Demo accounts (public by design): `ravi@fleet.com` / `admin@fleet.com`,
  password `password123`.

## Screens

| Screen | What it shows |
| --- | --- |
| Login | Email/password + one-tap demo chips (driver / admin) |
| Home | Assigned route + vehicle card, live status (speed, last fix, coords) |
| Map | Route polyline + teal bus marker, OSM tiles (no API key/billing) |
| History | Own vehicle's GPS points, newest-first, pull-to-refresh |
| Fleet (admin) | Every vehicle on a live map + derived status chips |

## Architecture (per `flutter-architecture` skill)

```
lib/
├── core/                        # framework-agnostic app layer
│   ├── errors/                  # sealed AppException + Dio error mapper
│   │                            #   (understands {"error":{code,message}})
│   ├── models/                  # Freezed DTOs, snake_case via @JsonKey
│   ├── network/                 # Dio (auth interceptor + one-shot 401
│   │                            #   refresh), Retrofit APIs, token store
│   │                            #   in flutter_secure_storage
│   ├── providers/               # AuthController (keepAlive session)
│   ├── routing/                 # typed GoRouter (go_router_builder) with
│   │                            #   role-aware auth guard
│   ├── theme/                   # transit-teal palette, Inter+Space Grotesk,
│   │                            #   8pt grid, dark-first + styled light
│   ├── utils/                   # constants (API base URL), l10n extension
│   └── widgets/                 # AppErrorWidget, StatusChip
└── features/
    ├── auth/                    # Login (hooks + validation), Splash
    ├── tracking/                # Home / Map / History + poll providers
    └── fleet/                   # admin overview + poll provider
```

- **State:** Riverpod (annotation-based, generated) + flutter_hooks.
- **Networking:** Dio + Retrofit + Freezed codegen (`build_runner`).
- **Errors:** sealed `AppException` union; providers never leak Dio types;
  every screen has loading / error / empty states with localized copy (ARB).
- **Secrets:** JWT pair in `flutter_secure_storage` (never SharedPreferences).
- **Localization:** `flutter gen-l10n` (`lib/l10n/app_en.arb`).

## Run it

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # codegen
flutter run -d chrome                                      # dev against live API
flutter test                                               # unit + widget tests
flutter test --tags live                                   # live-API smoke test
```

Point at a local backend with a gitignored `.env` (see `.env.example`),
e.g. `API_BASE_URL=http://10.0.2.2:8000/api/v1` for the Android emulator.

## Release

`release-apk.yml` builds a signed-for-distribution **release APK** on every
`v*` tag and publishes it to GitHub Releases. Local build:
`flutter build apk --release`.

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'generated/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Optional: a gitignored .env overrides the baked-in live API URL.
  await loadDotEnvOrIgnore();
  runApp(const ProviderScope(child: FleetTrackerApp()));
}

Future<void> loadDotEnvOrIgnore() async {
  try {
    await dotenv.load(fileName: '.env');
  } on Exception {
    // .env is optional in shipped builds.
  }
}

class FleetTrackerApp extends ConsumerWidget {
  const FleetTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp.router(
        title: 'Fleet Tracker',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        // Dark-first (grilling-locked), light fully styled too.
        theme: AppTheme.light(context),
        darkTheme: AppTheme.dark(context),
        themeMode: ThemeMode.dark,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

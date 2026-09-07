// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fleet Tracker';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Track your assigned bus in real time';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get signingIn => 'Signing in…';

  @override
  String get demoAccounts => 'Demo accounts';

  @override
  String get demoDriver => 'Driver';

  @override
  String get demoAdmin => 'Admin';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordShort => 'At least 8 characters';

  @override
  String get errorNetwork =>
      'Can\'t reach the fleet server. Check your connection.';

  @override
  String get errorUnauthorized => 'Session expired. Please sign in again.';

  @override
  String get errorNotFound => 'Not found.';

  @override
  String get errorUnknown => 'Something went wrong. Try again.';

  @override
  String get invalidCredentials => 'Wrong email or password.';

  @override
  String get retry => 'Retry';

  @override
  String get logout => 'Sign out';

  @override
  String get navHome => 'Home';

  @override
  String get navMap => 'Map';

  @override
  String get navHistory => 'History';

  @override
  String get navFleet => 'Fleet';

  @override
  String get homeGreeting => 'Your assignment';

  @override
  String get routeLabel => 'Route';

  @override
  String get vehicleLabel => 'Vehicle';

  @override
  String get noAssignment =>
      'No route or vehicle assigned yet.\nContact your fleet administrator.';

  @override
  String get liveStatus => 'Live location';

  @override
  String get statusMoving => 'Moving';

  @override
  String get statusIdle => 'Idle';

  @override
  String get statusOffline => 'Offline';

  @override
  String get statusNoFix => 'Waiting for first GPS fix…';

  @override
  String get speed => 'Speed';

  @override
  String get lastUpdate => 'Updated';

  @override
  String get justNow => 'Just now';

  @override
  String get kmph => 'km/h';

  @override
  String get mapTitle => 'Live map';

  @override
  String get mapNoRoute => 'Your route will appear here once assigned.';

  @override
  String get mapBusHere => 'Your bus';

  @override
  String get historyTitle => 'Location history';

  @override
  String get historyEmpty => 'No GPS points recorded in the last 24 hours.';

  @override
  String historyPoints(int count) {
    return '$count points';
  }

  @override
  String get fleetTitle => 'Fleet overview';

  @override
  String get fleetSubtitle => 'All vehicles, live';

  @override
  String get fleetEmpty => 'No vehicles registered yet.';

  @override
  String get fleetLegend => 'Live fleet';

  @override
  String get driverBadge => 'Driver';

  @override
  String get adminBadge => 'Fleet admin';
}

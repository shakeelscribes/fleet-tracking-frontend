import 'package:flutter/widgets.dart';

import 'package:fleet_tracker/generated/l10n/app_localizations.dart';

import '../errors/app_exception.dart';

/// `context.l10n.someKey` everywhere (skill LA-1/LA-4).
extension AppLocalizationsExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Map a typed [AppException] to localized UI copy (skill EH-4):
  /// network/auth errors get local text; backend 4xx messages are
  /// user-facing already (e.g. `no_assignment`) and shown as-is.
  String localizedException(AppException e) => switch (e) {
    NetworkException() => l10n.errorNetwork,
    UnauthorizedException() => l10n.errorUnauthorized,
    NotFoundException() => l10n.errorNotFound,
    ForbiddenException(:final message) => message ?? l10n.errorUnknown,
    ServerException(:final code, :final message) =>
      code == 'invalid_credentials' ? l10n.invalidCredentials : message,
    UnknownException() => l10n.errorUnknown,
  };
}

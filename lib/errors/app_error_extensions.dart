// app_error_extensions.dart
import 'package:flutter/material.dart';
import 'package:blog/errors/app_error.dart';
import 'package:blog/errors/error_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppErrorLocalization on AppError {
  static String getErrorMessage(BuildContext context, code) {
    switch (code) {
      case ErrorCodes.networkError:
        return AppLocalizations.of(context)!.networkErrorMessage;
      case ErrorCodes.unauthorized:
        return AppLocalizations.of(context)!.unauthorizedMessage;
      case ErrorCodes.invalidToken:
        return AppLocalizations.of(context)!.invalidTokenMessage;
      default:
        return AppLocalizations.of(context)!.genericErrorMessage;
    }
  }
}
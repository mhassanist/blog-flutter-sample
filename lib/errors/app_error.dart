import 'package:equatable/equatable.dart';
import 'package:blog/errors/error_constants.dart';


abstract class AppError extends Equatable {
  final int code;

  const AppError({required this.code});

  @override
  List<Object> get props => [code];

}

class NetworkError extends AppError {
  const NetworkError() : super(code: ErrorCodes.networkError);
}

class NotAuthorized extends AppError {
  const NotAuthorized() : super(code: ErrorCodes.unauthorized);
}

class InvalidTokenError extends AppError {
  const InvalidTokenError() : super(code: ErrorCodes.invalidToken);
}


//Consider using freezed package for better code generation
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'app_error.freezed.dart';

// @freezed
// abstract class AppError with _$AppError {
//   const factory AppError.networkError() = NetworkError;
//   const factory AppError.notAuthorized() = NotAuthorized;
//   const factory AppError.invalidToken() = InvalidTokenError;
// }
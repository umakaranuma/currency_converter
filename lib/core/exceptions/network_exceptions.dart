import 'dart:io';

import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest(ErrorException? errorModel) =
      BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict(ErrorException? errorModel) =
      Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    ErrorException? errorModel;
    errorModel = ErrorException(
        error: response?.data['error'] is String
            ? {'error': response?.data['error']}
            : response?.data['error'],
        statusMessage: response?.data['message'],
        code: response?.statusCode ?? 0);

    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
        return NetworkExceptions.notFound(
            errorModel.statusMessage ?? "No Permission Login to Continue");
      case 403:
        return NetworkExceptions.unauthorizedRequest(
            errorModel.statusMessage ?? "Not found");
      case 404:
        return NetworkExceptions.notFound(
            errorModel.statusMessage ?? "Not found");
      case 409:
        errorModel.data = response?.data['data'];
        return NetworkExceptions.conflict(errorModel);
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
      case 417:
        return NetworkExceptions.badRequest(errorModel);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return NetworkExceptions.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static ErrorException getErrorMessage(NetworkExceptions networkExceptions) {
    ErrorException errorModel = ErrorException(statusMessage: '', code: 0);
    networkExceptions.when(notImplemented: () {
      errorModel = ErrorException(statusMessage: "Not Implemented", code: 0);
    }, requestCancelled: () {
      errorModel = ErrorException(statusMessage: "Request Cancelled", code: 2);
    }, internalServerError: () {
      errorModel =
          ErrorException(statusMessage: "Internal Server Error", code: 500);
    }, notFound: (String reason) {
      errorModel = ErrorException(statusMessage: reason, code: 404);
    }, serviceUnavailable: () {
      errorModel =
          ErrorException(statusMessage: "Service unavailable", code: 503);
    }, methodNotAllowed: () {
      errorModel = ErrorException(statusMessage: "Method Allowed", code: 405);
    }, badRequest: (ErrorException? errors) {
      errorModel = errors!;
    }, unauthorizedRequest: (String error) {
      errorModel = ErrorException(statusMessage: error, code: 403);
    }, unexpectedError: () {
      errorModel =
          ErrorException(statusMessage: "Unexpected error occurred", code: 0);
    }, requestTimeout: () {
      errorModel = ErrorException(
          statusMessage: "Connection request timeout", code: 408);
    }, noInternetConnection: () {
      errorModel =
          ErrorException(statusMessage: "No internet connection", code: 502);
    }, conflict: (ErrorException? errors) {
      errorModel = errors!;
    }, sendTimeout: () {
      errorModel = ErrorException(
          statusMessage: "Send timeout in connection with API server",
          code: 408);
    }, unableToProcess: () {
      errorModel =
          ErrorException(statusMessage: "Unable to process the data", code: 0);
    }, defaultError: (String error) {
      errorModel = ErrorException(statusMessage: error, code: 0);
    }, formatException: () {
      errorModel =
          ErrorException(statusMessage: "Unexpected error occurred", code: 0);
    }, notAcceptable: () {
      errorModel = ErrorException(statusMessage: "Not acceptable", code: 0);
    });
    return errorModel;
  }
}

class ErrorException {
  String? statusMessage;
  Map? error;
  String? errorText;
  dynamic data;
  int? code = 0;

  ErrorException(
      {this.statusMessage, this.error, this.errorText, this.data, this.code});
}

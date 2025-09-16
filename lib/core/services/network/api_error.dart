// ignore_for_file: unused_catch_stack

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';

import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/navigation/routes.dart';

import '../data/session_manager.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;
  ApiErrorModel? apiErrorModel;

  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError(this.errorDescription);

  factory ApiError.fromDio(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        logger.e('unknown');

        return ApiError('Request to API was cancelled');
      case DioExceptionType.connectionTimeout:
        logger.e('unknown');
        return ApiError('Connection timeout with API');
      case DioExceptionType.sendTimeout:
        return ApiError('Send timeout in connection with API');
      case DioExceptionType.receiveTimeout:
        return ApiError('Receive timeout in connection with API');
      case DioExceptionType.badResponse:
        return ApiError(_setCustomErrorMessage(dioError.response!));
      // return ApiError(
      //     'Received invalid status code: ${dioError.response?.statusCode}');
      case DioExceptionType.unknown:
        return ApiError(_setCustomErrorMessage(dioError.response!));

      default:
        return ApiError('Oops!,${dioError.response!}');
    }
  }

  factory ApiError.unknown(dynamic dioError) {
    return ApiError('Oops!,$dioError');
  }

  ApiError.fromResponse(Object? error) {
    if (error is Response) {
      _setCustomErrorMessage(error);
      _handleErr();
    } else {
      _handleErr();
      errorDescription = "Oops an error occurred, we are fixing it";
    }
  }

  _handleErr() {
    return errorDescription;
  }

  String extractDescriptionFromResponse(Response<dynamic>? response) {
    String message = "";
    try {
      if (response?.data != null && response?.data["message"] != null) {
        message = response?.data["message"];
        logger.e(message);

        if (message == 'Invalid Data') {
          final errors = response?.data["errors"] as List;
          message = errors.firstOrNull;
        }
      } else {
        message = response?.statusMessage ?? '';
      }
    } catch (error, stackTrace) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => '$errorDescription';
}

class ApiErrorModel {
  int? code;
  String? msg;
  bool? success;

  ApiErrorModel({this.code, this.msg, this.success});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
    code: json["code"],
    msg: json["message"],
    success: json["success"],
  );
}

String _setCustomErrorMessage(Response error) {
  if (error.statusCode == 401) {
    // CustomDialogs.error('Unauthorized');
    // CustomRoutes.goRouter.goNamed(PageUrl.signin_screen);
    SessionManager().logOut();
    return 'Unauthorized';
  }

  final errorMessageList = <String>[];

  if (error.data['msg'] is String) {
    errorMessageList.add(error.data['msg']);
  }
  if (error.data['message'] is String) {
    errorMessageList.add(error.data['message']);
  }
  if (error.data['status'] is String) {
    errorMessageList.add(error.data['status']);
  }
  if (error.data['detail'] is String) {
    errorMessageList.add(error.data['detail']);
  }
  if (error.data['error'] is String) {
    errorMessageList.add(error.data['error']);
  }
  if (error.data['email'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['email']));
  }
  if (error.data['postal_code'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['postal_code']));
  }

  if (error.data['country'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['country']));
  }

  if (error.data['state'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['state']));
  }

  if (error.data['full_name'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['full_name']));
  }

  if (error.data['phone_number'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['phone_number']));
  }
  if (error.data['id_number'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['id_number']));
  }
  if (error.data['business_phone'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['business_phone']));
  }
  if (error.data['business_cac_number'] is List) {
    errorMessageList.addAll(
      List<String>.from(error.data['business_cac_number']),
    );
  }
  if (error.data['cac_number'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['cac_number']));
  }
  if (error.data['account_number'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['account_number']));
  }

  if (error.data['account_name'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['account_name']));
  }
  if (error.data['company_name'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['company_name']));
  }

  if (error.data['address'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['address']));
  }
  if (error.data['date_of_birth'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['date_of_birth']));
  }

  if (error.data['city'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['city']));
  }
  if (error.data['detail'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['detail']));
  }
  if (error.data['referral_code'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['referral_code']));
  }
  if (error.data['image_links'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['image_links']));
  }
  if (error.data['details'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['details']));
  }
  if (error.data['error'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['error']));
  }
  if (error.data['status'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['status']));
  }
  if (error.data['non_field_errors'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['non_field_errors']));
  }
  if (error.data['user_type'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['user_type']));
  }
  if (error.data['images'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['images']));
  }
  if (error.data['business_decription'] is List) {
    errorMessageList.addAll(
      List<String>.from(error.data['business_decription']),
    );
  }
  if (error.data['status'] is List) {
    errorMessageList.addAll(List<String>.from(error.data['status']));
  }
  if (error.data['errors'] is Map<String, dynamic>) {
    final errors = error.data['errors'] as Map<String, dynamic>;
    final errorMessages = errors.values.whereType<List>().expand(
      (messages) => messages.whereType<String>(),
    );
    errorMessageList.addAll(errorMessages);
  }

  if (error.data['errors'] is Map<String, dynamic>) {
    final errors = error.data['errors'] as Map<String, dynamic>;
    errors.forEach((key, value) {
      if (value is String) {
        errorMessageList.add(value);
      } else if (value is List) {
        errorMessageList.addAll(List<String>.from(value));
      }
    });
  }


  if (error.data['data'] is String) {
    errorMessageList.add(error.data['data']);
  }
  return errorMessageList.join(', ');
}

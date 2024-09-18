import 'package:crystal_code/data/datasource/remote/dio/dio_client.dart';
import 'package:crystal_code/data/datasource/remote/exception/api_error_handler.dart';
import 'package:crystal_code/common/models/api_response_model.dart';
import 'package:crystal_code/utill/app_constants.dart';

class NotificationRepo {
  final DioClient? dioClient;

  NotificationRepo({required this.dioClient});

  Future<ApiResponseModel> getNotificationList() async {
    try {
      final response = await dioClient!.get(AppConstants.notificationUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

import 'package:crystal_code/common/models/api_response_model.dart';
import 'package:crystal_code/common/models/error_response_model.dart';
import 'package:crystal_code/main.dart';
import 'package:crystal_code/utill/routes.dart';
import 'package:crystal_code/helper/custom_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:provider/provider.dart';

class ApiCheckerHelper {
  static void checkApi(ApiResponseModel apiResponse) {
    ErrorResponseModel error = getError(apiResponse);
//config-missing
    if (error.errors![0].code == '401' ||
        error.errors![0].code == 'auth-001' &&
            ModalRoute.of(Get.context!)?.settings.name !=
                Routes.getLoginRoute()) {
      Provider.of<SplashProvider>(Get.context!, listen: false)
          .removeSharedData();

      if (ModalRoute.of(Get.context!)!.settings.name !=
          Routes.getLoginRoute()) {
        Navigator.pushNamedAndRemoveUntil(
            Get.context!, Routes.getLoginRoute(), (route) => false);
      }
    } else {
      showCustomSnackBar(error.errors![0].message, Get.context!);
    }
  }

  static ErrorResponseModel getError(ApiResponseModel apiResponse) {
    ErrorResponseModel error;

    try {
      error = ErrorResponseModel.fromJson(apiResponse);
    } catch (e) {
      if (apiResponse.error is String) {
        error = ErrorResponseModel(
            errors: [Errors(code: '', message: apiResponse.error.toString())]);
      } else {
        error = ErrorResponseModel.fromJson(apiResponse.error);
      }
    }
    return error;
  }
}

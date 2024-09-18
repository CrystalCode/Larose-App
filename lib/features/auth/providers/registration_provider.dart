import 'package:crystal_code/common/models/api_response_model.dart';
import 'package:crystal_code/common/models/config_model.dart';
import 'package:crystal_code/common/models/response_model.dart';
import 'package:crystal_code/common/models/signup_model.dart';
import 'package:crystal_code/features/auth/domain/enums/verification_type_enum.dart';
import 'package:crystal_code/features/auth/domain/reposotories/auth_repo.dart';
import 'package:crystal_code/features/auth/providers/auth_provider.dart';
import 'package:crystal_code/features/auth/providers/verification_provider.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:crystal_code/helper/api_checker_helper.dart';
import 'package:crystal_code/helper/custom_snackbar_helper.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationProvider with ChangeNotifier {
  final AuthRepo? authRepo;

  RegistrationProvider({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage = '';
  String? get errorMessage => _errorMessage;

  set setErrorMessage(String? value) => _errorMessage = value;

  Future<ResponseModel> registration(
      SignUpModel signUpModel, ConfigModel config) async {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(Get.context!, listen: false);
    final VerificationProvider verificationProvider =
        Provider.of<VerificationProvider>(Get.context!, listen: false);
    final SplashProvider splashProvider =
        Provider.of<SplashProvider>(Get.context!, listen: false);

    _isLoading = true;
    notifyListeners();

    ApiResponseModel apiResponse = await authRepo!.registration(signUpModel);
    ResponseModel responseModel;
    String? token;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(
          getTranslated('registration_successful', Get.context!), Get.context!,
          isError: false);

      Map map = apiResponse.response?.data;

      if (map.containsKey('token')) {
        token = map["token"];
      }

      if (token != null) {
        await authProvider.login(signUpModel.email, signUpModel.password!);
        responseModel = ResponseModel(true, 'successful');
      } else {
        verificationProvider.sendVerificationCode(
          emailOrPhone: (splashProvider.configModel?.phoneVerification ?? false)
              ? signUpModel.phone
              : signUpModel.email,
          verificationType:
              (splashProvider.configModel?.phoneVerification ?? false)
                  ? VerificationType.phone
                  : VerificationType.email,
        );
        responseModel = ResponseModel(false, null);
      }
    } else {
      _errorMessage =
          ApiCheckerHelper.getError(apiResponse).errors?.first.message;
      responseModel = ResponseModel(false, _errorMessage);
    }

    _isLoading = false;
    notifyListeners();

    return responseModel;
  }
}

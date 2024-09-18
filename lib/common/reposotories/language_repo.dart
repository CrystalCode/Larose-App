import 'package:flutter/material.dart';
import 'package:crystal_code/common/models/language_model.dart';
import 'package:crystal_code/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}

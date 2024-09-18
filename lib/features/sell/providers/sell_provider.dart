import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:crystal_code/common/models/api_response_model.dart';
import 'package:crystal_code/common/models/response_model.dart';
import 'package:crystal_code/features/sell/domain/models/paginated_user_listing_model.dart';
import 'package:crystal_code/features/sell/domain/models/store_data_model.dart';
import 'package:crystal_code/features/sell/domain/repositories/sell_repo.dart';
import 'package:crystal_code/helper/api_checker_helper.dart';
import 'package:crystal_code/helper/custom_snackbar_helper.dart';
import 'package:crystal_code/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SellProvider with ChangeNotifier {
  final SellRepo? sellRepo;
  SellProvider({required this.sellRepo});

  bool _isLoading = false;
  PaginatedUserListingModel? _userListingModel;
  int _branchIndex = 0;
  List<XFile>? _rawImages = [];
  int? _imageSliderIndex;

  bool get isLoading => _isLoading;
  PaginatedUserListingModel? get userListingModel => _userListingModel;
  int get branchIndex => _branchIndex;
  List<XFile>? get rawImages => _rawImages;
  int? get imageSliderIndex => _imageSliderIndex;

  Future<ResponseModel> storeUserListing(
      StoreDataModel storeDataModel, List<XFile>? file, String token) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.Response response =
        await sellRepo!.storeUserListing(storeDataModel, file!, token);

    _isLoading = false;

    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      String? message = map["message"];
      responseModel = ResponseModel(true, message);
      clearPrevData();
    } else {
      responseModel = ResponseModel(
          false, '${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();

    return responseModel;
  }

  Future getUserListing(int offset,
      {bool isUpdate = true, int? limit = 10}) async {
    if (offset == 1) {
      _userListingModel = null;

      if (isUpdate) {
        notifyListeners();
      }
    }
    ApiResponseModel apiResponse =
        await sellRepo!.getUserListing(offset, limit ?? 10);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      if (offset == 1) {
        _userListingModel =
            PaginatedUserListingModel.fromJson(apiResponse.response?.data);
      } else {
        _userListingModel!.totalSize =
            PaginatedUserListingModel.fromJson(apiResponse.response?.data)
                .totalSize;
        _userListingModel!.offset =
            PaginatedUserListingModel.fromJson(apiResponse.response?.data)
                .offset;
        _userListingModel!.data!.addAll(
            PaginatedUserListingModel.fromJson(apiResponse.response?.data)
                .data!);
      }

      _isLoading = false;
      notifyListeners();
    } else {
      showCustomSnackBar(
          ApiCheckerHelper.getError(apiResponse).errors?.first.message,
          Get.context!);
    }
  }

  void setBranchIndex(int index) {
    _branchIndex = index;
    notifyListeners();
  }

  void clearPrevData() {
    _branchIndex = 0;
    _rawImages = [];
  }

  void pickImages() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      _rawImages?.add(xFile);
    }
    notifyListeners();
  }

  void removeImage(int index) {
    _rawImages?.removeAt(index);
    notifyListeners();
  }

  void setImageSliderIndex(int index) {
    _imageSliderIndex = index;
    notifyListeners();
  }
}

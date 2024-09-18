import 'dart:io';
import 'package:dio/dio.dart';
import 'package:crystal_code/common/models/api_response_model.dart';
import 'package:crystal_code/data/datasource/remote/dio/dio_client.dart';
import 'package:crystal_code/data/datasource/remote/exception/api_error_handler.dart';
import 'package:crystal_code/features/sell/domain/models/store_data_model.dart';
import 'package:crystal_code/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class SellRepo {
  final DioClient? dioClient;
  SellRepo({
    required this.dioClient,
  });

  Future<ApiResponseModel> getUserListing(int offset, int? limit) async {
    try {
      Response response = await dioClient!
          .get('${AppConstants.getUserListing}?limit=$limit&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.Response> storeUserListing(
      StoreDataModel storeDataModel, List<XFile>? image, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.baseUrl}${AppConstants.storeUserListing}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    for (int i = 0; i < image!.length; i++) {
      File file = File(image[i].path);
      request.files.add(http.MultipartFile(
        'images[]',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ));
    }
    request.fields.addAll(storeDataModel.toJson());
    http.Response response =
        await http.Response.fromStream(await request.send());
    return response;
  }
}

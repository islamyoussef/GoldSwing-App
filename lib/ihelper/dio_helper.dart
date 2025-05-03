import 'package:dio/dio.dart';
import 'package:gold_swing/ihelper/shared_methods.dart';
import 'package:gold_swing/models/model_api_status.dart';
import 'package:gold_swing/models/model_metal.dart';
import 'api_endpoints.dart';
import 'shared_variables.dart';

class DioHelper {
  final Dio _dio = Dio();
  late ModelMetal modelMetal;
  late ModelApiStatus modelApiStatus;

  Future<ModelMetal> selectRecord(String categoryShortcut) async {
    try {
      String apiPersonalKey = await SharedMethods.apiKeyGet(mySharedPrefApiKey);

      // Configure Dio
      _dio.options.headers = {
        'x-access-token': apiPersonalKey,
        'Content-Type': 'application/json',
      };

      Response response = await _dio.get(
        '$apiEndPointMetal$categoryShortcut/EGP',
      );

      // response.statusCode
      if (response.data != null) {
        modelMetal = ModelMetal.fromJson(response.data);
        modelMetal.responseMsg = '200';
      }
    } catch (ex) {
      modelMetal = ModelMetal(
        timestamp: 0,
        metal: categoryShortcut,
        currency: "EGP",
        symbol: categoryShortcut,
        exchange: "",
        openTime: 0,
        price: 0,
        ch: 0,
        ask: 0,
        bid: 0,
        priceGram24K: 0,
        priceGram22K: 0,
        priceGram21K: 0,
        priceGram20K: 0,
        priceGram18K: 0,
        priceGram16K: 0,
        priceGram14K: 0,
        priceGram10K: 0,
        recordID: 0,
        responseMsg: 'Error happened while fetching data ${ex.toString()}',
      );
    }

    return modelMetal;
  }

  Future<ModelApiStatus> selectStatus() async {
    try {
      String apiPersonalKey = await SharedMethods.apiKeyGet(mySharedPrefApiKey);

      // Configure Dio
      _dio.options.headers = {
        'x-access-token': apiPersonalKey,
        'Content-Type': 'application/json',
      };

      Response response = await _dio.get(apiEndPointStatus);

      // response.statusCode
      if (response.data != null) {
        modelApiStatus = ModelApiStatus.fromJson(response.data);
        modelApiStatus.statusCode = response.statusCode ?? 0;
      }
    } catch (ex) {
      modelApiStatus = ModelApiStatus(
        requestsToday: 0,
        requestsYesterday: 0,
        requestsMonth: 0,
        requestsLastMonth: 0,
        statusCode: 401,
        statusMsg: 'Error while fetching API report ${ex.toString()}',
      );
    }

    return modelApiStatus;
  }
}

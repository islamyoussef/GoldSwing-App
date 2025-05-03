import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../ihelper/api_endpoints.dart';
import '../ihelper/hive_helper.dart';
import '../ihelper/shared_methods.dart';
import '../ihelper/shared_variables.dart';
import '../models/model_metal.dart';

part 'current_price_state.dart';

class CurrentPriceCubit extends Cubit<CurrentPriceState> {
  CurrentPriceCubit() : super(CurrentPriceInitial(ModelMetal()));

  final Dio _dio = Dio();
  late ModelMetal modelMetal;

  Future<ModelMetal> getCurrentPrice(String categoryShortcut) async {
    try {
      emit(CurrentPriceLoading());

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

        emit(CurrentPriceSuccess(modelMetal));
      }
    } catch (ex) {
      modelMetal = ModelMetal(
        responseMsg: 'Error happened while fetching data ${ex.toString()}',
      );

      emit(CurrentPriceError(modelMetal));
    }

    return modelMetal;
  }

  ModelMetal getLastRecordByCategory(String categoryName) {
    try {
      emit(CurrentPriceLoading());

      modelMetal = HiveHelper.selectOne(categoryName);

      emit(CurrentPriceSuccess(modelMetal));
    } catch (ex) {
      modelMetal = ModelMetal(
        recordID: 0,
        responseMsg: 'Error happened while fetching data ${ex.toString()}',
      );

      emit(CurrentPriceError(modelMetal));
    }

    return modelMetal;
  }
}

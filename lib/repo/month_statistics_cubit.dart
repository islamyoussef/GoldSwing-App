import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../ihelper/api_endpoints.dart';
import '../ihelper/shared_methods.dart';
import '../ihelper/shared_variables.dart';
import '../models/model_api_status.dart';

part 'month_statistics_state.dart';

class MonthStatisticsCubit extends Cubit<MonthStatisticsState> {
  MonthStatisticsCubit() : super(MonthStatisticsInitial());

  final Dio _dio = Dio();
  late ModelApiStatus modelApiStatus;

  Future getCurrentStatistics() async {
    try {
      emit(MonthStatisticsLoading());

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

        emit(MonthStatisticsSuccess(modelApiStatus));
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

      emit(MonthStatisticsError(modelApiStatus));
    }
  }
}

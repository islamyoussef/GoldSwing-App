part of 'month_statistics_cubit.dart';

@immutable
sealed class MonthStatisticsState {}

final class MonthStatisticsInitial extends MonthStatisticsState {}

final class MonthStatisticsLoading extends MonthStatisticsState {}

final class MonthStatisticsSuccess extends MonthStatisticsState {
  final ModelApiStatus modelApiStatus;

  MonthStatisticsSuccess(this.modelApiStatus);
}

final class MonthStatisticsError extends MonthStatisticsState {
  final ModelApiStatus modelApiStatus;

  MonthStatisticsError(this.modelApiStatus);
}

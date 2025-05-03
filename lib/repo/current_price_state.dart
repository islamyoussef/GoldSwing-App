part of 'current_price_cubit.dart';

@immutable
sealed class CurrentPriceState {}

final class CurrentPriceInitial extends CurrentPriceState {
  final ModelMetal modelMetal;
  CurrentPriceInitial(this.modelMetal);
}

final class CurrentPriceLoading extends CurrentPriceState {}

final class CurrentPriceSuccess extends CurrentPriceState {
  final ModelMetal modelMetal;
  CurrentPriceSuccess(this.modelMetal);
}

final class CurrentPriceError extends CurrentPriceState {
  final ModelMetal modelMetal;
  CurrentPriceError(this.modelMetal);
}

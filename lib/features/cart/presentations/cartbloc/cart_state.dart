part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

 class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}
class CartloadingState extends CartState {
  @override
  List<Object> get props => [];
}class AddCartloadingState extends CartState {
  @override
  List<Object> get props => [];
}
class CartfailiureState extends CartState {
  String error;

  CartfailiureState(this.error);

  @override
  List<Object> get props => [error];
}
class AddCartSuccessState extends CartState {
  AddToCartResponse response;

  AddCartSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class GetCartSuccessState extends CartState {
  CartItemsResponse response;

  GetCartSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class UpdateCartSuccessState extends CartState {
  UpdateCartItemsResponse response;

  UpdateCartSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class DeleteCartSuccessState extends CartState {
  DeleteItemsResponse response;

  DeleteCartSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class ShipingInfoSuccessState extends CartState {
  ShippingDetailsResponse response;

  ShipingInfoSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class StateBillingSuccessState extends CartState {
  StateBillingResponse response;

  StateBillingSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class StationBillingSuccessState extends CartState {
  StationStatesResponse response;

  StationBillingSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class CryptoPaySuccessState extends CartState {
  CryptoResponse response;
  CryptoPaySuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class CryptoSuccessState extends CartState {
  List<CryptoWalletPriceResponse> response;
  CryptoSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class PaymentRefSuccessState extends CartState {
  PaymentRefResponse response;
  PaymentRefSuccessState(this.response);
  @override
  List<Object> get props => [response];
}

class ApplyCouponSuccesssState extends CartState{
  CouponResponse response;

  ApplyCouponSuccesssState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
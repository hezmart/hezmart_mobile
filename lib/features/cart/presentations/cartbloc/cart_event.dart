part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddItemToCart extends CartEvent {
  AddToCartpayload payload;
  AddItemToCart(this.payload);
  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}

class GetCartEvent extends CartEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateCartEvent extends CartEvent {
  String id;
  UpdateCartPayload payload;
  UpdateCartEvent(this.id,this.payload);

  @override
  // TODO: implement props
  List<Object?> get props => [id,payload];
}
class DeleteItemCartEvent extends CartEvent {
  String id;

  DeleteItemCartEvent(this.id,);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetShippingInfoEvent extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class GetStatebillingEvent extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class GetStationbillingEvent extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class CryptoPayEvent extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class GetCryptoPriceEvent extends CartEvent {
  String name;
  GetCryptoPriceEvent(this.name);
  @override
  // TODO: implement props
  List<Object?> get props =>[name];

}
class GetPaymentRefEvent extends CartEvent {
  String ref;
  GetPaymentRefEvent(this.ref);
  @override
  // TODO: implement props
  List<Object?> get props =>[ref];

}
class CouponEvent extends CartEvent {
  CouponPayload payload;
  CouponEvent(this.payload);
  @override
  // TODO: implement props
  List<Object?> get props =>[payload];

}
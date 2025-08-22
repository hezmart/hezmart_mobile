part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}
class GetAllOrdersEvent extends OrderEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ReviewOrdersEvent extends OrderEvent {
  ReviewPayload payload;
  ReviewOrdersEvent(this.payload);

  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}
class UpdateOrdersEvent extends OrderEvent {
  UpdateOrderpayload payload ;
  String id;
  UpdateOrdersEvent(this.payload,this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}
class SingleOrdersEvent extends OrderEvent {
  String id;
  SingleOrdersEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

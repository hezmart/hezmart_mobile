part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

 class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}
 class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderFailiureState extends OrderState {
  String error;

  OrderFailiureState(this.error);

  @override
  List<Object> get props => [error];
}
class GetAllOrderSuccesState extends OrderState {
  GetAllOrdersResponse reponse;

  GetAllOrderSuccesState(this.reponse);

  @override
  List<Object> get props => [reponse];
}
class SingleOrderSuccesState extends OrderState {
  SingleOrdersResponse reponse;

  SingleOrderSuccesState(this.reponse);

  @override
  List<Object> get props => [reponse];
}
class RateOrderSuccesState extends OrderState {
  ReviewResponse response;


  RateOrderSuccesState(this.response);

  @override
  List<Object> get props => [];
}
class UpdateOrderSuccesState extends OrderState {



  UpdateOrderSuccesState();

  @override
  List<Object> get props => [];
}

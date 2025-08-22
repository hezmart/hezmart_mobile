part of 'order_payment_bloc.dart';

abstract class OrderPaymentEvent extends Equatable {
  const OrderPaymentEvent();
}


class OrderPayCryptoEvent extends OrderPaymentEvent {
      ConfirmOrderPickupDeliverypayload pickuppayload;

  OrderPayCryptoEvent(this.pickuppayload);

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class OrderPayTransferEvent extends OrderPaymentEvent {
  ConfirmOrderPickupDeliverypayload pickuppayload;
  OrderPayTransferEvent(this.pickuppayload);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

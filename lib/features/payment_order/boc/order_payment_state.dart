part of 'order_payment_bloc.dart';

abstract class OrderPaymentState extends Equatable {
  const OrderPaymentState();
}

class OrderPaymentInitial extends OrderPaymentState {
  @override
  List<Object> get props => [];
}

class OrderPaymentloadingState extends OrderPaymentState {
  @override
  List<Object> get props => [];
}

class OrderPaymentfailiureState extends OrderPaymentState {
  String error;

  OrderPaymentfailiureState(this.error);

  @override
  List<Object> get props => [];
}

class OrderPaymentTransferSuccessState extends OrderPaymentState {
  ConfirmOrderPickupTranferResponse response;
  OrderPaymentTransferSuccessState(this.response);
  @override
  List<Object> get props => [];
}

class OrderPaymentCryptoSuccessState extends OrderPaymentState {
  ConfirmOrderPickupCryptoResponse response;
  OrderPaymentCryptoSuccessState(this.response);
  @override
  List<Object> get props => [];
}

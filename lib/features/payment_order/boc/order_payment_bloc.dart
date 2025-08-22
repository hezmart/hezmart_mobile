import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/di/injector.dart';
import '../../cart/data/models/crypto_pay_response.dart';
import '../../cart/data/models/door_delivery_payload.dart';
import '../../cart/data/models/pickup_delivery_payload.dart';
import '../../cart/data/models/transfer_response.dart';
import '../../cart/presentations/cartbloc/cart_bloc.dart';
import '../domain/order_payment_repo.dart';

part 'order_payment_event.dart';
part 'order_payment_state.dart';

class OrderPaymentBloc extends Bloc<OrderPaymentEvent, OrderPaymentState> {
  OrderpaymentReposiotry reposiotry;
  OrderPaymentBloc(this.reposiotry) : super(OrderPaymentInitial()) {
    on<OrderPaymentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OrderPayCryptoEvent>(_mapOrderPayCryptoEventToState);
    on<OrderPayTransferEvent>(_mapOrderPayTransferEventToState);
  }

  Future<void> _mapOrderPayCryptoEventToState(
    OrderPayCryptoEvent event,
    Emitter<OrderPaymentState> emit,
  ) async {
    emit(OrderPaymentloadingState());
    try {
      var response=await  reposiotry.paywithCrypto(event.pickuppayload);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(OrderPaymentCryptoSuccessState(response));
    }  catch (e) {
      emit(OrderPaymentfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  FutureOr<void> _mapOrderPayTransferEventToState(
    OrderPayTransferEvent event,
    Emitter<OrderPaymentState> emit,
  ) async {
    emit(OrderPaymentloadingState());
    try {
      var response=await  reposiotry.paywithTransfer(event.pickuppayload);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(OrderPaymentTransferSuccessState(response));
    }  catch (e) {
      emit(OrderPaymentfailiureState(e.toString()));
      rethrow;
      // TODO
    }
}}

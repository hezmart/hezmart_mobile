import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/cart/data/models/cart_payload.dart';
import 'package:hezmart/features/cart/data/models/cart_response.dart';
import 'package:hezmart/features/cart/data/models/updatecart.dart';
import 'package:hezmart/features/cart/domain/cart_repo/cart_repo.dart';

import '../../../../core/di/injector.dart';
import '../../data/models/cartitems_response.dart';
import '../../data/models/coupon_response.dart';
import '../../data/models/couponpayload.dart';
import '../../data/models/crytpo_response.dart';
import '../../data/models/delete_item_response.dart';
import '../../data/models/ref.dart';
import '../../data/models/shipping_details.dart';
import '../../data/models/statebiling.dart';
import '../../data/models/station_states.dart';
import '../../data/models/update_payload.dart';
import '../../data/models/wallet_response.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository repository;
  CartBloc(this.repository) : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddItemToCart>(_mapAddItemToCartEventToState);
    on<GetCartEvent>(_mapGetCartEventToState);
    on<UpdateCartEvent>(_mapUpdateCartEventToState);
    on<DeleteItemCartEvent>(_mapDeleteItemCartEventToState);
    on<GetShippingInfoEvent>(_mapGetShippingInfoEventToState);
    on<GetStatebillingEvent>(_mapGetStatebillingEventToState);
    on<GetStationbillingEvent>(_mapGetStationbillingEventToState);
    on<CryptoPayEvent>(_mapCryptoPayEventToState);
    on<GetCryptoPriceEvent>(_mapGetCryptoPriceEventToState);
    on<GetPaymentRefEvent>(_mapGetPaymentRefEventToState);
    on<CouponEvent>(_mapCouponEventToState);

  }

  Future<void> _mapAddItemToCartEventToState(
    AddItemToCart event,
    Emitter<CartState> emit,
  ) async {
    emit(AddCartloadingState());
    try {
      var response = await repository.addcart(event.payload);
      emit(AddCartSuccessState(response));
      injector.get<CartBloc>().add(GetCartEvent());
    } catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetCartEventToState(GetCartEvent event, Emitter<CartState> emit

      ) async {
    emit(CartloadingState());
    try {
      var response=await repository.getcart();
      emit(GetCartSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapUpdateCartEventToState(UpdateCartEvent event, Emitter<CartState> emit
      ) async {
    emit(CartloadingState());
    try {
      var response=await repository.updatecart(event.id,event.payload);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(UpdateCartSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapDeleteItemCartEventToState(DeleteItemCartEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());
    try {
      var response=await repository.removeItemcart(event.id,);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(DeleteCartSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetShippingInfoEventToState(GetShippingInfoEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());

    try {
      var response=await repository.deliveryoption();
      emit(ShipingInfoSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetStatebillingEventToState(GetStatebillingEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());
    try {
      var response=await repository.statebilling();
      emit(StateBillingSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetStationbillingEventToState(GetStationbillingEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());

    try {
      var response=await repository.stationbilling();
      emit(StationBillingSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapCryptoPayEventToState(CryptoPayEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());

    try {
      var response=await repository.crypto_pay();
      emit(CryptoPaySuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetCryptoPriceEventToState(GetCryptoPriceEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());
    try {
      var response=await repository.getprice(event.name);
      emit(CryptoSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
    }

  }


  Future<void> _mapGetPaymentRefEventToState(GetPaymentRefEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());
    try {
      var response=await repository.paymentref(event.ref);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(PaymentRefSuccessState(response));
    }  catch (e) {
      emit(CartfailiureState(e.toString()));
      rethrow;
    }
  }

  Future<void> _mapCouponEventToState(CouponEvent event, Emitter<CartState> emit) async {
    emit(CartloadingState());
    try {
      var response=await repository.coupon(event.payload);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(ApplyCouponSuccesssState(response));
    }  catch (e) {

      emit(CartfailiureState(e.toString()));
      injector.get<CartBloc>().add(GetCartEvent());


      rethrow;
    }
  }
}

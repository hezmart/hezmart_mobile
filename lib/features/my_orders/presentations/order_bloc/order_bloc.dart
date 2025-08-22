import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/my_orders/data/models/review.dart';
import 'package:hezmart/features/my_orders/domain/order_repository.dart';

import '../../../../core/di/injector.dart';
import '../../../cart/presentations/cartbloc/cart_bloc.dart';
import '../../data/models/all_orders.dart';
import '../../data/models/review_response.dart';
import '../../data/models/single_order.dart';
import '../../data/models/update_order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository repository;
  OrderBloc(this.repository) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllOrdersEvent>(_mapGetAllOrdersEventToState);
    on<SingleOrdersEvent>(_mapSingleOrdersEventToState);
    on<ReviewOrdersEvent>(_mapReviewOrdersEventToState);
    on<UpdateOrdersEvent>(_mapUpdateOrdersEventToState);
  }

  Future<void> _mapGetAllOrdersEventToState(GetAllOrdersEvent event, Emitter<OrderState> emit) async {

    emit(OrderLoadingState());
    try {
      var response=await repository.allorders();
      injector.get<CartBloc>().add(GetCartEvent());
      emit(GetAllOrderSuccesState(response));
    }  catch (e) {
      emit(OrderFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapSingleOrdersEventToState(SingleOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    try {
      var response=await repository.singleorders(event.id);
      emit(SingleOrderSuccesState(response));
    }  catch (e) {
      emit(OrderFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }
  Future<void> _mapReviewOrdersEventToState(ReviewOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    try {
      var response=await repository.rateItem(event.payload);
      // injector.get<OrderBloc>().add(SingleOrdersEvent());
      emit(RateOrderSuccesState(response));
    }  catch (e) {
      emit(OrderFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapUpdateOrdersEventToState(UpdateOrdersEvent event, Emitter<OrderState> emit
      ) async {
    emit(OrderLoadingState());
    try {
      var response=await repository.updateItem(event.id,event.payload);
      emit(UpdateOrderSuccesState());
    }  catch (e) {
      emit(OrderFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }
}

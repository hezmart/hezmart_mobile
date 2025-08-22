import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/homescreen/data/models/getall_products.dart';
import 'package:hezmart/features/homescreen/data/models/singleproduct_response.dart';
import 'package:hezmart/features/homescreen/domain/product_repo/product_repo.dart';

import '../../../../core/di/injector.dart';
import '../../../cart/presentations/cartbloc/cart_bloc.dart';
import '../../data/models/getvendors.dart';
import '../../data/models/vendor_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository repository;
  ProductsBloc(this.repository) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetAllProductsEvent>(_mapGetAllProductsEventToState);
    on<SingleProductsEvent>(_mapSingleProductsEventToState);
    on<GetAllVendorsEvent>(_mapGetAllVendorsEventToState);
    on<VendorProductsEvent>(_mapVendorProductsEventToState);
  }

  Future<void> _mapGetAllProductsEventToState(
    GetAllProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsloadingState());
    try {
      var response = await repository.getallProduct();
      injector.get<CartBloc>().add(GetCartEvent());
      emit(ProductsSuccessState(response));
    } catch (e) {
      emit(ProductsFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapSingleProductsEventToState(
    SingleProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsloadingState());
    try {
      var response = await repository.singleProduct(event.id);
      injector.get<CartBloc>().add(GetCartEvent());
      emit(SingleProductSuccessState(response));
    } catch (e) {
      emit(ProductsFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetAllVendorsEventToState(GetAllVendorsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsloadingState());
    try {
      var response=await repository.getvendors();
      emit(GetVendorsSuccessState(response));
    }  catch (e) {
      emit(ProductsFailiureState(e.toString()));
      // TODO
    }

  }

  Future<void> _mapVendorProductsEventToState(VendorProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsloadingState());
    try {
      var response=await repository.vendorsproduct(event.id);
      emit(GetVendorsProductSuccessState(response));
    }  catch (e) {
      emit(ProductsFailiureState(e.toString()));

      // TODO
    }
  }
}
//
//
//
//
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// TextView(text: "Other similar Products",fontSize: 16,fontWeight: FontWeight.w500,),
// Row(
// children: List.generate(5, (similarIndex)=>Container(
// padding: EdgeInsets.all(10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Pallets.grey95
// ),
// child: ImageWidget(imageUrl: "assets/images/pngs/phone.png"),
//
// )),
// )
// ],
// ),
// ),
// 40.verticalSpace,
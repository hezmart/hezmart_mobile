part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

 class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}
 class ProductsloadingState extends ProductsState {
  @override
  List<Object> get props => [];
} 

 class ProductsFailiureState extends ProductsState {
  String error;
  ProductsFailiureState(this.error);
  @override
  List<Object> get props => [error];

}
class ProductsSuccessState extends ProductsState {
  GetAllProductsResponse response;
  ProductsSuccessState(this.response);
  @override
  List<Object> get props => [this.response];
}
class SingleProductSuccessState extends ProductsState {
  SingleProductsResponse response;
  SingleProductSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class GetVendorsSuccessState extends ProductsState {
  GetVendorsResponse response;
  GetVendorsSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class GetVendorsProductSuccessState extends ProductsState {
  VendorProductsResponse response;
  GetVendorsProductSuccessState(this.response);
  @override
  List<Object> get props => [response];
}

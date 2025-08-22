part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetAllProductsEvent extends ProductsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}class GetAllVendorsEvent extends ProductsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SingleProductsEvent extends ProductsEvent {
  String id;

  SingleProductsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class VendorProductsEvent extends ProductsEvent {
  String id;

  VendorProductsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

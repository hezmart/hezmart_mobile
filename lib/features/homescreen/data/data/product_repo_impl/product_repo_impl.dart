import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/homescreen/data/models/getall_products.dart';
import 'package:hezmart/features/homescreen/data/models/getvendors.dart';
import 'package:hezmart/features/homescreen/data/models/singleproduct_response.dart';
import 'package:hezmart/features/homescreen/data/models/vendor_products.dart';
import 'package:hezmart/features/homescreen/domain/product_repo/product_repo.dart';

class ProductRepositoryImpl extends ProductRepository {
  NetworkService networkService;

  ProductRepositoryImpl(this.networkService);

  @override
  Future<GetAllProductsResponse> getallProduct() async {
    var response = await networkService.call(
      UrlConfig.allproducts,
      RequestMethod.get,
    );
    return GetAllProductsResponse.fromJson(response.data);
  }

  @override
  Future<SingleProductsResponse> singleProduct(String id) async {
    var response = await networkService.call(
      "${UrlConfig.singleproducts}$id",
      RequestMethod.get,
    );
    return SingleProductsResponse.fromJson(response.data);
  }

  @override
  Future<GetVendorsResponse> getvendors() async {
    var response = await networkService.call(
      UrlConfig.getvendor,
      RequestMethod.get,
    );
    return GetVendorsResponse.fromJson(response.data);
  }

  @override
  Future<VendorProductsResponse> vendorsproduct(String id) async {
    var response = await networkService.call(
      UrlConfig.getvendorproducts,
      RequestMethod.get,
      queryParams: {"userId":id}
    );
    return VendorProductsResponse.fromJson(response.data);
  }
}

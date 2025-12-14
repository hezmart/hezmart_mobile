import 'package:hezmart/features/homescreen/data/models/getall_products.dart';
import 'package:hezmart/features/homescreen/data/models/getvendors.dart';

import '../../data/models/hot_response.dart';
import '../../data/models/last_viewed_response.dart';
import '../../data/models/singleproduct_response.dart';
import '../../data/models/vendor_products.dart';

abstract class ProductRepository{
  Future<GetAllProductsResponse>getallProduct();
  Future<HotSalesResponse>getHotProduct();
  Future<LastViewedResponse>last_viewd();
  Future<SingleProductsResponse>singleProduct(String id);
  Future<GetVendorsResponse>getvendors();
  Future<VendorProductsResponse>vendorsproduct(String id);

}
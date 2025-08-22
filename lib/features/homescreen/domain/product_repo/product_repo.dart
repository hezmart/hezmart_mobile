import 'package:hezmart/features/homescreen/data/models/getall_products.dart';
import 'package:hezmart/features/homescreen/data/models/getvendors.dart';

import '../../data/models/singleproduct_response.dart';
import '../../data/models/vendor_products.dart';

abstract class ProductRepository{
  Future<GetAllProductsResponse>getallProduct();
  Future<SingleProductsResponse>singleProduct(String id);
  Future<GetVendorsResponse>getvendors();
  Future<VendorProductsResponse>vendorsproduct(String id);

}
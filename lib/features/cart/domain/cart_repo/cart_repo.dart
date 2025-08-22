import 'package:hezmart/features/cart/data/models/cart_payload.dart';
import 'package:hezmart/features/cart/data/models/cart_response.dart';
import 'package:hezmart/features/cart/data/models/shipping_details.dart';
import 'package:hezmart/features/cart/data/models/station_states.dart';
import 'package:hezmart/features/cart/data/models/updatecart.dart';

import '../../data/models/cartitems_response.dart';
import '../../data/models/coupon_response.dart';
import '../../data/models/couponpayload.dart';
import '../../data/models/crytpo_response.dart';
import '../../data/models/delete_item_response.dart';
import '../../data/models/ref.dart';
import '../../data/models/statebiling.dart';
import '../../data/models/update_payload.dart';
import '../../data/models/wallet_response.dart';

abstract class CartRepository{

  Future<AddToCartResponse>addcart(AddToCartpayload payload);
  Future<CartItemsResponse>getcart();
  Future<UpdateCartItemsResponse>updatecart(String id,UpdateCartPayload payload);
  Future<DeleteItemsResponse>removeItemcart(String id);
  Future<ShippingDetailsResponse>deliveryoption();
  Future<StateBillingResponse>statebilling();
  Future<StationStatesResponse>stationbilling();
  Future<CryptoResponse>crypto_pay();
  Future<PaymentRefResponse>paymentref(String ref);
  Future<CouponResponse>coupon(CouponPayload payload);
  Future<List<CryptoWalletPriceResponse>>getprice(String name);
}
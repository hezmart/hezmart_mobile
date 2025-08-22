import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/cart/data/models/cart_payload.dart';

import 'package:hezmart/features/cart/data/models/cart_response.dart';
import 'package:hezmart/features/cart/data/models/cartitems_response.dart';
import 'package:hezmart/features/cart/data/models/couponpayload.dart';
import 'package:hezmart/features/cart/data/models/crytpo_response.dart';
import 'package:hezmart/features/cart/data/models/ref.dart';
import 'package:hezmart/features/cart/data/models/shipping_details.dart';
import 'package:hezmart/features/cart/data/models/statebiling.dart';
import 'package:hezmart/features/cart/data/models/station_states.dart';
import 'package:hezmart/features/cart/data/models/updatecart.dart';

import '../../domain/cart_repo/cart_repo.dart';
import '../models/coupon_response.dart';
import '../models/delete_item_response.dart';
import '../models/update_payload.dart';
import '../models/wallet_response.dart';

class CartRepositoryImpl extends CartRepository {
  NetworkService networkService;
  CartRepositoryImpl(this.networkService);
  @override
  Future<AddToCartResponse> addcart(AddToCartpayload payload) async {
    var response = await networkService.call(
      UrlConfig.addcart,
      RequestMethod.post,
      data: payload.toJson(),
    );
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<CartItemsResponse> getcart() async {
    var response = await networkService.call(
      UrlConfig.getcart,
      RequestMethod.get,
    );
    return CartItemsResponse.fromJson(response.data);
  }

  @override
  Future<UpdateCartItemsResponse> updatecart(
    String id,
    UpdateCartPayload payload,
  ) async {
    var response = await networkService.call(
      "${UrlConfig.updatecart}$id",
      RequestMethod.patch,
      data: payload.toJson(),
    );
    return UpdateCartItemsResponse.fromJson(response.data);
  }

  @override
  Future<DeleteItemsResponse> removeItemcart(String id) async {
    var response = await networkService.call(
      "${UrlConfig.removeItemcart}$id",
      RequestMethod.delete,
    );
    return DeleteItemsResponse.fromJson(response.data);
  }

  @override
  Future<ShippingDetailsResponse> deliveryoption() async {
    var response = await networkService.call(
      UrlConfig.shippingdetails,
      RequestMethod.get,
    );
    return ShippingDetailsResponse.fromJson(response.data);
  }

  @override
  Future<StateBillingResponse> statebilling() async {
    var response = await networkService.call(
      UrlConfig.statebilling,
      RequestMethod.get,
    );
    return StateBillingResponse.fromJson(response.data);
  }

  @override
  Future<StationStatesResponse> stationbilling() async {
    var response = await networkService.call(
      UrlConfig.pickupstation,
      RequestMethod.get,
    );
    return StationStatesResponse.fromJson(response.data);
  }

  @override
  Future<CryptoResponse> crypto_pay() async {
    var response = await networkService.call(
      UrlConfig.crypto_pay,
      RequestMethod.get,
    );
    return CryptoResponse.fromJson(response.data);
  }

  @override
  Future<List<CryptoWalletPriceResponse>> getprice(String name) async {
    var response = await networkService.call(
      "${UrlConfig.crypto_price}$name",
      RequestMethod.get,
    );

    if (response.data is List) {
      return (response.data as List<dynamic>)
          .map(
            (item) => CryptoWalletPriceResponse.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception("Unexpected response format: Expected a list");
    }
    // return CryptoWalletPriceResponse.fromJson(response.data);
  }

  @override
  Future<PaymentRefResponse> paymentref(String ref) async {
    var response = await networkService.call(
      "${UrlConfig.verifyOrder}$ref",
      RequestMethod.get,
    );
    return PaymentRefResponse.fromJson(response.data);
  }

  @override
  Future<CouponResponse> coupon(CouponPayload payload) async {
    var response = await networkService.call(
      UrlConfig.coupon,
      RequestMethod.post,
      data: payload.toJson(),
    );
    return CouponResponse.fromJson(response.data);
  }
}

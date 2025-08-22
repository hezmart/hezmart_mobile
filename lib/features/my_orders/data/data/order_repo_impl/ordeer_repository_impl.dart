import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/my_orders/data/models/all_orders.dart';
import 'package:hezmart/features/my_orders/data/models/review.dart';
import 'package:hezmart/features/my_orders/data/models/single_order.dart';
import 'package:hezmart/features/my_orders/domain/order_repository.dart';

import '../../models/review_response.dart';
import '../../models/update_order.dart';

class OrderRepositoryImpl extends OrderRepository {
  NetworkService networkService;
  OrderRepositoryImpl(this.networkService);
  @override
  Future<GetAllOrdersResponse> allorders() async {
    var response = await networkService.call(
      UrlConfig.allorders,
      RequestMethod.get,
    );
    return GetAllOrdersResponse.fromJson(response.data);
  }

  @override
  Future<SingleOrdersResponse> singleorders(String id) async {
    var response = await networkService.call(
      "${UrlConfig.singleeorders}$id",
      RequestMethod.get,
    );

    return SingleOrdersResponse.fromJson(response.data);
  }

  @override
  Future<ReviewResponse> rateItem(ReviewPayload payload) async {
    var response = await networkService.call(
      UrlConfig.rate,
      RequestMethod.post,
      data: payload.toJson(),
    );
    return response.data;
  }

  @override
  Future updateItem(String id, UpdateOrderpayload payload) async {
    var response = await networkService.call(
      "${UrlConfig.updateOrder}$id/status",
      RequestMethod.patch,
      data: payload.toJson(),
    );
    return response.data;
  }
}

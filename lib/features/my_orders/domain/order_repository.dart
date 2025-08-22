import 'package:hezmart/features/my_orders/data/models/single_order.dart';

import '../data/models/all_orders.dart';
import '../data/models/review.dart';
import '../data/models/review_response.dart';
import '../data/models/update_order.dart';

abstract class OrderRepository {
  Future<GetAllOrdersResponse>allorders();
  Future<SingleOrdersResponse>singleorders(String id);
  Future<ReviewResponse>rateItem(ReviewPayload payload);
  Future<dynamic>updateItem(String id,UpdateOrderpayload payload);
}
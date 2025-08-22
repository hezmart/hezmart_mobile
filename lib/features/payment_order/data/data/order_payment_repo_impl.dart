import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/cart/data/models/door_delivery_payload.dart';

import 'package:hezmart/features/cart/data/models/pickup_delivery_payload.dart';
import 'package:hezmart/features/cart/data/models/transfer_response.dart';

import '../../../cart/data/models/crypto_pay_response.dart';
import '../../domain/order_payment_repo.dart';

class OrderpaymentReposiotryImpl extends OrderpaymentReposiotry {
  NetworkService networkService;
  OrderpaymentReposiotryImpl(this.networkService);
  @override
  Future<ConfirmOrderPickupTranferResponse> paywithTransfer(

    ConfirmOrderPickupDeliverypayload pickuppayload,
  ) async {
    var response = await networkService.call(
      UrlConfig.paytransfer,
      RequestMethod.post,
      data: pickuppayload.toJson(),
    );
    return ConfirmOrderPickupTranferResponse.fromJson(response.data);
  }

  @override
  Future<ConfirmOrderPickupCryptoResponse> paywithCrypto(
    ConfirmOrderPickupDeliverypayload pickuppayload,
  ) async {
    var response = await networkService.call(
      UrlConfig.paycrypto,
      RequestMethod.post,
      data: pickuppayload.toJson(),
    );
    return ConfirmOrderPickupCryptoResponse.fromJson(response.data);
  }
}

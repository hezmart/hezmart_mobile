import 'package:hezmart/features/cart/data/models/pickup_delivery_payload.dart';
import 'package:hezmart/features/cart/data/models/transfer_response.dart';

import '../../cart/data/models/crypto_pay_response.dart';
import '../../cart/data/models/door_delivery_payload.dart';

abstract class OrderpaymentReposiotry{

  Future<ConfirmOrderPickupTranferResponse>paywithTransfer(ConfirmOrderPickupDeliverypayload pickuppayload);
  Future<ConfirmOrderPickupCryptoResponse>paywithCrypto(ConfirmOrderPickupDeliverypayload pickuppayload);
}
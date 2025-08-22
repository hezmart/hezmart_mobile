import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/wishlist/data/models/fav_reponse.dart';
import 'package:hezmart/features/wishlist/data/models/like_response.dart';
import 'package:hezmart/features/wishlist/domain/repossitory.dart';

class MyfavouritesRepositoryImpl extends MyfavouritesRepository {
  NetworkService networkService;
  MyfavouritesRepositoryImpl(this.networkService);
  @override
  Future<MyFavouriteResponse> getmylike() async {
    var response = await networkService.call(
      UrlConfig.viewlikeitem,
      RequestMethod.get,
    );
    return MyFavouriteResponse.fromJson(response.data);
  }

  @override
  Future<ItemlikeResponse> like(String id) async {
    var response = await networkService.call(
      "${UrlConfig.likeitem}$id/likes/toggle",
      RequestMethod.post,
    );
    return ItemlikeResponse.fromJson(response.data);
  }
}

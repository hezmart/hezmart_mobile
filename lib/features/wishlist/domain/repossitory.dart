import '../data/models/fav_reponse.dart';
import '../data/models/like_response.dart';

abstract class MyfavouritesRepository{
  Future<ItemlikeResponse>like(String id);
  Future<MyFavouriteResponse>getmylike();
}
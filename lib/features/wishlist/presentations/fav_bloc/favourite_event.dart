part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}


class LikeItemEvent extends FavouriteEvent {

  String id;

  LikeItemEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// class LikeItemEvent extends FavouriteEvent {
//
//   String id;
//
//   LikeItemEvent(this.id);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
class UnlikeItemEvent extends FavouriteEvent {

  String id;

  UnlikeItemEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetfavouriteEvent extends FavouriteEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

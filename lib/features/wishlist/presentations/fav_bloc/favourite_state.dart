part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

 class FavouriteInitial extends FavouriteState {
  @override
  List<Object> get props => [];
}

 class FavouriteloadingState extends FavouriteState {
  @override
  List<Object> get props => [];
}

 class FavouritefailiureState extends FavouriteState {
  String error;

  FavouritefailiureState(this.error);

  @override
  List<Object> get props => [];
}

 class FavouritelikeSuccessState extends FavouriteState {
   ItemlikeResponse response;
   final String productId;

   FavouritelikeSuccessState(this.response,this.productId);

  @override
  List<Object> get props => [];
}

 class FavouriteUnlikeSuccessState extends FavouriteState {
   ItemlikeResponse response;
   final String productId;

   FavouriteUnlikeSuccessState(this.response,this.productId);

  @override
  List<Object> get props => [];
}



 class FavouriteGetSuccessState extends FavouriteState {
   MyFavouriteResponse response;

   FavouriteGetSuccessState(this.response);

  @override
  List<Object> get props => [];
}

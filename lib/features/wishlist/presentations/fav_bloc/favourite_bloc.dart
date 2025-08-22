import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/wishlist/domain/repossitory.dart';

import '../../../../core/di/injector.dart';
import '../../data/models/fav_reponse.dart';
import '../../data/models/like_response.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  MyfavouritesRepository repository;
  FavouriteBloc(this.repository) : super(FavouriteInitial()) {
    on<FavouriteEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LikeItemEvent>(_mapLikeItemEventToState);
    on<UnlikeItemEvent>(_mapUnlikeItemEventToState);
    on<GetfavouriteEvent>(_mapGetfavouriteEventToState);
  }

  Future<void> _mapGetfavouriteEventToState(
    GetfavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    emit(FavouriteloadingState());
    try {
      var response = await repository.getmylike();
      emit(FavouriteGetSuccessState(response));
    } catch (e) {
      emit(FavouritefailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapLikeItemEventToState(
    LikeItemEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    emit(FavouriteloadingState());
    try {
      var response = await repository.like(event.id);
      injector.get<FavouriteBloc>().add(GetfavouriteEvent());
      emit(FavouritelikeSuccessState(response,event.id));
    } catch (e) {
      emit(FavouritefailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapUnlikeItemEventToState(UnlikeItemEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteloadingState());
    try {
      var response = await repository.like(event.id);
      injector.get<FavouriteBloc>().add(GetfavouriteEvent());
      emit(FavouriteUnlikeSuccessState(response,event.id));
    } catch (e) {
      emit(FavouritefailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }
}

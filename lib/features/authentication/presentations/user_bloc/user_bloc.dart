import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../common/database/local/userstorage.dart';
import '../../data/models/authsuccess_response.dart';

part 'user_event.dart';

part 'user_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final _userStorage = UserStorage();
//   HezmartUser? appUser;
//
//   UserBloc() : super(UserInitial()) {
//     on<UserEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//     on<SaveUserEvent>(_mapSaveUserEventToState);
//     on<GetUserEvent>(_mapGetUserEventToState);
//   }
//
//   FutureOr<void> _mapSaveUserEventToState(SaveUserEvent event,
//       Emitter<UserState> emit) {
//     _userStorage.saveUser(event.appUser);
//     appUser = event.appUser;
//     emit(UserCachedState(event.appUser));
//   }
//
//   FutureOr<void> _mapGetUserEventToState(GetUserEvent event,
//       Emitter<UserState> emit) async {
//     var user = await _userStorage.getUser();
//     if (user != null) {
//       appUser = AuthSuccessResponse.fromJson(user);
//       emit(UserCachedState(appUser!));
//     }
//   }
// }

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userStorage = UserStorage();
  HezmartUser? appUser;
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SaveUserEvent>(_mapSaveUserEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<UpdateUserEvent>(_mapUpdateUserEventToState);
  }

  FutureOr<void> _mapSaveUserEventToState(
      SaveUserEvent event, Emitter<UserState> emit) {
    _userStorage.saveUser(event.appUser);
    appUser = event.appUser;
    emit(UserCachedState(event.appUser));
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<UserState> emit) async {
    var user = await _userStorage.getUser();
    if (user != null) {
      appUser =HezmartUser.fromJson(user as Map<String,dynamic>) ;
      emit(UserCachedState(appUser!));
    }
  }

  FutureOr<void> _mapUpdateUserEventToState(
      UpdateUserEvent event,
      Emitter<UserState> emit
      ) {
    appUser = event.user;
    _userStorage.saveUser(event.user);
    emit(UserCachedState(event.user));
  }
}
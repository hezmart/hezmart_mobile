import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hezmart/features/notificationss/data/models/token_payload.dart';
import 'package:hezmart/features/notificationss/domain/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  NotificationRepository repository;

  NotificationBloc(this.repository) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NotiTokenSentEvent>(_mapNotiTokenSentEventToState);
  }



  Future<void> _mapNotiTokenSentEventToState(NotiTokenSentEvent event, Emitter<NotificationState> emit
      ) async {

    try {
      emit(NotificationLoadingState());
      var response=await repository.sendToken(event.payload);
      emit(NotificationSuccessState());
    }  catch (e) {
      emit(NotificationFailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }
}

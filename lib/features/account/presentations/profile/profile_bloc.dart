import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/account/domain/repo/profile_repo.dart';
import 'package:hezmart/features/authentication/data/models/authsuccess_response.dart';

import '../../../../core/di/injector.dart';
import '../../../authentication/presentations/user_bloc/user_bloc.dart';
import '../../data/models/edit_pro_response.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository repository;
  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<EditprofileEvent>(_mapEditprofileEventToState);
    on<GetProfileEvent>(_mapGetProfileEventToState);
  }

  Future<void> _mapEditprofileEventToState(
      EditprofileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileloadingState());
    try {
      var response = await repository.editprofile(
          event.firstname,
          event.lastname,
          event.number,
          event.address,
          event.state
      );

      // Get the current user from UserBloc
      final userBloc = injector.get<UserBloc>();
      final currentUser = userBloc.appUser;

      if (currentUser != null) {
        // Create updated user with new data
        final updatedUser = currentUser.copyWith(
          firstName: event.firstname,
          lastName: event.lastname,
          primaryPhone: event.number,
          primaryAddress: event.address,
          state: event.state,
        );

        // Update UserBloc with the new user data
        userBloc.add(UpdateUserEvent(updatedUser));
      }

      emit(ProfileSuccessState(response));
    } catch (e) {
      emit(ProfilefailiureState(e.toString()));
      rethrow;
    }
  }

  Future<void> _mapGetProfileEventToState(GetProfileEvent event, Emitter<ProfileState> emit) async {
      emit(ProfileloadingState());
      try {
        var response=await  repository.profile();
        // injector.get<UserBloc>().add(SaveUserEvent(response.data!));
        // injector.get<UserBloc>().add(SaveUserEvent(response.data!));
        emit(ProfileSuccessState(response));
      }  catch (e) {
        emit(ProfilefailiureState(e.toString()));
        rethrow;
        // TODO
    }}
}

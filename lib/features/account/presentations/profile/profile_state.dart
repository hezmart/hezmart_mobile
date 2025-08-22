part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

 class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
 class ProfileloadingState extends ProfileState {
  @override
  List<Object> get props => [];
}
 class ProfilefailiureState extends ProfileState {
  String error;

  ProfilefailiureState(this.error);

  @override
  List<Object> get props => [];
}
 class ProfileSuccessState extends ProfileState {
  EditprofileResponse response;

  ProfileSuccessState(this.response);

  @override
  List<Object> get props => [];
}



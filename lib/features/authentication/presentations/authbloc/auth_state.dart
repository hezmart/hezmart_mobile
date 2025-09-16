part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

 class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthloadingState extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthfailiureState extends AuthState {
  String error;
  ErrorResponse? response;

  AuthfailiureState(this.error,);

  @override
  List<Object> get props => [error];
}
class AuthSuccessState extends AuthState {
 AuthSuccessResponse response;

 AuthSuccessState(this.response);

  @override
  List<Object> get props => [response];
}class AuthGoogleSuccessState extends AuthState {
 AuthSuccessResponse response;

 AuthGoogleSuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class OtpSuccessState extends AuthState {
  VerifySignUpOtpResponse response;
  OtpSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class ForgotSuccessState extends AuthState {
  ForgotPasswordResponse response;
  ForgotSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class ResendOtpSuccessState extends AuthState {
  ResendOtpResponse response;
  ResendOtpSuccessState(this.response);
  @override
  List<Object> get props => [response];
}


class SignOutSuccessState extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
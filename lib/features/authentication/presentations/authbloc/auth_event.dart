part of 'auth_bloc.dart';

 abstract class AuthEvent extends Equatable {
  const AuthEvent();
}
class SignInEvent extends AuthEvent {
   String email;
   String password;

   SignInEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}
class OtpEvent extends AuthEvent {
  VerifySignUpOtpPayload payload;
   OtpEvent( this.payload);

  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}
class ForgotPasEvent extends AuthEvent {
  ForgotPasswordPayload payload;

   ForgotPasEvent( this.payload);

  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}


class SignUpEvent extends AuthEvent {
  SignUpPayload payload;

  SignUpEvent(this.payload);

  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}

class ResendOTpSignUpEvent extends AuthEvent {
  String email;

  ResendOTpSignUpEvent(this.email);

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}


class GoogleSignUpEvent extends AuthEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}class CreateNewPasswordEvent extends AuthEvent{

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class SignOutEvent extends AuthEvent{

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
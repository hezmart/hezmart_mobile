import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/authentication/data/models/authsuccess_response.dart';
import 'package:hezmart/features/authentication/data/models/signup_payload.dart';
import 'package:hezmart/features/authentication/domain/repo/authrepository.dart';
import 'package:hezmart/features/authentication/domain/usecase/auth_success_usecase.dart';
import 'package:logger/logger.dart';

import '../../data/models/error_response.dart';
import '../../data/models/forgot_password_res.dart';
import '../../data/models/forgotpayload.dart';
import '../../data/models/resendOtp.dart';
import '../../data/models/verify_signUp.dart';
import '../../data/models/verify_signup_res.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignInEvent>(_mapSignInEventToState);
    on<SignUpEvent>(_mapSignUpEventToState);
    on<OtpEvent>(_mapSOtpEventToState);
    on<ForgotPasEvent>(_mapForgotPasEventToState);
    on<ResendOTpSignUpEvent>(_mapResendOTpSignUpEventToState);
    on<GoogleSignUpEvent>(_mapGoogleSignUpEventToState);
    on<CreateNewPasswordEvent>(_mapCreateNewPasswordEventToState);
    on<SignOutEvent>(_mapSignOutEventToState);
  }

  Future<void> _mapSignInEventToState(SignInEvent event, Emitter<AuthState> emit
      ) async {
    emit(AuthloadingState());
    try {
      var response=await repository.signin(event.email, event.password);
      AuthSuccessUseCase().execute(response);
      emit(AuthSuccessState(response));
    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapSignUpEventToState(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    try {
      var response=await repository.signup(event.payload);
      emit(AuthSuccessState(response));
    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      rethrow;
      // TODO
    }

  }

  Future<void> _mapSOtpEventToState(OtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    try {
      var response =await repository.verify(event.payload);
      emit(OtpSuccessState(response));

    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      rethrow;
      // TODO
    }

  }

  Future<void> _mapForgotPasEventToState(ForgotPasEvent event, Emitter<AuthState> emit) async {

    emit(AuthloadingState());
    try {
      var response=await repository.forgotpassword(event.payload);
      emit(ForgotSuccessState(response));
    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapResendOTpSignUpEventToState(ResendOTpSignUpEvent event, Emitter<AuthState> emit
      ) async {
    emit(AuthloadingState());
    try {
      var response=await repository.resendOtp(event.email);
      emit(ResendOtpSuccessState(response));
    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGoogleSignUpEventToState(GoogleSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    try {
      var response=await repository.authenticateWithGoogle();
      AuthSuccessUseCase().execute(response);
      emit(AuthGoogleSuccessState(response));
    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      // TODO
    }
  }

  FutureOr<void> _mapCreateNewPasswordEventToState(CreateNewPasswordEvent event, Emitter<AuthState> emit) {
  }

  Future<void> _mapSignOutEventToState(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    try {
      var response=await repository.signout();
      emit(SignOutSuccessState());
    }  catch (e) {
      emit(AuthfailiureState(e.toString()));
      rethrow;
      // TODO
    }

  }
}

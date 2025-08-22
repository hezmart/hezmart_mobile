import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/authentication/data/models/authsuccess_response.dart';
import 'package:hezmart/features/authentication/data/models/googlepayload.dart';
import 'package:hezmart/features/authentication/data/models/signup_payload.dart';
import 'package:hezmart/features/authentication/data/models/verify_signup_res.dart';

import '../../../../../core/di/injector.dart';
import '../../../domain/repo/authrepository.dart';
import '../../models/forgot_password_res.dart';
import '../../models/forgotpayload.dart';
import '../../models/resendOtp.dart';
import '../../models/verify_signUp.dart';

class AuthRepositoryImpl extends AuthRepository {

  NetworkService networkService;
  AuthRepositoryImpl(this.networkService);

   final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: Platform.isIOS
        ? '207558440124-n06od8omcu3ced9sltn7qmmptqcmj4gs.apps.googleusercontent.com':
    '207558440124-jnfmleksvv9e7e8mru92g6lgpft871pb.apps.googleusercontent.com',
     serverClientId: '207558440124-emp7bj6q6vcrtav9mpiil0h8034vtlbb.apps.googleusercontent.com'

       // 207558440124-a71695ekc6lu3ugbkvqo9r6ur1mb4e7s.apps.googleusercontent.com

   );

   @override
  Future<AuthSuccessResponse> signin(String email, String password) async {
    var response = await networkService.call(
      UrlConfig.signIn,
      RequestMethod.post,
      data: {"email": email, "password": password},
    );
    return AuthSuccessResponse.fromJson(response.data);
  }

  @override
  Future<AuthSuccessResponse> signup(SignUpPayload payloaad) async {
    var response = await networkService.call(
      UrlConfig.signUp,
      RequestMethod.post,
      data: payloaad.toJson(),
    );
    return AuthSuccessResponse.fromJson(response.data);
  }

  @override
  Future<VerifySignUpOtpResponse> verify(VerifySignUpOtpPayload payload) async {
    var response = await networkService.call(
      UrlConfig.verifyotp,
      RequestMethod.post,
      data: payload.toJson(),
    );
    return  VerifySignUpOtpResponse.fromJson(response.data);
  }

  @override
  Future<ForgotPasswordResponse> forgotpassword(
    ForgotPasswordPayload payload,
  )
  async {
    var response = await networkService.call(
      UrlConfig.forgotpassword,
      RequestMethod.post,
      data: payload.toJson(),
    );
    return ForgotPasswordResponse.fromJson(response.data);
  }
  @override
  Future<ResendOtpResponse> resendOtp(String email) async {
    var response=await networkService.call(UrlConfig.resendOtp, RequestMethod.post,data: {"email":email});
    return ResendOtpResponse.fromJson(response.data);
  }

  @override
  Future<AuthSuccessResponse> authenticateWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        return await loginWithGoogle(googleUser);
      } else {
        throw 'Google auth failed.';
      }
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      throw e.toString();
    }
  }

  Future<AuthSuccessResponse> loginWithGoogle(
      GoogleSignInAccount googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      GooglePayload payload = GooglePayload(
        token: googleAuth.idToken,
      );
      logger.w("Access Token: ${googleAuth.accessToken}");
      logger.w("ID Token: ${googleAuth.idToken}");
      logger.w("Server Auth Code: ${googleAuth.serverAuthCode}");
      logger.w(payload.toJson());

      final response = await networkService.call(
        UrlConfig.google,
        RequestMethod.post,
        data: payload.toJson(),
      );

      return AuthSuccessResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future signout() async {
   var response=await networkService.call(UrlConfig.logout, RequestMethod.get);
   return response.data;
  }

}

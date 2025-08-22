import 'package:hezmart/features/authentication/data/models/authsuccess_response.dart';
import 'package:hezmart/features/authentication/data/models/signup_payload.dart';

import '../../data/models/forgot_password_res.dart';
import '../../data/models/forgotpayload.dart';
import '../../data/models/resendOtp.dart';
import '../../data/models/verify_signUp.dart';
import '../../data/models/verify_signup_res.dart';

abstract class AuthRepository{
  Future<AuthSuccessResponse>signin(String email,String password);
  Future<AuthSuccessResponse>signup(SignUpPayload payloaad);
  Future<VerifySignUpOtpResponse>verify(VerifySignUpOtpPayload payload);
  Future<ForgotPasswordResponse>forgotpassword(ForgotPasswordPayload payload);
  Future<ResendOtpResponse>resendOtp(String email);
  Future<AuthSuccessResponse> authenticateWithGoogle();
  Future<dynamic> signout();
}
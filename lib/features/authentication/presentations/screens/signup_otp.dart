import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/features/authentication/data/models/verify_signUp.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/otp_field.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../data/data/repo_impl/authrepositoryimpl.dart';
import '../authbloc/auth_bloc.dart';

class SignupOtp extends StatefulWidget {
  final String email;

  const SignupOtp({super.key, required this.email});

  @override
  State<SignupOtp> createState() => _SignupOtpState();
}

class _SignupOtpState extends State<SignupOtp> {
  @override
  final _formkey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final auth = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final otpauth = AuthBloc(AuthRepositoryImpl(NetworkService()));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextView(
                text: "Verify your Account!",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              12.verticalSpace,
              const TextView(
                text:
                "Enter the 4 digit verification code sent to the email address to proceed",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                align: TextAlign.center,
              ),
              24.verticalSpace,
              OtpField(
                count: 4,
                controller: _otpController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,
              ),
              24.verticalSpace,
              BlocConsumer<AuthBloc, AuthState>(
                listener: _listenToAuthState,
                bloc: auth,
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      verifyOTP();
                    },
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: const TextView(
                      text: "Validate OTP",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  );
                },
              ),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextView(
                    text: "Didn’t receive the code yet? ",
                    fontSize: 16,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: otpauth,
                    listener: _llistenToResendState,
                    builder: (context, state) {
                      return TextView(
                        text: "Resend Code",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff9b0000),
                        onTap: () {
                          _resendOtp();
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),),
    );
  }

  void verifyOTP() {
    if (_formkey.currentState!.validate()) {
      auth.add(
          OtpEvent(VerifySignUpOtpPayload(code: _otpController.text.trim()))
      );
    }
  }

  void _resendOtp() {
    otpauth.add(ResendOTpSignUpEvent(widget.email));
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is OtpSuccessState) {
      context.pop();
      CustomDialogs.success("Verified Successful");
      context.goNamed(PageUrl.signin_screen);
    }
  }

  void _llistenToResendState(BuildContext context, AuthState state) {
    if (state is AuthloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is ResendOtpSuccessState) {
      context.pop();
      CustomDialogs.success("OTP sent");
    }
  }

}

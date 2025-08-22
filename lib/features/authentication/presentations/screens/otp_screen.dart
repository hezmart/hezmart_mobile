import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/authentication/presentations/authbloc/auth_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/otp_field.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/network/network_service.dart';
import '../../data/data/repo_impl/authrepositoryimpl.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formkey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final auth = AuthBloc(AuthRepositoryImpl(NetworkService()));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(20),
        // child: Form(
        //   key: _formkey,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       const TextView(
        //         text: "Verify your Account!",
        //         fontSize: 24,
        //         fontWeight: FontWeight.w600,
        //       ),
        //       12.verticalSpace,
        //       const TextView(
        //         text:
        //         "Enter the 5 digit verification code sent to the email address to proceed",
        //         fontSize: 13,
        //         fontWeight: FontWeight.w400,
        //         align: TextAlign.center,
        //       ),
        //       24.verticalSpace,
        //       OtpField(
        //         count: 4,
        //         controller: _otpController,
        //         validator: MultiValidator([
        //           RequiredValidator(errorText: 'This field is required'),
        //         ]).call,
        //       ),
        //       24.verticalSpace,
        //       BlocConsumer<AuthBloc, AuthState>(
        //         listener: _listenToAuthState,
        //         bloc: auth,
        //         builder: (context, state) {
        //           return CustomButton(
        //             onPressed: () {
        //               verifyOTP();
        //             },
        //             padding: EdgeInsets.symmetric(vertical: 15),
        //             child: const TextView(
        //               text: "Validate OTP",
        //               color: Colors.white,
        //               fontWeight: FontWeight.w600,
        //               fontSize: 16,
        //             ),
        //           );
        //         },
        //       ),
        //       24.verticalSpace,
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           const TextView(
        //             text: "Didn’t receive the code yet? ",
        //             fontSize: 16,
        //           ),
        //           TextView(
        //             text: "Resend Code",
        //             fontSize: 16,
        //             fontWeight: FontWeight.w600,
        //             color: Color(0xff9b0000),
        //             onTap: () {
        //               _resendOtp();
        //             },
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(text: "An password reset link have been sent to ${widget.email}",align: TextAlign.center,),
            TextView(text: "Open your gmail app, and reset your password",align: TextAlign.center,fontSize: 11,color: Pallets.grey35,),
            20.verticalSpace,
            CustomButton(child: TextView(text: "Go back",color: Colors.white,fontSize:17,fontWeight: FontWeight.w600,), onPressed: () async {
             context.goNamed(PageUrl.signin_screen);
            })
          ],
        ),

      )

      ,
    );
  }

  void verifyOTP() {
    if (_formkey.currentState!.validate()) {
      // auth.add(OtpEvent(_otpController.text.trim()));
    }
  }

  void _resendOtp() {}

  void _listenToAuthState(BuildContext context, AuthState state) {

    if(state is AuthloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state  is AuthfailiureState){
      context.pop();
      CustomDialogs.error(state.error);
    }
    if(state is OtpSuccessState){
      context.pop();
      CustomDialogs.success("Verified Successful");
      context.goNamed(PageUrl.home);

    }
  }
}

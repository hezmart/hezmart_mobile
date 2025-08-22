import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/filled_textfield.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/authentication/data/data/repo_impl/authrepositoryimpl.dart';
import 'package:hezmart/features/authentication/data/models/forgotpayload.dart';
import 'package:hezmart/features/authentication/presentations/authbloc/auth_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../core/navigation/path_params.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final bloc = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final controller = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.verticalSpace,
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Icon(Iconsax.arrow_left_2),
              ),
              32.verticalSpace,
              const TextView(
                text: "Forgot Password",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              6.verticalSpace,
              const TextView(
                text:
                "Enter your email id for the verification process, we will send 4 digit to your email",
                fontSize: 13,
              ),
              20.verticalSpace,
              TextView(text: "Email"),
              5.verticalSpace,
              FilledTextField(hint: "JohnJeo@gmail.com",
                controller: controller,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,),
              40.verticalSpace,
              BlocConsumer<AuthBloc, AuthState>(
                listener: _listeenToAuthState,
                bloc: bloc,
                builder: (context, state) {
                  return CustomButton(
                    child: TextView(
                      text: "Send OTP",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    onPressed: () {
                      ggetOTP();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ggetOTP() {
    if (key.currentState!.validate()) {
    bloc.add(ForgotPasEvent(ForgotPasswordPayload(email: controller.text.trim())));
    }
  }

  void _listeenToAuthState(BuildContext context, AuthState state) {
    if(state is AuthloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is AuthfailiureState){
      context.pop();
      CustomDialogs.error(state.error);
    }
    if(state is ForgotSuccessState){
      context.pop();
      CustomDialogs.success("OTP sent to your email");
      context.goNamed(PageUrl.otp_screen,
          queryParameters: {PathParam.email: controller.text.trim()});
    }
  }
}

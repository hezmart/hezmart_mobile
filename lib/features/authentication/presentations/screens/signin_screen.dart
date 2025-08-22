import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/authentication/data/data/repo_impl/authrepositoryimpl.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_outlined_button.dart';
import '../../../../common/widgets/filled_textfield.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../authbloc/auth_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final auth = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final googleauth = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final key = GlobalKey<FormState>();
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                80.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Welcome Back",
                      color: Color(0xff992002),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    // TextView(text: "Please enter your credentials to login",
                    //   align: TextAlign.center,),
                    TextView(text: "Shop smarter with Hezmart - sign in for deals, quick checkouts & tailored recommendations!",
                    ),                  ],
                ),
                30.verticalSpace,
                TextView(text: "Email"),
                5.verticalSpace,
                FilledTextField(
                  controller: emailcontroller,
                  hint: "JohnJeo@gmail.com",
                ),
                15.verticalSpace,
                TextView(text: "Password"),
                5.verticalSpace,
                FilledTextField(
                  hint: "*******",
                  controller: passwordcontroller,
                  obscured: obscured,
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        obscured = !obscured;
                      });
                    },
                    splashColor: Colors.transparent,

                    child: Icon(
                      obscured ? Iconsax.eye_slash : Iconsax.eye,
                      color: Pallets.grey35,
                    ),
                  ),
                ),
                10.verticalSpace,
                TextView(
                  text: "Forgot your password?",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff992002),
                  onTap: () {
                    context.pushNamed(PageUrl.forgot_password);
                  },
                ),
                40.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  listener: _listenToAuthState,
                  bloc: auth,
                  builder: (context, state) {
                    return CustomButton(
                      child: TextView(
                        text: "Sign In",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        signinUser();
                      },
                    );
                  },
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(text: "New to Our Product?", fontSize: 12),
                    4.horizontalSpace,
                    TextView(
                      onTap: () {
                        context.pushNamed(PageUrl.signup_screen);
                      },
                      text: "Create Account",
                      fontSize: 12,
                      color: Color(0xff992002),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),


                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 100, child: Divider()),
                    10.horizontalSpace,
                    TextView(text: "Or connect with"),
                    10.horizontalSpace,

                    SizedBox(width: 100, child: Divider()),
                  ],
                ),
                40.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: googleauth,
                  listener: _listenToAuthGoogleState,
                  builder: (context, state) {
                    return CustomOutlinedButton(
                      // borderRadius: BorderRadius.circular(25),
                      radius: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageWidget(imageUrl: "assets/images/pngs/gg.png"),
                          30.horizontalSpace,
                          TextView(
                            text: "Continue with Google",
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      onPressed: () {
                        googleAuth();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signinUser() {
    if (key.currentState!.validate()) {
      auth.add(
        SignInEvent(
          emailcontroller.text.trim(),
          passwordcontroller.text.trim(),
        ),
      );
    }
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is AuthSuccessState) {
      context.pop();
      CustomDialogs.success("Login successful");
      context.goNamed(PageUrl.home);
    }
  }

  void googleAuth() {
    googleauth.add(GoogleSignUpEvent());
  }

  void _listenToAuthGoogleState(BuildContext context, AuthState state) {
    if (state is AuthloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is AuthGoogleSuccessState) {
      context.pop();
      CustomDialogs.success("Login successful");
      context.goNamed(PageUrl.home);
    }
  }
}

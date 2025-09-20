import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/filled_textfield.dart';
import 'package:hezmart/common/widgets/outlined_form_field.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/authentication/data/data/repo_impl/authrepositoryimpl.dart';
import 'package:hezmart/features/authentication/data/models/signup_payload.dart';
import 'package:hezmart/features/authentication/presentations/authbloc/auth_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_outlined_button.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/utils/helper_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscured = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addresscontroller = TextEditingController();
  final lastnameController = TextEditingController();
  final numbercontroller = TextEditingController();
  String? selectedReason;
  final List<String> nigeriaStates = [
    "Abia State",
    "Adamawa State",
    "AkwaIbom State",
    "Anambra State",
    "Bauchi State",
    "Bayelsa State",
    "Benue State",
    "Borno State",
    "Cross River State",
    "Delta State",
    "Ebonyi State",
    "Edo State",
    "Ekiti State",
    "Enugu State",
    "FCT - Abuja",
    "Gombe State",
    "Imo State",
    "Jigawa State",
    "Kaduna State",
    "Kano State",
    "Katsina State",
    "Kebbi State",
    "Kogi State",
    "Kwara State",
    "Lagos State",
    "Nasarawa State",
    "Niger State",
    "Ogun State",
    "Ondo State",
    "Osun State",
    "Oyo State",
    "Plateau State",
    "Rivers State",
    "Sokoto State",
    "Taraba State",
    "Yobe State",
    "Zamfara State",
  ];
  final auth = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final googleauth = AuthBloc(AuthRepositoryImpl(NetworkService()));
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.verticalSpace,
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: "Create an Account",
                        color: Color(0xff992002),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      TextView(
                        text:
                            "Shop smarter with Hezmart - sign up for deals, quick checkouts & tailored recommendations!",
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,
                TextView(text: "First Name"),
                5.verticalSpace,
                FilledTextField(
                  hint: "John",
                  controller: nameController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Last Name"),
                FilledTextField(
                  hint: "Jeo",
                  controller: lastnameController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Email"),
                5.verticalSpace,
                FilledTextField(
                  hint: "JohnJeo@gmail.com",
                  controller: emailController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Address"),
                5.verticalSpace,
                FilledTextField(
                  controller: addresscontroller,
                  hint: "address",
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "State"),
                5.verticalSpace,
                DropdownButtonHideUnderline(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallets.grey90),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const TextView(
                        text: "State",
                        fontSize: 16,
                        color: Pallets.grey75,
                      ),
                      value: selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          selectedReason = value;
                        });
                      },
                      items:
                          nigeriaStates
                              .map(
                                (String state) => DropdownMenuItem<String>(
                                  value: state,
                                  child: TextView(text: state, fontSize: 16),
                                ),
                              )
                              .toList(),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 250.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Iconsax.arrow_down_1, color: Pallets.grey75),
                      ),
                    ),
                  ),
                ),
                15.verticalSpace,
                TextView(text: "Phone Number"),
                5.verticalSpace,
                FilledTextField(
                  hint: "phone number",
                  controller: numbercontroller,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Create Password"),
                5.verticalSpace,
                FilledTextField(
                  hint: "*******",
                  controller: passwordController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                        MinLengthValidator(
                          8,
                          errorText: 'Password should be at least 8 characters',
                        ),
                        PatternValidator(
                          r'(?=.*[A-Z])',
                          errorText:
                              'Password must contain at least one uppercase letter',
                        ),
                      ]).call,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      text: "By creating account, you agree to our",
                      fontSize: 10,
                    ),
                    4.horizontalSpace,
                    TextView(
                      onTap: () {
                        Helpers.launchRawUrl(
                          'https://hezmart.com/privacy-policy',
                        );
                      },

                      text: "Terms of Service",
                      fontSize: 14,
                      color: Color(0xffE67002),
                    ),
                  ],
                ),
                20.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: auth,
                  listener: _listenToAuthState,
                  builder: (context, state) {
                    return CustomButton(
                      child: TextView(
                        text: "Create Account",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        signupUser();
                      },
                    );
                  },
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(text: "Have an Account?", fontSize: 12),
                    4.horizontalSpace,
                    TextView(
                      text: "Sign In",
                      fontSize: 12,
                      color: Color(0xff992002),
                      fontWeight: FontWeight.w500,
                      onTap: () {
                        context.pushNamed(PageUrl.signin_screen);
                      },
                    ),
                  ],
                ),
                20.verticalSpace,

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
                30.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: googleauth,
                  listener: _listenToAuthGoogleState,
                  builder: (context, state) {
                    return CustomOutlinedButton(
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

  void signupUser() {
    if (_formkey.currentState!.validate()) {
      // context.goNamed(PageUrl.home);
      auth.add(
        SignUpEvent(
          SignUpPayload(
            role: "customer",
            firstName: nameController.text.trim(),
            lastName: lastnameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            passwordConfirm: passwordController.text.trim(),
            primaryPhone: numbercontroller.text.trim(),
            primaryAddress: addresscontroller.text.trim(),
            city: '',
            state: selectedReason,
            country: '',
            photo: '',
          ),
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
      CustomDialogs.success("Registration Successful");
      context.goNamed(
        PageUrl.signup_otp,
        queryParameters: {PathParam.email: emailController.text.trim()},
      );
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

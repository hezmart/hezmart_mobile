import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/navigation/routes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/filled_textfield.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/network/network_service.dart';
import '../../data/data/repo_impl/authrepositoryimpl.dart';
import '../authbloc/auth_bloc.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _newPasswordController = TextEditingController();
  final _comfirmNewPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final auth = AuthBloc(AuthRepositoryImpl(NetworkService()));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.verticalSpace,
                InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(Iconsax.arrow_left_2)),
                32.verticalSpace,
                const TextView(
                  text: "Create a new password",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),

                24.verticalSpace,
                const TextView(
                  text: "New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                6.verticalSpace,
                FilledTextField(hint: "*******",
                  controller: _newPasswordController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                  ]).call,),

                16.verticalSpace,
                const TextView(
                  text: "Confirm New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                6.verticalSpace,
                FilledTextField(hint: "*******",
                  controller: _comfirmNewPasswordController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                  ]).call,),
                16.verticalSpace,

                16.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc:auth,
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return CustomButton(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: const TextView(
                          text: "Submit",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {
                          _changePassword();
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changePassword() {
    if (_formkey.currentState!.validate()) {
      auth.add(CreateNewPasswordEvent());
    }
  }
}

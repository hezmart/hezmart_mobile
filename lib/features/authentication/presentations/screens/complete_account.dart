import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';

import '../../../../common/widgets/filled_textfield.dart';

class CompleteAccount extends StatefulWidget {
  const CompleteAccount({super.key});

  @override
  State<CompleteAccount> createState() => _CompleteAccountState();
}

class _CompleteAccountState extends State<CompleteAccount> {
  final addcontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new, size: 17),
                  ),
                  20.horizontalSpace,
                  TextView(
                    text: "Complete Account Information",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              40.verticalSpace,
              TextView(text: "Country"),
              5.verticalSpace,
              FilledTextField(
                hint: "country",
                validator:
                    MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                    ]).call,
              ),
              20.verticalSpace,
              TextView(text: "State"),
              5.verticalSpace,
              FilledTextField(
                hint: "State",
                controller: statecontroller,
                validator:
                    MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                    ]).call,
              ),
              15.verticalSpace,
              TextView(text: "City"),
              5.verticalSpace,
              FilledTextField(
                hint: "city",
                controller: citycontroller,
                validator:
                    MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                    ]).call,
              ),
              15.verticalSpace,
              TextView(text: "Address"),
              5.verticalSpace,
              FilledTextField(
                controller: addcontroller,
                hint: "address",
                validator:
                    MultiValidator([
                      RequiredValidator(errorText: 'This field is required'),
                    ]).call,
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
              40.verticalSpace,
              CustomButton(
                child: TextView(
                  text: "Complete",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                onPressed: () {
                  completesignUp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void completesignUp() {
    if (key.currentState!.validate()) {
      CustomDialogs.success("message");
      context.goNamed(PageUrl.home);
    }
  }
}

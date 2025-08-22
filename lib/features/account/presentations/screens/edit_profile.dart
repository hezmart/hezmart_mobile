import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/outlined_form_field.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/filled_textfield.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../../authentication/presentations/user_bloc/user_bloc.dart';
import '../../data/repo_impl/profile_repo_impl.dart';
import '../profile/profile_bloc.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = injector.get<UserBloc>();
  final editprofile = ProfileBloc(ProfileRepositoryImpl(NetworkService()));
  final firstnaamecontroller = TextEditingController();
  final lastnaamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final address1controller = TextEditingController();
  String? selectedReason;

  @override
  void initState() {
    // TODO: implement initState
    final userData = user.appUser;
    if (userData != null) {
      if (nigeriaStates.contains(userData.state)) {
        selectedReason = userData.state;
      } else {
        selectedReason = null;
      }
      selectedReason = userData.state ?? '';
      firstnaamecontroller.text = userData.firstName ?? '';
      lastnaamecontroller.text = userData.lastName ?? '';
      emailcontroller.text = userData.email ?? '';
      numbercontroller.text = userData.primaryPhone ?? '';
      address1controller.text = userData.primaryAddress ?? '';
    }
    super.initState();
  }

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
    "Zamfara State"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Edit Profile",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Profile Information", fontSize: 18),
                  // InkWell(
                  //   splashColor: Colors.transparent,
                  //   onTap: () {
                  //     context.pushNamed(PageUrl.edit_profile);
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Icon(Iconsax.edit_2, size: 20, color: Color(0xffFE67002)),
                  //       5.horizontalSpace,
                  //       TextView(text: "Edit", color: Color(0xffFE67002)),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              10.verticalSpace,
              Divider(),
              Container(
                width: 1.sw,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallets.grey95),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: "Full Name", fontSize: 11),
                    5.verticalSpace,
                    FilledTextField(hint: '', controller: firstnaamecontroller),
                    5.verticalSpace,
                    10.verticalSpace,
                    TextView(text: "Last Name", fontSize: 11),
                    5.verticalSpace,
                    FilledTextField(hint: '', controller: lastnaamecontroller),
                    10.verticalSpace,
                    TextView(text: "Email", fontSize: 11),
                    5.verticalSpace,
                    FilledTextField(hint: '', controller: emailcontroller),
                    10.verticalSpace,
                    TextView(text: "Phone Number", fontSize: 11),
                    5.verticalSpace,
                    FilledTextField(hint: '', controller: numbercontroller),
                    10.verticalSpace,
                    Divider(),
                    10.verticalSpace,
                    TextView(text: "My Address", fontSize: 17),
                    10.verticalSpace,
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
                          hint: TextView(
                            text: selectedReason ?? "state",
                            fontSize: 16,
                            // color: Pallets.grey75,
                          ),
                          value: nigeriaStates.contains(selectedReason) ? selectedReason : null,
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
                              child: TextView(
                                text: state,
                                fontSize: 16,
                              ),
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
                            icon: Icon(
                              Iconsax.arrow_down_1,
                              color: Pallets.grey75,
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    TextView(text: "Address", fontSize: 11),
                    5.verticalSpace,
                    FilledTextField(hint: '', controller: address1controller),
                    10.verticalSpace,
                    // 10.verticalSpace,
                    //  TextView(text: "Region", fontSize: 11),
                    //  5.verticalSpace,
                    //  TextView(text: "Kogi State", fontSize: 15),
                    // 10.verticalSpace,
                    //  TextView(text: "City", fontSize: 11),
                    //  5.verticalSpace,
                    //  TextView(text: "Lokoja", fontSize: 15),
                  ],
                ),
              ),
              20.verticalSpace,
              BlocConsumer<ProfileBloc, ProfileState>(
                bloc: editprofile,
                listener: _listenToEditProfileSState,
                builder: (context, state) {
                  return CustomButton(
                    child: TextView(
                      text: "Save",
                      color: Pallets.white,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      updateprofile();
                    },
                  );
                },
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void updateprofile() {
    editprofile.add(
      EditprofileEvent(
        firstnaamecontroller.text.trim(),
        lastnaamecontroller.text.trim(),
        numbercontroller.text.trim(),
        address1controller.text.trim(),
        selectedReason!,
      ),
    );
  }

  void _listenToEditProfileSState(BuildContext context, ProfileState state) {
    if (state is ProfileloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ProfilefailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is ProfileSuccessState) {
      context.pop();
      CustomDialogs.success("Successful");
      context.pop();
      context.pop();

    }
  }

}

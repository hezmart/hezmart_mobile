import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/filled_textfield.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/account/data/repo_impl/profile_repo_impl.dart';
import 'package:hezmart/features/account/presentations/profile/profile_bloc.dart';
import 'package:hezmart/features/authentication/presentations/user_bloc/user_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/info_dialog.dart';
import '../../../../core/services/data/session_manager.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "My Profile",
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
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.pushNamed(PageUrl.edit_profile);
                    },
                    child: Row(
                      children: [
                        Icon(Iconsax.edit_2, size: 20, color: Color(0xffFE67002)),
                        5.horizontalSpace,
                        TextView(text: "Edit", color: Color(0xffFE67002)),
                      ],
                    ),
                  ),
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
                    Container(
                      width: 1.sw,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallets.grey90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextView(text: user.appUser?.firstName ?? '',fontSize: 18,),
                    ),

                    5.verticalSpace,
                    10.verticalSpace,
                    TextView(text: "Last Name", fontSize: 11),
                    5.verticalSpace,
                    Container(
                      width: 1.sw,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallets.grey90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextView(text: user.appUser?.lastName ?? '',fontSize: 18,),
                    ),
                    // FilledTextField(hint: '', controller: lastnaamecontroller,enabled: false),
                    10.verticalSpace,
                    TextView(text: "Email", fontSize: 11),
                    5.verticalSpace,
                    Container(
                      width: 1.sw,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallets.grey90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextView(text: user.appUser?.email ?? '',fontSize: 18,),
                    ),
                    // FilledTextField(hint: '', controller: emailcontroller,enabled: false),
                    10.verticalSpace,
                    TextView(text: "Phone Number", fontSize: 11),
                    5.verticalSpace,
                    Container(
                      width: 1.sw,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallets.grey90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextView(text: user.appUser?.primaryPhone ?? '',fontSize: 18,),
                    ),
                    // FilledTextField(hint: '', controller: numbercontroller,enabled: false),
                    10.verticalSpace,
                    Divider(),
                    10.verticalSpace,
                    TextView(text: "My Address", fontSize: 17),
                    10.verticalSpace,
                    TextView(text: "State"),
                    5.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Pallets.grey90),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextView(text: selectedReason??'',fontSize: 18,),
                ),

                    10.verticalSpace,
                    TextView(text: "Address", fontSize: 11),
                    5.verticalSpace,
                    Container(
                      width: 1.sw,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallets.grey90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextView(text: user.appUser?.primaryAddress ?? '',fontSize: 18,),
                    ),

                    // ),
                    10.verticalSpace,

                  ],
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: (){
                  _logout(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.red
                  ),
                  child: TextView(
                    text: "Delete Account",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,

                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
  void _logout(BuildContext context) async {
    //to  logout
    SessionManager().logOut();
    CustomDialogs.showCustomDialog(
        barrierDismissible: false,
        InfoDialog(
          footer: Padding(
            padding: const EdgeInsets.all(16.0),
            child: 0.horizontalSpace,
          ),
          tittle: "Deleting Account",
          subtittle:
          "You will be redirected to the login page in a few seconds",
        ),
        context);
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
          () {
        context.goNamed(PageUrl.signin_screen);
      },
    );
  }


}





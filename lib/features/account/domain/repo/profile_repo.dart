
import '../../data/models/edit_pro_response.dart';
import '../../data/models/referal_payload.dart';

abstract class ProfileRepository{
  Future<EditprofileResponse>editprofile(String firstname,String lastname,String number,String address,String state);
  Future<EditprofileResponse>profile();
  Future<void>refer(ReferalPaayload payload);
}
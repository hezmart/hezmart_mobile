import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/account/domain/repo/profile_repo.dart';

import '../models/edit_pro_response.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  NetworkService networkService;
  ProfileRepositoryImpl(this.networkService);
  @override
  Future<EditprofileResponse> editprofile(
    String firstname,
    String lastname,
    String number,
    String address,
    String state,
  ) async
  {
    var response = await networkService.call(
      UrlConfig.editprofile,
      RequestMethod.patch,
      data: {
        "firstName": firstname,
        "lastName": lastname,
        "primaryPhone": number,
        "primaryAddress": address,
        "state": state,
      },
    );
    return EditprofileResponse.fromJson(response.data) ;
  }

  @override
  Future<EditprofileResponse> profile() async {
    var response=await networkService.call(UrlConfig.profile, RequestMethod.get);
    return EditprofileResponse.fromJson(response.data);
  }
}

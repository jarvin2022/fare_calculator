import 'package:farecalculator/packages.dart';

class UserModel {
  final String? userID;
  final String? userFirstName;
  final String? userLastName;
  final String? userAddress;
  final String? userProfileURl;

  UserModel({
    this.userID,
    this.userFirstName,
    this.userLastName,
    this.userAddress,
    this.userProfileURl,
  });

  UserModel.fromJson(Map<String, dynamic> res, String id)
      : this(
          userID: id,
          userFirstName: res['user_first_name'] as String,
          userLastName: res['user_last_name'] as String,
          userAddress: res['user_address'] as String,
          userProfileURl: res['user_profile'] as String,
        );
}

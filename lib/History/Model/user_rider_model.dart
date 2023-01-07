import 'package:farecalculator/packages.dart';

class UserModelRider {
  final String? userID;
  final String? userFirstName;
  final String? userLastName;
  final String? userAddress;
  final String? userPlateNumber;
  final String? userProfileURl;

  UserModelRider({
    this.userID,
    this.userFirstName,
    this.userLastName,
    this.userAddress,
    this.userPlateNumber,
    this.userProfileURl,
  });

  UserModelRider.fromJson(Map<String, dynamic> res, String id)
      : this(
          userID: id,
          userFirstName: res['user_first_name'] as String,
          userLastName: res['user_last_name'] as String,
          userAddress: res['user_address'] as String,
          userPlateNumber: res['user_plateNumber'] as String,
          userProfileURl: res['user_profile'] as String,
        );
}

import 'package:InOut/core/params/user_params.dart';

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> meUserRemote();

  Future<Map<String, dynamic>> updatePhotoRemote(UpdatePhotoParams param);
}

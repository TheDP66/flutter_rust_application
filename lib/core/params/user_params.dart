import 'package:dio/dio.dart';

class UpdatePhotoParams {
  MultipartFile? file;

  UpdatePhotoParams({
    this.file,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    return data;
  }
}

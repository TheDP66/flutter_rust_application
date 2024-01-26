import 'package:dio/dio.dart';

String handleError(e) {
  if (e is DioException) {
    if (e.response != null) {
      // The request was made and the server responded with a status code
      print('DioError: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');

      // You can throw a custom exception or return an error model
      return 'Server responded with error: ${e.response?.statusCode}';
    } else {
      // Something went wrong in setting up or sending the request
      print('DioError: ${e.message}');

      // You can throw a custom exception or return an error model
      return 'Error occurred while making the request: ${e.message}';
    }
  } else {
    // Handle other types of errors
    print('Error: $e');

    // You can throw a custom exception or return an error model
    return 'Unexpected error occurred: $e';
  }
}

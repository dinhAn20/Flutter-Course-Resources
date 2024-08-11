import 'package:clima/services/dio.dart';
import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future<Map<String, dynamic>?> getData() async {
    Response response = await DioClient.instance.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      return data;
    } else {
      print(response.statusCode);
    }
    return null;
  }
}

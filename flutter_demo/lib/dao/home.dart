import 'dart:convert';
import 'dart:async';
import 'package:flutter_demo/model/home_model.dart';
import 'package:http/http.dart' as http;

const URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  // ignore: missing_return
  static Future<HomeModel> fetch() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }
  }
}

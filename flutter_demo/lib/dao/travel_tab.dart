import 'dart:developer';

import 'package:flutter_demo/model/travel_tab_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

const URL = 'https://www.devio.org/io/flutter_app/json/travel_page.json';

class TravelTabDao {
  // ignore: missing_return
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    }
  }
}

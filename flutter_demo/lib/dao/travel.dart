import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_demo/model/travel_model.dart';

const URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelDao {
  static Map<String, dynamic> params;
  // ignore: missing_return
  static Future<TravelModel> fetch(
      {int pageIndex, int pageSize, String groupChannelCode}) async {
    params = {
      "groupChannelCode": groupChannelCode,
      "districtId": -1,
      "type": null,
      "lat": -180,
      "lon": -180,
      "locatedDistricted": 0,
      "pagePara": {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "sortType": 9,
        "sortDirection": 0
      },
      "imageCutType": 1,
      "head": {},
      "contentType": "json"
    };
    final response = await http.post(URL, body: json.encode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    }
  }
}

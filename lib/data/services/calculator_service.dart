import 'dart:convert';
import 'dart:io';

import 'package:custome_mobile/data/models/package_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class CalculatorService {
  static Future<List<Package>> getpackages(String search) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var lang = prefs.getString("language") ?? "en";
    var url = 'https://across-mena.com/Fee_calculator/fees/?search=$search';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      "language": lang,
      HttpHeaders.authorizationHeader: 'JWT $jwt'
    });
    var myDataString = utf8.decode(response.bodyBytes);
    var json = convert.jsonDecode(myDataString);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Package.fromJson(place)).toList();
  }

  static Future<List<Origin>> getorigins(String search) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var url = 'https://across-mena.com/Fee_calculator/origin/?search=$search';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'JWT $jwt'
    });
    var myDataString = utf8.decode(response.bodyBytes);

    var json = convert.jsonDecode(myDataString);
    var jsonResults = json as List;
    return jsonResults.map((place) => Origin.fromJson(place)).toList();
  }

  static Future<List<Origin>> getAllorigins() async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var url = 'https://across-mena.com/Fee_calculator/origin/';
    String fileName = "origins";
    if (prefs.getString(fileName) != null &&
        prefs.getString(fileName)!.isNotEmpty) {
      var jsonData = prefs.getString(fileName)!;
      var json = convert.jsonDecode(jsonData);
      var jsonResults = json as List;
      return jsonResults.map((place) => Origin.fromJson(place)).toList();
    } else {
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'JWT $jwt'
      });
      var myDataString = utf8.decode(response.bodyBytes);

      var json = convert.jsonDecode(myDataString);
      prefs.setString(fileName, myDataString);

      var jsonResults = json as List;
      return jsonResults.map((place) => Origin.fromJson(place)).toList();
    }
  }

  static Future<CalculatorResult> getCalculatorResult(
      CalculateObject cal) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var url =
        'https://across-mena.com/Fee_calculator/calculate/?insurance=${cal.insurance}&fee=${cal.fee}&raw_material=${cal.rawMaterial}&industrial=${cal.industrial}&origin=${cal.origin}&total_tax=${cal.totalTax}&partial_tax=${cal.partialTax}&spending_fee=${cal.spendingFee}&local_fee=${cal.localFee}&support_fee=${cal.supportFee}&protection_fee=${cal.protectionFee}&natural_fee=${cal.naturalFee}&tax_fee=${cal.taxFee}';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'JWT $jwt'
    });
    var myDataString = utf8.decode(response.bodyBytes);

    var json = convert.jsonDecode(myDataString);
    return CalculatorResult.fromJson(json);
  }

  static Future<Package> getProductInfo(String id) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var lang = prefs.getString("language") ?? "en";
    var url = 'https://across-mena.com/Fee_calculator/fees/$id/';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      "language": lang,
      HttpHeaders.authorizationHeader: 'JWT $jwt'
    });
    var myDataString = utf8.decode(response.bodyBytes);

    var json = convert.jsonDecode(myDataString);
    return Package.fromJson(json);
  }
}

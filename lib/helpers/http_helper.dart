// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const DOMAIN = 'https://across-mena.com/';

const LOGIN_ENDPOINT = '${DOMAIN}auth/jwt/create/';
const USERS_ENDPOINT = '${DOMAIN}auth/users/';
const PROFILE_ENDPOINT = '${DOMAIN}auth/users/me';
const POSTS_ENDPOINT = '${DOMAIN}clearance/posts/';
const BROKERS_ENDPOINT = '${DOMAIN}clearance/brokers/';
const SAVED_POSTS_ENDPOINT = '${DOMAIN}clearance/savedposts/';
const GROUPS_ENDPOINT = '${DOMAIN}clearance/groups/';
const STATE_CUSTOMES_ENDPOINT = '${DOMAIN}clearance/statecustomes/';
const PACKAGE_TYPES_ENDPOINT = '${DOMAIN}clearance/package_types/';
const ATTACHMENT_TYPES_ENDPOINT = '${DOMAIN}clearance/attachments_types/';
const OFFERS_ENDPOINT = '${DOMAIN}clearance/offers/';
const TRACKING_OFFER_ENDPOINT = '${DOMAIN}clearance/trackoffers/';
const ATTACHMENTS_ENDPOINT = '${DOMAIN}clearance/attachments/';
const ACCURDION_SECTION_ENDPOINT = '${DOMAIN}tree_view/sections/';
const ACCURDION_CHAPTERS_ENDPOINT = '${DOMAIN}tree_view/api/section/';
const ACCURDION_SUBCHAPTERS_ENDPOINT = '${DOMAIN}tree_view/api/chapter/';
const ACCURDION_FEES_ENDPOINT =
    '${DOMAIN}tree_view/api/sub_chapter_with_import/';
const ACCURDION_FEES_TRADE_DESCRIPTION_ENDPOINT =
    '${DOMAIN}tree_view/second-description/';
const SECTION_NOTES_ENDPOINT = '${DOMAIN}tree_view/api/notes_by_section/';
const CHAPTER_NOTES_ENDPOINT = '${DOMAIN}tree_view/api/notes_by_chapter/';
const SUBCHAPTER_NOTES_ENDPOINT = '${DOMAIN}tree_view/api/notes_by_subchapter/';
const FEE_NOTES_ENDPOINT = '${DOMAIN}tree_view/api/notes_by_fee/';
const SEARCH_QUERY_ENDPOINT = '${DOMAIN}tree_view/search/?search=';
const NOTIFICATIONS_ENDPOINT = '${DOMAIN}clearance/notifecations/';
const CALCULATE_MULTI_ENDPOINT = '${DOMAIN}Fee_calculator/multi_calculate/';

class HttpHelper {
  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {String? apiToken}) async {
    return (await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'JWT $apiToken'
    }));
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body,
      {String? apiToken}) async {
    return (await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'JWT $apiToken'
    }));
  }

  static Future<http.Response> patch(String url, Map<String, dynamic> body,
      {String? apiToken}) async {
    return (await http.patch(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'JWT $apiToken'
    }));
  }

  static Future<http.Response> get(String url, {String? apiToken}) async {
    return await http.get(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'JWT $apiToken'});
  }

  static Future<http.Response> getlang(String url, String? lang,
      {String? apiToken}) async {
    return await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: 'JWT $apiToken',
      "language": lang ?? "ar"
    });
  }

  static Future<http.Response> delete(String url, {String? apiToken}) async {
    return await http.delete(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'JWT $apiToken'});
  }

  static Future<http.Response> getAuth(String url, {String? apiToken}) async {
    return await http.get(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'JWT $apiToken'});
  }
}

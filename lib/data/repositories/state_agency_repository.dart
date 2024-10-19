import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/models/package_model.dart' as package;
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/helpers/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StateAgencyRepository {
  List<Offer> offers = [];
  List<StateCustome> states = [];
  List<CustomeAgency> agencies = [];
  List<PackageType> packageTypes = [];
  List<AttachmentType> attachmentTypes = [];
  late SharedPreferences prefs;

  Future<List<StateCustome>> getstates() async {
    prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");

    String fileName = "customstates";

    if (false) {
      var jsonData = prefs.getString(fileName)!;
      var res = jsonDecode(jsonData);
      for (var element in res) {
        states.add(StateCustome.fromJson(element));
      }
    } else {
      var rs = await HttpHelper.get(STATE_CUSTOMES_ENDPOINT, apiToken: jwt);
      states = [];
      if (rs.statusCode == 200) {
        var myDataString = utf8.decode(rs.bodyBytes);

        var result = jsonDecode(myDataString);
        for (var element in result) {
          states.add(StateCustome.fromJson(element));
        }
        prefs.setString(fileName, myDataString);
      }
    }

    return states;
  }

  Future<List<CustomeAgency>> getagencies(int id) async {
    prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    String fileName = "agencies$id";

    if (prefs.getString(fileName) != null &&
        prefs.getString(fileName)!.isNotEmpty) {
      var jsonData = prefs.getString(fileName)!;
      var res = jsonDecode(jsonData);
      agencies = [];
      for (var element in res) {
        agencies.add(CustomeAgency.fromJson(element));
      }
    } else {
      var rs = await HttpHelper.get('$STATE_CUSTOMES_ENDPOINT$id/agencies/',
          apiToken: jwt);
      agencies = [];
      if (rs.statusCode == 200) {
        var myDataString = utf8.decode(rs.bodyBytes);

        var result = jsonDecode(myDataString);
        for (var element in result) {
          agencies.add(CustomeAgency.fromJson(element));
        }
        prefs.setString(fileName, myDataString);
      }
    }

    return agencies;
  }

  Future<List<PackageType>> getPackageTypes() async {
    prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    String fileName = "packagesType";

    if (prefs.getString(fileName) != null &&
        prefs.getString(fileName)!.isNotEmpty) {
      var jsonData = prefs.getString(fileName)!;
      var res = jsonDecode(jsonData);
      packageTypes = [];
      for (var element in res) {
        packageTypes.add(PackageType.fromJson(element));
      }
    } else {
      var rs = await HttpHelper.get(PACKAGE_TYPES_ENDPOINT, apiToken: jwt);
      packageTypes = [];
      if (rs.statusCode == 200) {
        var myDataString = utf8.decode(rs.bodyBytes);

        var result = jsonDecode(myDataString);
        for (var element in result) {
          packageTypes.add(PackageType.fromJson(element));
        }
        prefs.setString(fileName, myDataString);
      }
    }

    return packageTypes;
  }

  Future<List<AttachmentType>> getAttachmentTypes() async {
    prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    String fileName = "attachmentType";

    if (prefs.getString(fileName) != null &&
        prefs.getString(fileName)!.isNotEmpty) {
      var jsonData = prefs.getString(fileName)!;
      var res = jsonDecode(jsonData);
      attachmentTypes = [];
      for (var element in res) {
        attachmentTypes.add(AttachmentType.fromJson(element));
      }
    } else {
      var rs = await HttpHelper.get(ATTACHMENT_TYPES_ENDPOINT, apiToken: jwt);
      attachmentTypes = [];
      if (rs.statusCode == 200) {
        var myDataString = utf8.decode(rs.bodyBytes);

        var result = jsonDecode(myDataString);
        for (var element in result) {
          attachmentTypes.add(AttachmentType.fromJson(element));
        }
        prefs.setString(fileName, myDataString);
      }
    }

    return attachmentTypes;
  }

  static HttpClient getHttpClient() {
    HttpClient httpClient = new HttpClient()
      ..connectionTimeout = const Duration(seconds: 30);
    // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<Attachment?> postAttachment(List<File> images, List<File> files,
      AttachmentType attachmentTypeId, String otherName) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var jwt = token!.split(".");
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));

    var request =
        http.MultipartRequest('POST', Uri.parse(ATTACHMENTS_ENDPOINT));
    request.headers.addAll({
      HttpHeaders.authorizationHeader: "JWT $token",
      HttpHeaders.contentTypeHeader: "multipart/form-data"
    });

    int byteCount = 0;

    final uploadImages = <http.MultipartFile>[];
    for (final imageFiles in images) {
      uploadImages.add(
        await http.MultipartFile.fromPath(
          'images',
          imageFiles.path,
          filename: imageFiles.path.split('/').last,
        ),
      );
    }
    for (var element in uploadImages) {
      request.files.add(element);
    }

    final uploadFiles = <http.MultipartFile>[];

    for (final file in files) {
      uploadFiles.add(
        await http.MultipartFile.fromPath(
          'files',
          file.path,
          filename: file.path.split('/').last,
        ),
      );
    }

    for (var element in uploadFiles) {
      request.files.add(element);
    }

    print(attachmentTypeId.toString());
    request.fields['attachment_type'] = attachmentTypeId.id!.toString();
    request.fields['user'] = payload["user_id"].toString();
    request.fields['other_attachment_name'] = otherName;
    var response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 201) {
      final respStr = await response.stream.bytesToString();
      var res = jsonDecode(respStr);
      return Attachment.fromJson(res);
    } else {
      final respStr = await response.stream.bytesToString();
      print(respStr);
      return null;
    }
  }

  Future<TrackOffer?> updateTracking(TrackOffer value, String message) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var response = await HttpHelper.patch(
      "${TRACKING_OFFER_ENDPOINT + value.id!.toString()}/",
      {
        "attachment_recivment": value.attachmentRecivment!,
        "unload_distenation": value.unloadDistenation!,
        "delivery_permit": value.deliveryPermit!,
        "custome_declration": value.customeDeclration!,
        "preview_goods": value.previewGoods!,
        "pay_fees_taxes": value.payFeesTaxes!,
        "Issuing_exit_permit": value.issuingExitPermit!,
        "load_distenation": value.loadDistenation!,
        "message": message
      },
      apiToken: jwt,
    );
    var myDataString = utf8.decode(response.bodyBytes);
    var json = jsonDecode(myDataString);
    if (response.statusCode == 200) {
      return TrackOffer.fromJson(json);
    } else {
      return null;
    }
  }

  Future<CalculatorResult> getCalculatorResult(CalculateObject cal) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");

    var url =
        'https://across-mena.com/Fee_calculator/calculate/?insurance=${cal.insurance}&fee=${cal.fee}&raw_material=${cal.rawMaterial}&industrial=${cal.industrial}&origin=${cal.origin}&total_tax=${cal.totalTax}&partial_tax=${cal.partialTax}&spending_fee=${cal.spendingFee}&local_fee=${cal.localFee}&support_fee=${cal.supportFee}&protection_fee=${cal.protectionFee}&natural_fee=${cal.naturalFee}&tax_fee=${cal.taxFee}&weight=${cal.weight}&price=${cal.price}&cnsulate=${cal.cnsulate}&dolar=${cal.dolar}&arabic_stamp=${cal.arabic_stamp}&import_fee=${cal.import_fee}';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'JWT $jwt'
    });
    var myDataString = utf8.decode(response.bodyBytes);
    var json = jsonDecode(myDataString);
    var result = CalculatorResult.fromJson(json);
    return result;
  }

  Future<CalculateMultiResult> getCalculatorMultiResult(
      List<CalculateObject> cal) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");

    List<Map<String, dynamic>> objects = [];
    print(jsonEncode(cal));
    for (var element in cal) {
      var obj = {
        "insurance": element.insurance,
        "origin": element.origin,
        "source": element.source,
        "fee": element.fee,
        "spending_fee": element.spendingFee,
        "support_fee": element.supportFee,
        "protection_fee": element.protectionFee,
        "natural_fee": element.naturalFee,
        "tax_fee": element.taxFee,
        "import_fee": element.import_fee,
        "raw_material": element.rawMaterial,
        "industrial": element.industrial,
        "total_tax": element.totalTax,
        "partial_tax": element.partialTax,
        "arabic_stamp": element.arabic_stamp,
        "weight": element.weight,
        "cnsulate": element.cnsulate,
        "price": element.price,
        "dolar": element.dolar
      };
      objects.add(obj);
    }

    var response = await http.post(Uri.parse(CALCULATE_MULTI_ENDPOINT),
        body: jsonEncode(objects),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'JWT $jwt'
        });

    var myDataString = utf8.decode(response.bodyBytes);
    var json = jsonDecode(myDataString);

    var result = CalculateMultiResult.fromJson(json);
    print(response.statusCode);
    print(myDataString);
    return result;
  }

  Future<Offer?> postOffer(
    String? offerType,
    int? broker,
    int? packagesNum,
    int? tabalehNum,
    List<int>? weight,
    List<String>? price,
    List<String>? taxes,
    List<bool>? raw,
    List<bool>? industrial,
    List<bool>? brands,
    List<bool>? tubes,
    List<bool>? colored,
    List<bool>? lycra,
    int? totalweight,
    String? totalprice,
    String? totaltaxes,
    String? expectedArrivalDate,
    String? notes,
    int? costumeagency,
    int? costumestate,
    List<String>? products,
    package.Origin? source,
    List<int>? origin,
    int? packageType,
    List<int>? attachments,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var jwt = token!.split(".");
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
    var trader = prefs.getInt("trader");

    var response = await HttpHelper.post(OFFERS_ENDPOINT, apiToken: token, {
      "offer_type": offerType,
      "trader": trader,
      "costume_broker": broker,
      "costumeagency": costumeagency,
      "costumestate": costumestate,
      "products": products,
      "source": source!.id!,
      "origin": origin,
      "package_type": packageType,
      "packages_num": packagesNum,
      "tabaleh_num": tabalehNum,
      "raw_material": raw.toString(),
      "industrial": industrial.toString(),
      "brand": brands.toString(),
      "tubes": tubes.toString(),
      "colored": colored.toString(),
      "lycra": lycra.toString(),
      "weight": weight.toString(),
      "price": price.toString(),
      "taxes": taxes.toString(),
      "totalweight": totalweight,
      "totalprice": totalprice,
      "totaltaxes": totaltaxes,
      "expected_arrival_date": expectedArrivalDate,
      "attachments": attachments,
      "notes": notes
    });

    print(jsonEncode({
      "offer_type": offerType,
      "trader": trader,
      "costume_broker": broker,
      "costumeagency": costumeagency,
      "costumestate": costumestate,
      "products": products,
      "source": source!.id!,
      "origin": origin,
      "package_type": packageType,
      "packages_num": packagesNum,
      "tabaleh_num": tabalehNum,
      "raw_material": raw.toString(),
      "industrial": industrial.toString(),
      "brand": brands.toString(),
      "tubes": tubes.toString(),
      "colored": colored.toString(),
      "lycra": lycra.toString(),
      "weight": weight.toString(),
      "price": price.toString(),
      "taxes": taxes.toString(),
      "totalweight": totalweight,
      "totalprice": totalprice,
      "totaltaxes": totaltaxes,
      "expected_arrival_date": expectedArrivalDate,
      "attachments": attachments,
      "notes": notes
    }));
    print(response.statusCode);
    var jsonObject = jsonDecode(response.body);
    if (response.statusCode == 201) {
      var offer = Offer.fromJson(jsonObject);
      print(offer);
      return offer;
    } else {
      print(response.body);
      return null;
    }
  }

  Future<List<Offer>> getBrokerOffers() async {
    offers = [];
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var response = await HttpHelper.get(
      "$OFFERS_ENDPOINT?order_status=P",
      apiToken: jwt,
    );
    var myDataString = utf8.decode(response.bodyBytes);
    var json = jsonDecode(myDataString);
    if (response.statusCode == 200) {
      for (var element in json) {
        offers.add(Offer.fromJson(element));
      }

      return offers.reversed.toList();
    } else {
      return offers;
    }
  }

  Future<List<Offer>> getTraderLogOffers(String state) async {
    offers = [];
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var response = await HttpHelper.get(
      "$OFFERS_ENDPOINT?order_status=$state",
      apiToken: jwt,
    );
    var myDataString = utf8.decode(response.bodyBytes);
    var json = jsonDecode(myDataString);
    if (response.statusCode == 200) {
      for (var element in json) {
        offers.add(Offer.fromJson(element));
      }

      return offers.reversed.toList();
    } else {
      return offers;
    }
  }

  Future<bool> updateOfferState(String state, int offerId) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var response = await HttpHelper.patch(
      "$OFFERS_ENDPOINT$offerId/",
      {"order_status": state},
      apiToken: jwt,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> assignBrokerToOffer(int offerId, int broker) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var response = await HttpHelper.patch(
      "$OFFERS_ENDPOINT$offerId/assign_broker/",
      {"costume_broker": broker},
      apiToken: jwt,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateOfferAditionalAttachments(
      List<int> attachments, List<int> additional, int offerId) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    var response = await HttpHelper.patch(
      "$OFFERS_ENDPOINT$offerId/add_additional_attachments/",
      {"attachments": attachments, "aditional_attachments": additional},
      apiToken: jwt,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createCosts(List<Cost> costs) async {
    const url = '${DOMAIN}api/create_costs/';
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    final List<Map<String, dynamic>> costDataList = costs.map((cost) {
      return {
        'description': cost.description,
        'amount': cost.amount.toString(),
        'offer': cost.offerId.toString()
        // Add any other fields from the Cost object as needed
      };
    }).toList();

    final jsonData = jsonEncode(costDataList);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'JWT $jwt'
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

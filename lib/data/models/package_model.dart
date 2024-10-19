class Package {
  String? id;
  List<Extras>? extras;
  Dolar? dolar;
  TotalTaxes? totalTaxes;
  String? label;
  String? export1;
  double? fee;
  double? spendingFee;
  double? supportFee;
  double? protectionFee;
  double? naturalFee;
  double? taxFee;
  double? localFee;
  double? gold;
  double? paper;
  double? brid;
  double? price;
  String? unit;
  double? importFee;
  String? placeholder;
  List<int>? feesGroup;

  Package(
      {this.id,
      this.extras,
      this.dolar,
      this.totalTaxes,
      this.label,
      this.export1,
      this.fee,
      this.spendingFee,
      this.supportFee,
      this.protectionFee,
      this.naturalFee,
      this.taxFee,
      this.localFee,
      this.gold,
      this.paper,
      this.brid,
      this.price,
      this.unit,
      this.importFee,
      this.placeholder,
      this.feesGroup});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['extras'] != null) {
      extras = <Extras>[];
      json['extras'].forEach((v) {
        extras!.add(Extras.fromJson(v));
      });
    } else {
      extras = <Extras>[];
    }
    dolar = json['dolar'] != null ? Dolar.fromJson(json['dolar']) : null;
    totalTaxes = json['total_taxes'] != null
        ? TotalTaxes.fromJson(json['total_taxes'])
        : null;
    label = json['label'];
    export1 = json['export1'];
    fee = json['fee'];
    spendingFee = json['spending_fee'];
    supportFee = json['support_fee'];
    protectionFee = json['protection_fee'];
    naturalFee = json['natural_fee'];
    taxFee = json['tax_fee'];
    localFee = json['local_fee'];
    gold = json['gold'];
    paper = json['paper'];
    brid = json['brid'];
    price = json['price'];
    unit = json['unit'];
    importFee = json['Import_fee'];
    placeholder = json['placeholder'];
    if (json['feesGroup'] != null) {
      feesGroup = <int>[];
      json['feesGroup'].forEach((v) {
        feesGroup!.add(v);
      });
    } else {
      feesGroup = <int>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (extras != null) {
      data['extras'] = extras!.map((v) => v.toJson()).toList();
    }
    data['label'] = label;
    data['export1'] = export1;
    data['fee'] = fee;
    data['spending_fee'] = spendingFee;
    data['support_fee'] = supportFee;
    data['protection_fee'] = protectionFee;
    data['natural_fee'] = naturalFee;
    data['tax_fee'] = taxFee;
    data['local_fee'] = localFee;
    data['gold'] = gold;
    data['paper'] = paper;
    data['brid'] = brid;
    data['price'] = price;
    data['unit'] = unit;
    data['Import_fee'] = importFee;
    data['placeholder'] = placeholder;
    if (feesGroup != null) {
      data['feesGroup'] = feesGroup!.map((v) => v).toList();
    }
    return data;
  }
}

class Extras {
  int? id;
  String? label;
  double? price;
  bool? lycra;
  bool? coloredThread;
  bool? brand;
  bool? tubes;
  String? fees;
  List<int>? origin;
  List<int>? countryGroup;

  Extras(
      {this.id,
      this.label,
      this.price,
      this.lycra,
      this.coloredThread,
      this.brand,
      this.tubes,
      this.fees,
      this.origin,
      this.countryGroup});

  Extras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    price = json['price'];
    lycra = json['lycra'];
    coloredThread = json['colored_thread'];
    brand = json['Brand'];
    tubes = json['tubes'];
    fees = json['fees'];
    if (json['origin'] != null) {
      origin = <int>[];
      json['origin'].forEach((v) {
        origin!.add(v);
      });
    }
    if (json['countryGroups'] != null) {
      countryGroup = <int>[];
      json['countryGroups'].forEach((v) {
        countryGroup!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['price'] = price;
    data['lycra'] = lycra;
    data['colored_thread'] = coloredThread;
    data['Brand'] = brand;
    data['tubes'] = tubes;
    data['fees'] = fees;
    if (origin != null) {
      data['origin'] = origin!.map((v) => v).toList();
    }
    if (countryGroup != null) {
      data['countryGroups'] = countryGroup!.map((v) => v).toList();
    }
    return data;
  }
}

class Dolar {
  double? price;

  Dolar({this.price});

  Dolar.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    return data;
  }
}

class TotalTaxes {
  double? totalTax;
  double? partialTax;
  double? arabicStamp;

  TotalTaxes({this.totalTax, this.partialTax, this.arabicStamp});

  TotalTaxes.fromJson(Map<String, dynamic> json) {
    totalTax = json['total_tax'] ?? 0.0;
    partialTax = json['partial_tax'] ?? 0.0;
    arabicStamp = json['arabic_stamp'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_tax'] = totalTax;
    data['partial_tax'] = partialTax;
    data['arabic_stamp'] = partialTax;
    return data;
  }
}

class Origin {
  int? id;
  String? label;
  String? labelar;
  String? imageURL;
  String? countriesCode;
  List<int>? countryGroups;

  Origin(
      {this.id,
      this.label,
      this.labelar,
      this.imageURL,
      this.countriesCode,
      this.countryGroups});

  Origin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    labelar = json['label_ar'];
    imageURL = json['ImageURL'];
    countriesCode = json['countries_code'];
    countryGroups = json['countryGroups'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['ImageURL'] = imageURL;
    data['countries_code'] = countriesCode;
    data['countryGroups'] = countryGroups;
    return data;
  }
}

class CalculatorResult {
  double? customsFee;
  double? spendingFee;
  double? imranLocality;
  double? conservativeLocality;
  double? feeSupportingLocalProduction;
  double? citiesProtectionFee;
  double? naturalDisasterFee;
  double? incomeTaxFee;
  double? importLicenseFee;
  double? finalFee;
  double? addedTaxes;
  double? customsCertificate;
  double? billTax;
  double? insuranceFee;
  double? stampFee;
  double? provincialLocalTax;
  double? advanceIncomeTax;
  double? reconstructionFee;
  double? finalTaxes;
  double? finalTotal;

  CalculatorResult(
      {this.customsFee,
      this.spendingFee,
      this.imranLocality,
      this.conservativeLocality,
      this.feeSupportingLocalProduction,
      this.citiesProtectionFee,
      this.naturalDisasterFee,
      this.incomeTaxFee,
      this.importLicenseFee,
      this.finalFee,
      this.addedTaxes,
      this.customsCertificate,
      this.billTax,
      this.insuranceFee,
      this.stampFee,
      this.provincialLocalTax,
      this.advanceIncomeTax,
      this.reconstructionFee,
      this.finalTaxes,
      this.finalTotal});

  CalculatorResult.fromJson(Map<String, dynamic> json) {
    customsFee = double.parse(json['customs_fee'] ?? "0.0");
    spendingFee = double.parse(json['spending_fee'] ?? "0.0");
    imranLocality = double.parse(json['imran_locality'] ?? "0.0");
    conservativeLocality = double.parse(json['conservative_locality'] ?? "0.0");
    feeSupportingLocalProduction =
        double.parse(json['fee_supporting_local_production'] ?? "0.0");
    citiesProtectionFee = double.parse(json['cities_protection_fee'] ?? "0.0");
    naturalDisasterFee = double.parse(json['natural_disaster_fee'] ?? "0.0");
    incomeTaxFee = double.parse(json['income_tax_fee'] ?? "0.0");
    importLicenseFee = double.parse(json['import_license_fee'] ?? "0.0");
    finalFee = double.parse(json['final_fee'] ?? "0.0");
    addedTaxes = double.parse(json['added_taxes'] ?? "0.0");
    customsCertificate = double.parse(json['customs_certificate'] ?? "0.0");
    billTax = double.parse(json['bill_tax'] ?? "0.0");
    insuranceFee = double.parse(json['insurance_fee'] ?? "0.0");
    stampFee = double.parse(json['stamp_fee'] ?? "0.0");
    provincialLocalTax = double.parse(json['provincial_local_tax'] ?? "0.0");
    advanceIncomeTax = double.parse(json['advance_income_tax'] ?? "0.0");
    reconstructionFee = double.parse(json['reconstruction_fee'] ?? "0.0");
    finalTaxes = double.parse(json['final_taxes'] ?? "0.0");
    finalTotal = double.parse(json['final_total'] ?? "0.0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customs_fee'] = customsFee;
    data['spending_fee'] = spendingFee;
    data['imran_locality'] = imranLocality;
    data['conservative_locality'] = conservativeLocality;
    data['fee_supporting_local_production'] = feeSupportingLocalProduction;
    data['cities_protection_fee'] = citiesProtectionFee;
    data['natural_disaster_fee'] = naturalDisasterFee;
    data['income_tax_fee'] = incomeTaxFee;
    data['import_license_fee'] = importLicenseFee;
    data['final_fee'] = finalFee;
    data['added_taxes'] = addedTaxes;
    data['customs_certificate'] = customsCertificate;
    data['bill_tax'] = billTax;
    data['insurance_fee'] = insuranceFee;
    data['stamp_fee'] = stampFee;
    data['provincial_local_tax'] = provincialLocalTax;
    data['advance_income_tax'] = advanceIncomeTax;
    data['reconstruction_fee'] = reconstructionFee;
    data['final_taxes'] = finalTaxes;
    data['final_total'] = finalTotal;
    return data;
  }
}

class CalculateMultiResult {
  String? totalCustomsFee;
  String? totalConservativeLocality;
  String? totalFeeSupportingLocalProduction;
  String? totalCitiesProtectionFee;
  String? totalNaturalDisasterFee;
  String? totalImportLicenseFee;
  String? totalIncomeTaxFee;
  String? totalSpendingFee;
  String? totalCategoryPrice;
  String? totalConsulateFee;
  String? totalConsulateTax;
  String? totalFinalFee;
  String? totalAddedTaxes;
  String? totalInsuranceFee;
  String? totalStampFee;
  String? totalGrantingImportLicense;
  String? totalProvincialLocalTax;
  String? totalAdvanceIncomeTax;
  String? totalReconstructionFee;
  String? totalFinalTaxes;
  String? totalFinalTotal;

  CalculateMultiResult(
      {this.totalCustomsFee,
      this.totalConservativeLocality,
      this.totalFeeSupportingLocalProduction,
      this.totalCitiesProtectionFee,
      this.totalNaturalDisasterFee,
      this.totalImportLicenseFee,
      this.totalIncomeTaxFee,
      this.totalSpendingFee,
      this.totalCategoryPrice,
      this.totalConsulateFee,
      this.totalConsulateTax,
      this.totalFinalFee,
      this.totalAddedTaxes,
      this.totalInsuranceFee,
      this.totalStampFee,
      this.totalGrantingImportLicense,
      this.totalProvincialLocalTax,
      this.totalAdvanceIncomeTax,
      this.totalReconstructionFee,
      this.totalFinalTaxes,
      this.totalFinalTotal});

  CalculateMultiResult.fromJson(Map<String, dynamic> json) {
    totalCustomsFee = json['total_customs_fee'];
    totalConservativeLocality = json['total_conservative_locality'];
    totalFeeSupportingLocalProduction =
        json['total_fee_supporting_local_production'];
    totalCitiesProtectionFee = json['total_cities_protection_fee'];
    totalNaturalDisasterFee = json['total_natural_disaster_fee'];
    totalImportLicenseFee = json['total_import_license_fee'];
    totalIncomeTaxFee = json['total_income_tax_fee'];
    totalSpendingFee = json['total_spending_fee'];
    totalCategoryPrice = json['total_category_price'];
    totalConsulateFee = json['total_consulate_fee'];
    totalConsulateTax = json['total_consulate_tax'];
    totalFinalFee = json['total_final_fee'];
    totalAddedTaxes = json['total_added_taxes'];
    totalInsuranceFee = json['total_insurance_fee'];
    totalStampFee = json['total_stamp_fee'];
    totalGrantingImportLicense = json['total_Granting_import_license'];
    totalProvincialLocalTax = json['total_provincial_local_tax'];
    totalAdvanceIncomeTax = json['total_advance_income_tax'];
    totalReconstructionFee = json['total_reconstruction_fee'];
    totalFinalTaxes = json['total_final_taxes'];
    totalFinalTotal = json['total_final_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_customs_fee'] = this.totalCustomsFee;
    data['total_conservative_locality'] = this.totalConservativeLocality;
    data['total_fee_supporting_local_production'] =
        this.totalFeeSupportingLocalProduction;
    data['total_cities_protection_fee'] = this.totalCitiesProtectionFee;
    data['total_natural_disaster_fee'] = this.totalNaturalDisasterFee;
    data['total_import_license_fee'] = this.totalImportLicenseFee;
    data['total_income_tax_fee'] = this.totalIncomeTaxFee;
    data['total_spending_fee'] = this.totalSpendingFee;
    data['total_category_price'] = this.totalCategoryPrice;
    data['total_consulate_fee'] = this.totalConsulateFee;
    data['total_consulate_tax'] = this.totalConsulateTax;
    data['total_final_fee'] = this.totalFinalFee;
    data['total_added_taxes'] = this.totalAddedTaxes;
    data['total_insurance_fee'] = this.totalInsuranceFee;
    data['total_stamp_fee'] = this.totalStampFee;
    data['total_Granting_import_license'] = this.totalGrantingImportLicense;
    data['total_provincial_local_tax'] = this.totalProvincialLocalTax;
    data['total_advance_income_tax'] = this.totalAdvanceIncomeTax;
    data['total_reconstruction_fee'] = this.totalReconstructionFee;
    data['total_final_taxes'] = this.totalFinalTaxes;
    data['total_final_total'] = this.totalFinalTotal;
    return data;
  }
}

class CalculateObject {
  int? insurance;
  double? fee;
  int? rawMaterial;
  int? industrial;
  String? origin;
  String? source;
  double? totalTax;
  double? partialTax;
  double? spendingFee;
  double? localFee;
  double? supportFee;
  double? naturalFee;
  double? protectionFee;
  double? taxFee;
  int? weight;
  int? price;
  int? cnsulate;
  int? dolar;
  int? arabic_stamp;
  double? import_fee;

  CalculateObject({
    this.insurance,
    this.fee,
    this.rawMaterial,
    this.industrial,
    this.origin,
    this.source,
    this.totalTax,
    this.partialTax,
    this.spendingFee,
    this.localFee,
    this.supportFee,
    this.naturalFee,
    this.protectionFee,
    this.taxFee,
    this.weight,
    this.price,
    this.cnsulate,
    this.dolar,
    this.arabic_stamp,
    this.import_fee,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['insurance'] = insurance;
    data['fee'] = fee;
    data['rawMaterial'] = rawMaterial;
    data['industrial'] = industrial;
    data['origin'] = origin;
    data['source'] = source;
    data['totalTax'] = totalTax;
    data['partialTax'] = partialTax;
    data['spendingFee'] = spendingFee;
    data['localFee'] = localFee;
    data['supportFee'] = supportFee;
    data['naturalFee'] = naturalFee;
    data['protectionFee'] = protectionFee;
    data['taxFee'] = taxFee;
    data['weight'] = weight;
    data['price'] = price;
    data['cnsulate'] = cnsulate;
    data['dolar'] = dolar;
    data['arabic_stamp'] = arabic_stamp;
    data['import_fee'] = import_fee;
    return data;
  }
}

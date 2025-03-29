class CountryModel {
  final String country_name;
  final String country_flag;
  final String country_currency;
  final String country_symbol;
  final String currency_code;
  final String country_code;
  final String country_id;
  final String currencyRateINR;

  CountryModel(
      {required this.country_name,
      required this.country_flag,
      required this.country_currency,
      required this.country_symbol,
      required this.currency_code,
      required this.country_code,
      required this.country_id,
      required this.currencyRateINR});
}

class UserdataModel {
  final String userid;
  final String name;
  final String email;
  final String dob;
  final String address;
  final String aadhar_no;
  final String phone_number;
  final String account_pin;
  final dynamic avatar;
  final dynamic id_document;

  UserdataModel(
      {required this.userid,
      required this.name,
      required this.email,
      required this.dob,
      required this.address,
      required this.aadhar_no,
      required this.phone_number,
      required this.account_pin,
      required this.avatar,
      required this.id_document});
}

class ContactusersModel {
  final String contact_id;
  final String contact_name;
  final String contact_email;
  final String contact_phone_number;

  ContactusersModel(
      {required this.contact_id,
      required this.contact_name,
      required this.contact_email,
      required this.contact_phone_number});
}

class CategorieslistModel {
  final String category_id;
  final String category_name;

  CategorieslistModel({required this.category_id, required this.category_name});
}

class OthercontactModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String countryId;
  final String country;
  final String flag;
  final String currency;
  final String symbol;
  final String currencyCode;
  final String countryCode;

  OthercontactModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.avatar,
      required this.countryId,
      required this.country,
      required this.flag,
      required this.currency,
      required this.symbol,
      required this.currencyCode,
      required this.countryCode});
}

class TransactionhistoryModel {
  final String id;
  final String type;
  final String mode;
  final String amount;
  final String categoryName;
  final String baseValue;
  final String convertedValue;
  final String month;
  final String date;
  final String year;
  final String createdAt;
  final String partnerName;
  final String partnerPhoneNumber;
  final String partnerphoto;
  final String partnercountry;

  factory TransactionhistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionhistoryModel(
        id: json['id'].toString(),
        type: json['type'] ?? '',
        mode: json['mode'] ?? '',
        amount: json['amount'].toString(),
        categoryName: json['category_name'] ?? 'Unknown',
        baseValue: json['base_value'].toString(),
        convertedValue: json['converted_value'].toString(),
        month: json['month'].toString(),
        date: json['date'].toString(),
        year: json['year'].toString(),
        createdAt: json['created_at'] ?? '',
        partnerName: json['partner_name'] ?? '',
        partnerPhoneNumber: json['partner_phone_number'] ?? '',
        partnercountry: json['partner_country_code'] ?? '',
        partnerphoto: json['partner_photo'] ?? '');
  }

  TransactionhistoryModel(
      {required this.id,
      required this.type,
      required this.mode,
      required this.amount,
      required this.categoryName,
      required this.baseValue,
      required this.convertedValue,
      required this.month,
      required this.date,
      required this.year,
      required this.createdAt,
      required this.partnerName,
      required this.partnerPhoneNumber,
      required this.partnerphoto,
      required this.partnercountry});
}

class viewfinanceModel {
  final String category_id;
  final String category_name;
  final String limit_amount;
  final String conversion_rate;

  viewfinanceModel(
      {required this.category_id,
      required this.category_name,
      required this.limit_amount,
      required this.conversion_rate});
}

class viewdetailfinancialModel {
  final String category_name;
  final String limit_amount;
  final String total_spent;
  final String progress_percentage;

  viewdetailfinancialModel(
      {required this.category_name,
      required this.limit_amount,
      required this.total_spent,
      required this.progress_percentage});
}

class recenttransactionModel {
  final String user_id;
  final String name;
  final String profile_pic;
  final String country_code;
  final String phone;
  final String country_id;

  recenttransactionModel(
      {required this.user_id,
      required this.name,
      required this.profile_pic,
      required this.country_code,
      required this.phone,
      required this.country_id});
}

class chatdataModel {
  final String id;
  final String type;
  final String mode;
  final String actual_amount;
  final String base_value;
  final String converted_value;
  final String month;
  final String date;
  final String year;
  final String created_at;
  final String partner_name;
  final String partner_phone_number;

  chatdataModel(
      {required this.id,
      required this.type,
      required this.mode,
      required this.actual_amount,
      required this.base_value,
      required this.converted_value,
      required this.month,
      required this.date,
      required this.year,
      required this.created_at,
      required this.partner_name,
      required this.partner_phone_number});
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/connection_dataprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryProvider extends ChangeNotifier {
  //Search
  int _selectedCountryIndex = -1;
  int get selectedIndex => _selectedCountryIndex;
  List<CountryModel> _filteredCountryList = [];
  List<CountryModel> get countryList =>
      _filteredCountryList.isNotEmpty ? _filteredCountryList : _countryList;
  void updateSelectedIndex(int index) {
    _selectedCountryIndex = index;
    notifyListeners();
  }

  bool _loading = true;
  bool get loading => _loading;
  List<CountryModel> _countryList = [];
  String _countryCode = '+91';
  String _countryid = '9';
  String _countryImage =
      'http://campus.sicsglobal.co.in/Project/Neowallet/upload/flag/India (IN).png';
  String get countryCode => _countryCode;
  String get countryImage => _countryImage;
  String get countryID => _countryid;

  Future<void> updateCountry(String code, String image, String id) async {
    _countryCode = code;
    _countryImage = image;
    _countryid = id;
    _selectedCountryIndex =
        _countryList.indexWhere((country) => country.country_code == code);
    notifyListeners();
  }

  final ConnectivityProvider connectivityProvider;
  CountryProvider(this.connectivityProvider) {
    connectivityProvider.addListener(() {
      if (connectivityProvider.isConnected) {
        getCountryList();
      }
    });
  }

  Future<void> getCountryList() async {
print('Fetching countries_list API');
    _loading = true;
    notifyListeners();
    try {
      final url = Uri.parse(
          "http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/countries_list.php");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractData = jsonDecode(response.body);

        if (extractData['countries'] is List) {
          _countryList = (extractData['countries'] as List)
              .map((fields) => CountryModel(
                  currencyRateINR: fields['conversion_rate'].toString(),
                  country_name: fields['country_name'].toString(),
                  country_flag: fields['flag'].toString(),
                  country_currency: fields['currency'].toString(),
                  country_symbol: fields['symbol'].toString(),
                  currency_code: fields['currency_code'].toString(),
                  country_code: fields['country_code'].toString(),
                  country_id: fields['country_id'].toString()))
              .toList();
          _filteredCountryList = _countryList;
        }
        _loading = false;
        notifyListeners();
      }
    } catch (_) {
      _loading = true;
      notifyListeners();
    }
  }

  Future<void> searchCountry(String query) async {
    if (query.isEmpty) {
      _filteredCountryList = _countryList;
    } else {
      _filteredCountryList = _countryList
          .where((country) =>
              country.country_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  String _receiver_country = '9';
  String _receiver_country_code = '+91';
  String _receiver_flag =
      'http://campus.sicsglobal.co.in/Project/Neowallet/upload/flag/India (IN).png';
  String _receiver_country_name = 'india';

  String get receivercountry => _receiver_country;
  String get receivercode => _receiver_country_code;
  String get receiverflage => _receiver_flag;
  String get receivercname => _receiver_country_name;

  Future<void> updatereceiverCountry(
      String code, String image, String id, String name) async {
    _receiver_country = id;
    _receiver_country_code = code;
    _receiver_flag = image;
    _receiver_country_name = name;
    notifyListeners();
  }

//find country with ID
  dynamic _user_country_details = '';
  dynamic get user_country => _user_country_details;
  Future<void> update_user_country(dynamic listdata) async {
    _user_country_details = listdata;
  }

  dynamic _receiver_country_details = '';
  dynamic get receiver_country => _receiver_country_details;
  Future<void> findusercountrywithID(
      {required String countryid, required bool save}) async {
    final prefs = await SharedPreferences.getInstance();
    await getCountryList();
    final IndexElement = _countryList
        .where((field) => field.country_id.toString() == countryid.toString())
        .toList();
    if (IndexElement.length == 1) {
      if (save) {
        await prefs.setStringList('user_country_data', [
          IndexElement[0].country_id,
          IndexElement[0].country_code,
          IndexElement[0].country_currency,
          IndexElement[0].country_flag,
          IndexElement[0].country_name,
          IndexElement[0].country_symbol,
          IndexElement[0].currency_code,
          IndexElement[0].currencyRateINR
        ]);
        _user_country_details = [
          IndexElement[0].country_id,
          IndexElement[0].country_code,
          IndexElement[0].country_currency,
          IndexElement[0].country_flag,
          IndexElement[0].country_name,
          IndexElement[0].country_symbol,
          IndexElement[0].currency_code,
          IndexElement[0].currencyRateINR
        ];
      } else {
        _receiver_country_details = [
          IndexElement[0].country_id,
          IndexElement[0].country_code,
          IndexElement[0].country_currency,
          IndexElement[0].country_flag,
          IndexElement[0].country_name,
          IndexElement[0].country_symbol,
          IndexElement[0].currency_code,
          IndexElement[0].currencyRateINR
        ];
      }
    }
  }

  String _convertedvalue = '0.00';
  String get convertedvalue => _convertedvalue;
  void resetconvertvalue() {
    _convertedvalue = '0.00';
    notifyListeners();
  }

  void convertCurrency({
    required String amount,
    required String oneInrSource,
    required String oneInrTarget,
  }) {
    // Extract numbers (integer or decimal) from the input string
    RegExp numberRegExp = RegExp(r'[\d,.]+');

    String? extractedAmount = numberRegExp.stringMatch(amount);

    if (extractedAmount == null ||
        extractedAmount == 0 ||
        extractedAmount.isEmpty) {
      print("Invalid input");
      resetconvertvalue();
      return;
    }

    // Convert extracted numbers to double
    double amountDouble = double.parse(extractedAmount.replaceAll(',', ''));
    double oneInrSourceDouble = double.parse(oneInrSource);
    double oneInrTargetDouble = double.parse(oneInrTarget);

    // Convert to INR first, then to target currency
    double amountInInr = amountDouble / oneInrSourceDouble;
    double convertedAmount = amountInInr * oneInrTargetDouble;

    // Format output to 2 decimal places
    _convertedvalue = convertedAmount.toStringAsFixed(2);
    notifyListeners();
  }
}

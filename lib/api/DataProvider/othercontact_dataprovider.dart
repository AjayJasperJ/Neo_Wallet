import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/connection_dataprovider.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrDataprovider with ChangeNotifier {
  bool _light_mode = false;
  bool get light_mode {
    return _light_mode;
  }

  updatelightmode() {
    _light_mode = !_light_mode;
    notifyListeners();
  }
}

class OtherusercontactProvider with ChangeNotifier {
  final ConnectivityProvider connectivityProvider;

  OtherusercontactProvider(this.connectivityProvider) {
    connectivityProvider.addListener(() {
      if (connectivityProvider.isConnected) {
        fetchothercontacts();
      }
    });
  }
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  List<OthercontactModel> _apiContacts = [];
  List<OthercontactModel> get apiContacts => [..._apiContacts];
  Future<void> fetchothercontacts() async {
    print('Fetching users_list API');
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userid = await prefs.getString('user_id');
      final response = await http.post(
        Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/users_list.php',
        ),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'user_id': userid},
      ).timeout(const Duration(seconds: 10));
      final String tempResponse = response.body;
      final jsonResponse = jsonDecode(tempResponse);
      List<dynamic> extracteddata = jsonResponse['userDetails'];
      _apiContacts = extracteddata
          .map((fields) => OthercontactModel(
                id: fields['id'].toString(),
                name: fields['name'].toString(),
                email: fields['email'].toString(),
                phone: fields['phone'].toString(),
                avatar: fields['avatar'].toString(),
                countryId: fields["country_id"].toString(),
                country: fields['country'].toString(),
                flag: fields['flag'].toString(),
                currency: fields['currency'].toString(),
                symbol: fields['symbol'].toString(),
                currencyCode: fields['currency_code'].toString(),
                countryCode: fields['country_code'].toString(),
              ))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = true;
      notifyListeners();
    }
  }

  bool _checkloading = false;
  bool get checkloading => _checkloading;
  Future<dynamic> contactcheck(
      BuildContext context, String phone, String code) async {
    _checkloading = true;
    notifyListeners();
    await fetchothercontacts();
    RegExp regExp = RegExp(r'\d+');
    final receiverPhone = _apiContacts
        .where((fields) =>
            fields.phone == phone &&
            regExp
                    .allMatches(fields.countryCode)
                    .map((m) => m.group(0)!)
                    .join("") ==
                regExp.allMatches(code).map((m) => m.group(0)!).join(""))
        .toList();
    _checkloading = false;
    notifyListeners();
    if (receiverPhone.length == 1) {
      return [
        receiverPhone.length == 1,
        receiverPhone[0].countryId,
        receiverPhone[0].id
      ];
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("User not found!"));
    }
  }
}

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAccountDetailsProvider with ChangeNotifier {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  void updateloading() {
    _isLoading = false;
    notifyListeners();
  }

  String _balance = '0';
  String get balance {
    return _balance;
  }

  Future<void> verifyupdatebalance(String updatebalance) async {
    if (_balance != updatebalance) {
      _balance = updatebalance;
      notifyListeners();
    }
  }

  Future<void> updatebalance(BuildContext context) async {
    print('Fetching check_balance API');
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userid = await prefs.getString('user_id');
      final responce = await http.post(
          Uri.parse(
              'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/check_balance.php'),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'user_id': userid});
      final extracteddata = jsonDecode(responce.body);
      if (extracteddata['success'] && responce.statusCode == 200) {
        verifyupdatebalance(extracteddata['base_balance'].toString());
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  void resetbalance() {
    _balance = '0';
    notifyListeners();
  }

  Future<void> fetchUserDetails(BuildContext context) async {
    print('Fetching view_profile API');
    try {
      _isLoading = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');
      final url = Uri.parse(
          "http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/view_profile.php?userid=$userId");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        await fetchrecenttransaction(context);
        final data = jsonDecode(response.body);
        if (data["success"] == true &&
            data.containsKey("user") &&
            data["user"] is List &&
            data["user"].isNotEmpty) {
          _userData = data["user"][0];
          notifyListeners();
        }
      }
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  String _amount = '';
  String get amount {
    return _amount;
  }

  void updateamount(String value) {
    _amount = value;
    notifyListeners();
  }

  Future<void> selftransferamount(BuildContext context) async {
    print('Fetching self_transaction API');
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userid = await prefs.getString('user_id');
      final responce = await http.post(
          Uri.parse(
              'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/self_transaction.php'),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'user_id': userid, 'amount': _amount});
      if (responce.statusCode == 200) {
        final request = jsonDecode(responce.body);
        updatebalance(context);
        updateamount('');
        if (request['success']) {
          GlobalAlertDialog.show(context, value: 0, msg: request['message']);
        } else {
          GlobalAlertDialog.show(context, value: 1, msg: request['message']);
        }
      }
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  List<recenttransactionModel> _recenttransactionhistory = [];
  List<recenttransactionModel> get recenttransactionhistory =>
      [..._recenttransactionhistory];
  void resetrecenttransactionhistory() {
    _recenttransactionhistory = [];
    notifyListeners();
  }

  Future<void> fetchrecenttransaction(BuildContext context) async {
    print('Fetching recent_transaction_contacts API');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final responce = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/recent_transaction_contacts.php?user_id=${prefs.getString('user_id')}'));
      if (responce.statusCode == 200 && jsonDecode(responce.body)['success']) {
        List<dynamic> extracteddata = jsonDecode(responce.body)['contacts'];
        _recenttransactionhistory = extracteddata
            .map((fields) => recenttransactionModel(
                user_id: fields['user_id'].toString(),
                name: fields['name'].toString(),
                profile_pic: fields['profile_pic'].toString(),
                country_code: fields['country_code'].toString(),
                phone: fields['phone'].toString(),
                country_id: fields['country_id'].toString()))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  String _total_spend = '0';
  String _total_limit = '0';
  String _overall_percentage = '0';

  String get totalspend => _total_spend;
  String get total_limit => _total_limit;
  String get overall_percentage => _overall_percentage;

  void resetoveralldata() {
    _total_spend = '0';
    _total_limit = '0';
    _overall_percentage = '0';
    notifyListeners();
  }

  Future<void> totalfinancialtransaction(BuildContext context) async {
    print('Fetching total_finance_goal_status API');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final responce = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/total_finance_goal_status.php?user_id=${prefs.getString('user_id')}'));
      if (responce.statusCode == 200 && jsonDecode(responce.body)['success']) {
        _total_limit = jsonDecode(responce.body)['total_limit'].toString();
        _total_spend = jsonDecode(responce.body)['total_spent'].toString();
        _overall_percentage =
            jsonDecode(responce.body)['overall_percentage'].toString();
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }
}

class EditAccountdetailProvider with ChangeNotifier {
  bool _isloading = true;
  bool get loading => _isloading;
  notifyListeners();
  final GetAccountDetailsProvider getAccountDetailsProvider;
  EditAccountdetailProvider(this.getAccountDetailsProvider);

  Future<void> updateuserdata(
      {required BuildContext context,
      required String name,
      required String email,
      required String dob,
      required String address,
      dynamic avatar}) async {
    print('Fetching profile_update API');
    _isloading = true;
    notifyListeners();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userid = await prefs.getString('user_id');
      final account_pin = await prefs.getString('user_pin');
      final request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/profile_update.php?"));
      request.fields.addAll({
        'userid': userid!,
        'name': name,
        'email': email,
        'dob': dob,
        'address': address,
        'aadhar_no': getAccountDetailsProvider.userData!['aadhar_no'],
        'phone_number': getAccountDetailsProvider.userData!['phone_number'],
        'account_pin': account_pin!,
        'id_document': getAccountDetailsProvider.userData!['id_document'],
        'avatar':
            avatar == null ? getAccountDetailsProvider.userData!['avatar'] : ''
      });
      if (avatar != null) {
        request.files
            .add(await http.MultipartFile.fromPath('avatar', avatar.path));
      }
      print(request);
      var response = await request.send().timeout(Duration(seconds: 10));
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        Navigator.pop(context);
        GlobalAlertDialog.show(context, value: 3, msg: jsonResponse['message']);
        await getAccountDetailsProvider.fetchUserDetails(context);
        getAccountDetailsProvider.updateloading();
        _isloading = false;
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar(jsonResponse['message']));
      }
    } catch (e) {
      _isloading = true;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }
}

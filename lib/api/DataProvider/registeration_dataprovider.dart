import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neo_pay/OnBoardingScreens/onboarding_screen.dart';
import 'package:neo_pay/RegisterationScreens/LoginScreens/login_screen.dart';
import 'package:neo_pay/ShimmerPages/navigatorbar_shimmer.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistrationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final CountryProvider countryProvider;
  UserRegistrationProvider(this.countryProvider);

  Future<void> userRegister(
      {required BuildContext context,
      required String name,
      required String email,
      required String dob,
      required String address,
      required String aadharNo,
      required String phoneNumber,
      required String accountPin,
      required File avatar,
      required File idDocument,
      required String countrycode}) async {
    print('Fetching user_registration API');
    _isLoading = true;
    notifyListeners();
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/user_registration.php',
        ),
      );
      request.fields.addAll({
        'name': name,
        'email': email,
        'dob': dob,
        'address': address,
        'aadhar_no': aadharNo,
        'phone_number': phoneNumber,
        'account_pin': accountPin,
        'country_id': countryProvider.countryList
            .firstWhere((fields) => fields.country_code == countrycode)
            .country_id
      });
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar.path));
      request.files.add(
          await http.MultipartFile.fromPath('id_document', idDocument.path));

      var response = await request.send().timeout(Duration(seconds: 10));
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);

      if (context.mounted) {
        if (response.statusCode == 200 && jsonResponse['success'] == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen(method: true)),
            (route) => route is OnboardingScreen || route.isFirst,
          );

          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar("Account successfully registered!"));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
              jsonResponse['message'] ?? "Something went wrong"));
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }
}

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> userlogin(BuildContext context,
      {String? phoneNumber,
      String? accountPin,
      required String countryid}) async {
    print('Fetching login API');
    final url = Uri.parse(
        "http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/login.php");

    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "phone_number": phoneNumber,
          "account_pin": accountPin!,
          'country_code': countryid
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', responseData["user"]["id"].toString());
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('user_pin', accountPin);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigatorbarShimmer()),
          (Route<dynamic> route) => false,
        );
        GlobalAlertDialog.show(context,
            value: 2, msg: '${responseData["message"]}!!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(responseData["message"] ?? "Login failed"));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

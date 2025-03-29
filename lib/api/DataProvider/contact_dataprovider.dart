import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactDataprovider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _apiContacts = [];
  List<dynamic> get apiContacts => [..._apiContacts];

  List<dynamic> _filteredContacts = [];
  List<dynamic> get filteredContacts => [..._filteredContacts];

  Future<void> fetchContactsFromAPI() async {
    _isLoading = true;
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
      _apiContacts = jsonResponse['userDetails'];
      _filteredContacts = _apiContacts;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      _filteredContacts = _apiContacts;
    } else {
      _filteredContacts = _apiContacts
          .where((contact) =>
              contact['name'].toLowerCase().contains(query.toLowerCase()) ||
              contact['email'].toLowerCase().contains(query.toLowerCase()) ||
              contact['phone_number'].toString().contains(query))
          .toList();
    }
    notifyListeners();
  }
}

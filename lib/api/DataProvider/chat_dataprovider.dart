import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDataprovider with ChangeNotifier {
  List<chatdataModel> _fetchdatadetail = [];
  List<chatdataModel> get fetchchatdetail => _fetchdatadetail;
  Future<void> fetchchatdata(BuildContext context, String receiver_id) async {
    print('Fetching transaction_between_users API');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final responce = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/transaction_between_users.php?user_id=${prefs.getString('user_id')}&partner_id=$receiver_id'));
      if (responce.statusCode == 200 && jsonDecode(responce.body)['success']) {
        List<dynamic> extracteddata = jsonDecode(responce.body)['transactions'];
        _fetchdatadetail = extracteddata
            .map((fields) => chatdataModel(
                id: fields['id'].toString(),
                type: fields['type'].toString(),
                mode: fields['mode'].toString(),
                actual_amount: fields['actual_amount'].toString(),
                base_value: fields['base_value'].toString(),
                converted_value: fields['converted_value'].toString(),
                month: fields['month'].toString(),
                date: fields['date'].toString(),
                year: fields['year'].toString(),
                created_at: fields['created_at'].toString(),
                partner_name: fields['partner_name'].toString(),
                partner_phone_number:
                    fields['partner_phone_number'].toString()))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }
}

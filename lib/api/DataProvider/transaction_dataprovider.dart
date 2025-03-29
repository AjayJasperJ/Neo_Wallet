import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionhistoryModel> _transactionHistory = [];

  List<TransactionhistoryModel> get transactionHistory =>
      [..._transactionHistory];
  void resethistory() {
    _transactionHistory = [];
    notifyListeners();
  }

  Future<void> fetchTransactionHistory(BuildContext context) async {
    print('Fetching transaction_history API');
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    try {
      final response = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/transaction_history.php?user_id=$userId'));

      if (response.statusCode == 200) {
        List<dynamic> extractedData = jsonDecode(response.body)['transactions'];
        _transactionHistory = extractedData
            .map((item) => TransactionhistoryModel.fromJson(item))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  List<TransactionhistoryModel> filterTransactions(
      {required String month, required String year}) {
    return _transactionHistory.where((transaction) {
      return transaction.month == month && transaction.year == year;
    }).toList();
  }

  Future<void> paymoneyusingqr(BuildContext context,
      {required String amount,
      required String receiverid,
      required String categoryID}) async {
    print('Fetching qr_payment API');
    print('$amount $receiverid $categoryID');
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    try {
      final request = await http.post(
          Uri.parse(
              'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/qr_payment.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: {
            'user_id': userId.toString(),
            'amount': amount.toString(),
            'receiver_id': receiverid.toString(),
            'category_id': categoryID.toString()
          });
      final extract = jsonDecode(request.body);
      print(extract);
      if (extract['success'] && request.statusCode == 200) {
        GlobalAlertDialog.show(context, value: 0, msg: extract['message']);
        if (extract['warning_status']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 4),
            content: Text(
              extract['warning'],
              style: CustomTextStyler()
                  .styler(size: .015, color: neo_theme_white0, type: 'M'),
            ),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        GlobalAlertDialog.show(context, value: 1, msg: extract['message']);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!$e"));
    }
  }

  Future<void> addtransaction(BuildContext context,
      {required String amount, required String receiverid}) async {
    print('Fetching add_transactions API');
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    try {
      final request = await http.post(
          Uri.parse(
              'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/add_transactions.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: {
            'sender_id': userId,
            'amount': amount,
            'receiver_id': receiverid
          });
      context.read<GetAccountDetailsProvider>().fetchrecenttransaction(context);
      final extract = jsonDecode(request.body);
      if (extract['success'] && request.statusCode == 200) {
        await context.read<GetAccountDetailsProvider>().updatebalance(context);
        GlobalAlertDialog.show(context, value: 0, msg: extract['message']);
      } else {
        await context.read<GetAccountDetailsProvider>().updatebalance(context);
        GlobalAlertDialog.show(context, value: 1, msg: extract['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }
}

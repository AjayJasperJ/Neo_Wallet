import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinancialgoalDataprovider with ChangeNotifier {
  List<CategorieslistModel> _categorieslist = [];
  List<CategorieslistModel> get categorieslist {
    return [..._categorieslist];
  }

  List<String> _selectedcategories = [];
  List<String> get selectedcategories {
    return [..._selectedcategories];
  }

  void toggleSelection(String categoryId) {
    if (_selectedcategories.contains(categoryId)) {
      _selectedcategories.remove(categoryId);
      notifyListeners();
    } else {
      _selectedcategories.add(categoryId);
      notifyListeners();
    }
  }

  void updateSelectedCategories(List<String> inputdata) {
    _selectedcategories = inputdata;
    notifyListeners();
  }

  bool _isloading = false;
  bool get isloading {
    return _isloading;
  }

  Future<void> getcategoriesdata(BuildContext context) async {
    print('Fetching view_categories API');
    _isloading = true;
    try {
      final responce = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/view_categories.php'));
      List<dynamic> extracteddata = jsonDecode(responce.body)['categories'];
      _categorieslist = extracteddata
          .map((fields) => CategorieslistModel(
              category_id: fields['category_id'],
              category_name: fields['category_name']))
          .toList();
      _isloading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  bool _iscreating = false;
  bool get iscreating => _iscreating;
  void updatecreating() {
    _iscreating = true;
    notifyListeners();
  }

  Future<void> postfinancialgoal(BuildContext context, dynamic dataList) async {
    print('Fetching add_financial_goal API');
    try {
      final responce = await http.post(
        Uri.parse(
            'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/add_financial_goal.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(dataList),
      );
      if (responce.statusCode == 200) {}
      context
          .read<GetAccountDetailsProvider>()
          .totalfinancialtransaction(context);
      Navigator.pop(context);
      _iscreating = false;
      notifyListeners();
      await view_financial_goal(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  String msg1 = '';
  bool _showerror = false;
  bool get showerror => _showerror;
  void updateerrormsg(bool value, String msg) {
    msg1 = msg;
    _showerror = value;
    notifyListeners();
  }

  String _currentmonth = '';
  void updatemonthnyear(String data) {
    _currentmonth = data;
    notifyListeners();
  }

  String get currentmonth => _currentmonth;
  List<viewfinanceModel> _viewfinancegoaldetail = [];
  List<viewfinanceModel> get viewfinancegoaldetail =>
      [..._viewfinancegoaldetail];
  void resetviewfinancialdetail() {
    _viewfinancegoaldetail = [];
    notifyListeners();
  }

  Future<void> view_financial_goal(BuildContext context) async {
    print('Fetching view_financial_goal API');
    try {
      final prefs = await SharedPreferences.getInstance();
      final responce = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/view_financial_goal.php?user_id=${prefs.getString('user_id')}'));

      if (responce.statusCode == 200 && jsonDecode(responce.body)['success']) {
        List<dynamic> extracted = jsonDecode(responce.body)['limits'];
        updatemonthnyear(jsonDecode(responce.body)['month']);
        _viewfinancegoaldetail = extracted
            .map((field) => viewfinanceModel(
                category_id: field['category_id'].toString(),
                category_name: field['category_name'].toString(),
                limit_amount: field['limit_amount'].toString(),
                conversion_rate: field['conversion_rate'].toString()))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }

  List<viewdetailfinancialModel> _progessdatalist = [];
  List<viewdetailfinancialModel> get progessdatalist => [..._progessdatalist];
  void resetprogresslist() {
    _progessdatalist = [];
    notifyListeners();
  }

  Future<void> financial_progress_meter(BuildContext context) async {
    print('Fetching financial_goal_progress API');
    try {
      final prefs = await SharedPreferences.getInstance();
      final responce = await http.get(Uri.parse(
          'http://campus.sicsglobal.co.in/Project/Neowallet/phpfiles/Api/financial_goal_progress.php?user_id=${prefs.getString('user_id')}'));

      List<dynamic> extracteddata = jsonDecode(responce.body)['progress'];
      if (jsonDecode(responce.body)['success'] && responce.statusCode == 200) {
        _progessdatalist = extracteddata
            .map((fields) => viewdetailfinancialModel(
                category_name: fields['category_name'].toString(),
                limit_amount: fields['limit_amount'].toString(),
                total_spent: fields['total_spent'].toString(),
                progress_percentage: fields['progress_percentage'].toString()))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Request timeout!! try again!"));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget Detail_Card(BuildContext context, dynamic provider, String total_limit,
    {required List<viewfinanceModel> listdata, required String symbol}) {
  return Consumer<FinancialgoalDataprovider>(
      builder: (context, finacialProvider, child) {
    return Container(
      width: displaysize.width,
      padding: EdgeInsets.all(displaysize.height * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Transaction Limit',
                  style: CustomTextStyler()
                      .styler(size: .015, type: 'M', color: neo_theme_blue3)),
              GestureDetector(
                onTap: () async {
                  provider.updateerrormsg(false, '');
                  showBudgetPlannerDialog(context);
                },
                child: Image.asset(
                  icon_edit,
                  height: displaysize.height * .025,
                  color: neo_theme_blue3,
                ),
              )
            ],
          ),
          SizedBox(height: displaysize.height * .008),
          Text("${symbol}${double.parse(total_limit).toStringAsFixed(2)}/-",
              style: CustomTextStyler()
                  .styler(size: .02, type: 'M', color: neo_theme_blue0)),
          SizedBox(height: displaysize.height * .01),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3),
            itemCount: listdata.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final indexedelement = listdata[index];
              return Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      indexedelement.category_name.substring(
                          0, indexedelement.category_name.indexOf('&') - 1),
                      style: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_grey2),
                    ),
                    Text('${symbol}${indexedelement.limit_amount}/-',
                        style: CustomTextStyler().styler(
                            size: .017, type: 'M', color: neo_theme_blue3))
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  });
}

class BudgetPlannerDialog extends StatefulWidget {
  @override
  _BudgetPlannerDialogState createState() => _BudgetPlannerDialogState();
}

class _BudgetPlannerDialogState extends State<BudgetPlannerDialog> {
  final Map<String, TextEditingController> _controllers = {};
  final Set<String> _selectedCategories = {};
  final PageController _pageController = PageController();
  final Map<String, bool> _errorStates = {}; // Tracks errors per field

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _toggleCategory(String category) async {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
        _controllers.remove(category);
        _errorStates.remove(category);
      } else {
        _selectedCategories.add(category); // Now it's a List, preserves order
        _controllers[category] = TextEditingController();
        _errorStates[category] = false;
      }
    });
  }

  Future<void> _update(BuildContext context) async {
    bool isValid = true;
    _errorStates.forEach((category, hasError) {
      final text = _controllers[category]?.text ?? '';
      if (text.isEmpty || int.tryParse(text) == null) {
        isValid = false;
        _errorStates[category] = true;
      } else {
        _errorStates[category] = false;
      }
    });

    if (isValid && _selectedCategories.isNotEmpty) {
      final financialgoalProvider =
          Provider.of<FinancialgoalDataprovider>(context, listen: false);
      financialgoalProvider.updateerrormsg(false, '');
      financialgoalProvider.updatecreating();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('user_id');

      final List<String> categoryIds = _selectedCategories.map((categoryName) {
        return financialgoalProvider.categorieslist
            .firstWhere((c) => c.category_name == categoryName)
            .category_id
            .toString();
      }).toList();

      final List<String> limitAmounts = _selectedCategories.map((categoryName) {
        return _controllers[categoryName]!.text; // Already a string
      }).toList();

      // Final JSON payload
      final Map<String, dynamic> requestBody = {
        'user_id': userId,
        'category_id': categoryIds,
        'limit_amount': limitAmounts,
      };
      context
          .read<GetAccountDetailsProvider>()
          .totalfinancialtransaction(context);
      await financialgoalProvider.postfinancialgoal(context, requestBody);
    } else {
      final financialgoalProvider =
          Provider.of<FinancialgoalDataprovider>(context, listen: false);
      if (_selectedCategories.isEmpty) {
        financialgoalProvider.updateerrormsg(true, 'No category selected!!');
      } else {
        financialgoalProvider.updateerrormsg(
            true, 'Field should not be empty!!');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final financialgoalProvider =
          Provider.of<FinancialgoalDataprovider>(context, listen: false);
      financialgoalProvider.getcategoriesdata(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final financialgoalProvider =
        Provider.of<FinancialgoalDataprovider>(context);
    final List<String> categoryList = financialgoalProvider.categorieslist
        .map((c) => c.category_name)
        .toList();
    final int totalPages = (_selectedCategories.length / 3).ceil();
    final double dynamicHeight =
        (_selectedCategories.length * displaysize.height * .08)
            .clamp(displaysize.height * .08, displaysize.height * .24)
            .toDouble();

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displaysize.width * .04)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: displaysize.width * .04,
            vertical: displaysize.height * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Financial goal',
                          style: CustomTextStyler().styler(
                              size: .024, type: 'M', color: neo_theme_blue3)),
                    ],
                  ),
                  SizedBox(
                    height: displaysize.height * .01,
                  ),
                  Text('Select Transaction Type:',
                      style: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_blue3)),
                  SizedBox(
                    height: displaysize.height * .04,
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: categoryList.map((category) {
                final isSelected = _selectedCategories.contains(category);
                return GestureDetector(
                  onTap: () => _toggleCategory(category),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: displaysize.width * .025,
                        vertical: displaysize.height * .005),
                    decoration: BoxDecoration(
                      color: neo_theme_white0,
                      border: Border.all(
                          color:
                              isSelected ? neo_theme_blue0 : neo_theme_grey2),
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                    ),
                    child: Text(category.split('&').first,
                        style: CustomTextStyler().styler(
                            size: .016,
                            type: 'M',
                            color: isSelected
                                ? neo_theme_blue0
                                : neo_theme_grey2)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: displaysize.height * .015),
            Container(
              height: dynamicHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: totalPages,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, pageIndex) {
                  final startIndex = pageIndex * 3;
                  final endIndex = (startIndex + 3) > _selectedCategories.length
                      ? _selectedCategories.length
                      : startIndex + 3;
                  final currentPageCategories = _selectedCategories
                      .toList()
                      .sublist(startIndex, endIndex);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: currentPageCategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Container(
                              height: displaysize.height * .06,
                              width: displaysize.width * .25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          displaysize.width / 4),
                                      bottomLeft: Radius.circular(
                                          displaysize.width / 4)),
                                  color:
                                      neo_theme_blue0.withValues(alpha: .85)),
                              child: Center(
                                  child: Text(
                                category.toString().substring(
                                    0, (category.toString().indexOf('&') - 1)),
                                style: CustomTextStyler().styler(
                                    size: .017,
                                    type: 'M',
                                    color: neo_theme_white0),
                              )),
                            ),
                            Expanded(
                                child: SizedBox(
                              height: displaysize.height * .06,
                              child: TextFormField(
                                style: CustomTextStyler().styler(
                                    size: .017,
                                    type: 'M',
                                    color: neo_theme_blue3),
                                controller: _controllers[category],
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                    hintText: 'Limit amount here',
                                    hintStyle: CustomTextStyler().styler(
                                        size: .016,
                                        type: 'M',
                                        color: neo_theme_grey2),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              displaysize.width / 4),
                                          bottomRight: Radius.circular(
                                              displaysize.width / 4)),
                                      borderSide:
                                          BorderSide(color: neo_theme_blue0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              displaysize.width / 4),
                                          bottomRight: Radius.circular(
                                              displaysize.width / 4)),
                                      borderSide:
                                          BorderSide(color: neo_theme_blue0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              displaysize.width / 4),
                                          bottomRight: Radius.circular(
                                              displaysize.width / 4)),
                                      borderSide:
                                          BorderSide(color: neo_theme_blue0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              displaysize.width / 4),
                                          bottomRight: Radius.circular(
                                              displaysize.width / 4)),
                                      borderSide:
                                          BorderSide(color: neo_theme_blue0),
                                    )),
                              ),
                            ))
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(
              height: displaysize.height * .005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: displaysize.height * .056,
                  width: displaysize.width * .34,
                  child: !financialgoalProvider.iscreating
                      ? ElevatedButton(
                          style: CustomElevatedButtonBoardedTheme(),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',
                              style: CustomTextStyler().styler(
                                  size: .018,
                                  color: neo_theme_blue0,
                                  type: 'M')),
                        )
                      : ElevatedButton(
                          style: CustomElevatedButtonBoardedTheme(),
                          onPressed: null,
                          child: Text('Cancel',
                              style: CustomTextStyler().styler(
                                  size: .018,
                                  color: neo_theme_grey1,
                                  type: 'M')),
                        ),
                ),
                SizedBox(
                  height: displaysize.height * .056,
                  width: displaysize.width * .34,
                  child: financialgoalProvider.iscreating
                      ? Center(
                          child: SizedBox(
                            height: displaysize.height * .04,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: neo_theme_blue0,
                            )),
                          ),
                        )
                      : ElevatedButton(
                          style: CustomElevatedButtonTheme(),
                          onPressed: () => _update(context),
                          child: Text(
                            'Update',
                            style: CustomTextStyler().styler(
                                size: .018, color: neo_theme_white0, type: 'M'),
                          ),
                        ),
                ),
              ],
            ),
            financialgoalProvider.showerror
                ? Column(
                    children: [
                      SizedBox(height: displaysize.height * .01),
                      Text(
                        financialgoalProvider.msg1,
                        style: CustomTextStyler()
                            .styler(size: .015, type: 'M', color: Colors.red),
                      )
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

void showBudgetPlannerDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing when tapping outside
    builder: (BuildContext context) {
      return BudgetPlannerDialog();
    },
  );
}

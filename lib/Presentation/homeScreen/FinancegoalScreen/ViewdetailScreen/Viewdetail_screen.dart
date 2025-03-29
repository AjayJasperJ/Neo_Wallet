import 'package:flutter/material.dart';
import 'package:neo_pay/Presentation/homeScreen/FinancegoalScreen/ViewdetailScreen/Viewdetail_screen_widgets.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class ViewdetailScreen extends StatefulWidget {
  final String month;

  const ViewdetailScreen({super.key, required this.month});

  @override
  State<ViewdetailScreen> createState() => _ViewdetailScreenState();
}

class _ViewdetailScreenState extends State<ViewdetailScreen> {
  @override
  void initState() {
    super.initState();
    final financialgoalProvider =
        Provider.of<FinancialgoalDataprovider>(context, listen: false);
    financialgoalProvider.financial_progress_meter(context);
  }

  @override
  Widget build(BuildContext context) {
    final financialgoalProvider =
        Provider.of<FinancialgoalDataprovider>(context);
    final countryProvider = Provider.of<CountryProvider>(context);
    final userdetailProvider = Provider.of<GetAccountDetailsProvider>(context);
    final filteredProgressList = financialgoalProvider.progessdatalist
        .where(
            (item) => (double.tryParse(item.limit_amount.toString()) ?? 0) > 0)
        .toList();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(gradient: neo_theme_gradient),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight, // Ensures full height
                ),
                child: Column(
                  children: [
                    // ✅ Fixed Height Container
                    Container(
                      height: displaysize.height * .49,
                      width: displaysize.width,
                      child: Padding(
                        //fixed sized
                        padding: EdgeInsets.only(
                            right: displaysize.width * .04,
                            left: displaysize.width * .04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBackButton(
                                boarder: false, title: "Finance goal"),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: displaysize.width * .04),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    height: displaysize.height * .06,
                                    width: displaysize.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            displaysize.height / 4),
                                        color: neo_theme_white0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              icon_calender,
                                              height: displaysize.height * .025,
                                              color: neo_theme_blue3,
                                            ),
                                            SizedBox(
                                              width: displaysize.width * .05,
                                            ),
                                            Text(
                                                GetFullAlphabeticMonth(
                                                    int.parse(widget.month)),
                                                style: CustomTextStyler()
                                                    .styler(
                                                        size: .02,
                                                        type: 'M',
                                                        color: neo_theme_blue3))
                                          ],
                                        ),
                                        Image.asset(
                                          icon_down,
                                          height: displaysize.height * .025,
                                          color: neo_theme_blue3,
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Your Expense",
                                          style: CustomTextStyler().styler(
                                              size: .02,
                                              type: 'R',
                                              color: neo_theme_white0)),
                                      SizedBox(
                                        height: displaysize.height * .014,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          financialgoalProvider
                                              .financial_progress_meter(
                                                  context);
                                        },
                                        child: Text(
                                            "${countryProvider.user_country[5]}${double.parse(userdetailProvider.totalspend).toStringAsFixed(2)}/-",
                                            style: CustomTextStyler().styler(
                                                size: .045,
                                                type: 'R',
                                                color: neo_theme_white0)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Transaction Limit",
                                              style: CustomTextStyler().styler(
                                                  size: .016,
                                                  type: 'R',
                                                  color: neo_theme_white0)),
                                          Text(
                                              "${countryProvider.user_country[5]}${double.parse(userdetailProvider.total_limit).toStringAsFixed(2)}/-",
                                              style: CustomTextStyler().styler(
                                                  size: .016,
                                                  type: 'R',
                                                  color: neo_theme_white0))
                                        ],
                                      ),
                                      SizedBox(
                                        height: displaysize.height * .02,
                                      ),
                                      Center(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          height: displaysize.height * .008,
                                          child: LinearProgressIndicator(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            value: double.parse(userdetailProvider
                                                        .overall_percentage) >
                                                    1
                                                ? 1
                                                : double.parse(userdetailProvider
                                                    .overall_percentage), // percent filled
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    neo_theme_white0),
                                            backgroundColor: neo_theme_white2,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // ✅ Flexible Growing Container
                    LayoutBuilder(
                      builder: (context, boxConstraints) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(displaysize.width * .04),
                                  topRight:
                                      Radius.circular(displaysize.width * .04)),
                              color: neo_theme_white1),
                          constraints: BoxConstraints(
                              minHeight: constraints.maxHeight -
                                  displaysize.height * .49,
                              minWidth: constraints.maxWidth // Remaining space
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: displaysize.height * .02,
                                ),
                                Text("View Details",
                                    style: CustomTextStyler().styler(
                                        size: .025,
                                        type: 'M',
                                        color: neo_theme_blue3)),
                                SizedBox(
                                  height: displaysize.height * .02,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  removeBottom: true,
                                  removeLeft: true,
                                  removeRight: true,
                                  child: GridView.builder(
                                    itemCount: filteredProgressList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: displaysize.width * .03,
                                      mainAxisSpacing:
                                          (displaysize.height * .02),
                                      childAspectRatio: .95,
                                      crossAxisCount: 3,
                                    ),
                                    itemBuilder: (context, index) {
                                      final progressname = filteredProgressList[
                                          index]; // Use filtered list
                                      return CustomCircularProgressBar(
                                          index, progressname);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

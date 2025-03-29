import 'package:flutter/material.dart';
import 'package:neo_pay/Presentation/homeScreen/FinancegoalScreen/ViewdetailScreen/Viewdetail_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/FinancegoalScreen/financegoal_screen_widgets.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class FinancegoalScreen extends StatefulWidget {
  const FinancegoalScreen({super.key});

  @override
  State<FinancegoalScreen> createState() => _FinancegoalScreenState();
}

class _FinancegoalScreenState extends State<FinancegoalScreen> {
  @override
  void initState() {
    super.initState();
    final financialgoaldataProvider =
        Provider.of<FinancialgoalDataprovider>(context, listen: false);
    financialgoaldataProvider.view_financial_goal(context);
  }

  @override
  Widget build(BuildContext context) {
    final financialgoaldataProvider =
        Provider.of<FinancialgoalDataprovider>(context);
    final countryProvider = Provider.of<CountryProvider>(context);
    final userdetailProvider = Provider.of<GetAccountDetailsProvider>(context);
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
                        height: displaysize.height * .4,
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
                                    SizedBox(),
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
                                        Text(
                                            "${countryProvider.user_country[5]}${double.parse(userdetailProvider.totalspend).toStringAsFixed(2)}/-",
                                            style: CustomTextStyler().styler(
                                                size: .045,
                                                type: 'R',
                                                color: neo_theme_white0)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Transaction Limit",
                                                style: CustomTextStyler()
                                                    .styler(
                                                        size: .016,
                                                        type: 'R',
                                                        color:
                                                            neo_theme_white0)),
                                            Text(
                                                "${countryProvider.user_country[5]}${double.parse(userdetailProvider.total_limit).toStringAsFixed(2)}/-",
                                                style: CustomTextStyler()
                                                    .styler(
                                                        size: .016,
                                                        type: 'R',
                                                        color:
                                                            neo_theme_white0))
                                          ],
                                        ),
                                        SizedBox(
                                          height: displaysize.height * .02,
                                        ),
                                        Center(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                    topLeft: Radius.circular(
                                        displaysize.width * .04),
                                    topRight: Radius.circular(
                                        displaysize.width * .04)),
                                color: neo_theme_white1),
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight -
                                    displaysize.height * .4,
                                minWidth:
                                    constraints.maxWidth // Remaining space
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
                                  Text("Details",
                                      style: CustomTextStyler().styler(
                                          size: .025,
                                          type: 'M',
                                          color: neo_theme_blue3)),
                                  SizedBox(
                                    height: displaysize.height * .02,
                                  ),
                                  financialgoaldataProvider
                                          .viewfinancegoaldetail.isEmpty
                                      ? GestureDetector(
                                          onTap: () async {
                                            financialgoaldataProvider
                                                .updateerrormsg(false, '');
                                            showBudgetPlannerDialog(context);
                                          },
                                          child: Container(
                                            height: displaysize.height * .08,
                                            width: displaysize.width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    displaysize.width * .04),
                                            decoration: BoxDecoration(
                                              color: neo_theme_white0,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Align(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        icon_addmoney,
                                                        color: neo_theme_blue3,
                                                        height:
                                                            displaysize.height *
                                                                .026,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            displaysize.width *
                                                                .04,
                                                      ),
                                                      Text(
                                                        'Add Goal',
                                                        style: CustomTextStyler()
                                                            .styler(
                                                                size: .018,
                                                                type: 'M',
                                                                color:
                                                                    neo_theme_blue3),
                                                      )
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    icon_forward,
                                                    color: neo_theme_blue3,
                                                    height: displaysize.height *
                                                        .026,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Detail_Card(
                                          listdata: financialgoaldataProvider
                                              .viewfinancegoaldetail,
                                          symbol:
                                              countryProvider.user_country[5],
                                          context,
                                          financialgoaldataProvider,
                                          userdetailProvider.total_limit),
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
        bottomNavigationBar: SizedBox(
          height: displaysize.height * .08,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: displaysize.height * .02,
                left: displaysize.height * .02,
                right: displaysize.height * .02),
            child: financialgoaldataProvider.viewfinancegoaldetail.isEmpty
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewdetailScreen(
                                    month:
                                        financialgoaldataProvider.currentmonth,
                                  )));
                    },
                    style: CustomElevatedButtonTheme(),
                    child: Text("View Details",
                        style: CustomTextStyler().styler(
                            size: .018, type: 'R', color: neo_theme_white0)),
                  ),
          ),
        ));
  }
}

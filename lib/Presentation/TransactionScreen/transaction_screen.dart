import 'package:flutter/material.dart';
import 'package:neo_pay/Presentation/TransactionScreen/transaction_widget.dart';
import 'package:neo_pay/Presentation/WalletScreen/wallet_screen_widgets.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/transaction_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selectedMonth = DateTime.now().month.toString();
  String selectedYear = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    transactionProvider.fetchTransactionHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final filteredTransactions = transactionProvider.filterTransactions(
      month: selectedMonth,
      year: selectedYear,
    );
    final countryProvider = Provider.of<CountryProvider>(context);
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
                      height: displaysize.height * .2,
                      width: displaysize.width,
                      child: Padding(
                        //fixed sized
                        padding: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .04),
                        child: Column(
                          children: [
                            jumptopage(context, 1, 'Transaction history')
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
                                  displaysize.height * .2,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Transactions",
                                        style: TextStyle(
                                            fontFamily: 'general_sans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: displaysize.height * .025,
                                            color: neo_theme_blue3)),
                                  ],
                                ),
                                SizedBox(height: displaysize.height * .02),
                                Row(
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        dropdownColor: neo_theme_white1,
                                        value: selectedMonth,
                                        icon: const SizedBox.shrink(),
                                        items: List.generate(12, (index) {
                                          return DropdownMenuItem(
                                              value: (index + 1).toString(),
                                              child: Center(
                                                  child: Text(
                                                GetAlphabeticMonth(index + 1),
                                              )));
                                        }),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedMonth = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: displaysize.width * .02),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        dropdownColor: neo_theme_white1,
                                        value: selectedYear,
                                        icon: const SizedBox.shrink(),
                                        items: ["2024", "2025", "2026"]
                                            .map((String year) {
                                          return DropdownMenuItem(
                                            value: year,
                                            child: Center(child: Text(year)),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedYear = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  removeBottom: true,
                                  removeRight: true,
                                  removeLeft: true,
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                        vertical: displaysize.height * .02),
                                    itemCount: filteredTransactions.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final transaction =
                                          filteredTransactions[index];
                                      return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  displaysize.height * .01),
                                          height: displaysize.height * .075,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      displaysize.height / 4),
                                              border: Border.fromBorderSide(
                                                  BorderSide(
                                                      color: neo_theme_grey0))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    displaysize.width * .035),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    getTransactionIcon(
                                                        transaction),
                                                    SizedBox(
                                                      width: displaysize.width *
                                                          .04,
                                                    ),
                                                    Text(
                                                      "${transaction.partnerName}\n${transaction.partnercountry} ${transaction.partnerPhoneNumber} ",
                                                      style: CustomTextStyler()
                                                          .styler(
                                                              color:
                                                                  neo_theme_blue3,
                                                              size: .016,
                                                              type: 'M'),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  transaction.mode == 'received'
                                                      ? '+ ${countryProvider.user_country[5]}${double.parse(transaction.amount).toStringAsFixed(2)}/-'
                                                      : '- ${countryProvider.user_country[5]}${double.parse(transaction.amount).toStringAsFixed(2)}/-',
                                                  style: CustomTextStyler()
                                                      .styler(
                                                          size: .018,
                                                          type: 'M',
                                                          color: transaction
                                                                      .mode ==
                                                                  'received'
                                                              ? Colors.green
                                                              : Colors.red),
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: displaysize.height * .09,
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

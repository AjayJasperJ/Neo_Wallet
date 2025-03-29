import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/Presentation/WalletScreen/wallet_screen_widgets.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController _addmoneycontroller = TextEditingController();
  @override
  void dispose() {
    _addmoneycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getaccountdetailProvider =
        Provider.of<GetAccountDetailsProvider>(context);
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
                        height: displaysize.height * .32,
                        width: displaysize.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: displaysize.width * .04,
                              left: displaysize.width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              jumptopage(context, 0, "Wallet"),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Balance",
                                        style: CustomTextStyler().styler(
                                            size: .02,
                                            type: 'R',
                                            color: neo_theme_white0)),
                                    SizedBox(
                                      height: displaysize.height * .01,
                                    ),
                                    Text(
                                        '${countryProvider.user_country[5]}${double.parse(getaccountdetailProvider.balance).toStringAsFixed(2)}/-',
                                        style: CustomTextStyler().styler(
                                            size: .045,
                                            type: 'R',
                                            color: neo_theme_white0))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),

                    // ✅ Flexible Growing Container
                    LayoutBuilder(
                      builder: (context, boxConstraints) {
                        return Container(
                          decoration: BoxDecoration(
                              color: neo_theme_white1,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      displaysize.width * .04))),
                          constraints: BoxConstraints(
                              minHeight: constraints.maxHeight -
                                  displaysize.height * .32, // Remaining space
                              minWidth: constraints.maxWidth),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: displaysize.height * .02,
                                ),
                                Text(
                                  "Add Money",
                                  style: CustomTextStyler().styler(
                                      size: .025,
                                      type: 'M',
                                      color: neo_theme_blue3),
                                ),
                                SizedBox(
                                  height: displaysize.height * .03,
                                ),
                                CustomTextFormField1(
                                  onChanged: (value) {
                                    getaccountdetailProvider
                                        .updateamount(value);
                                  },
                                  controller: _addmoneycontroller,
                                  inputformat: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  keyboardtype: TextInputType.number,
                                  fieldname: "Add Money",
                                  iconpath: icon_paynumber,
                                ),
                                SizedBox(
                                  height: displaysize.height * .02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          if (_addmoneycontroller.text !=
                                                  '500' ||
                                              getaccountdetailProvider.amount !=
                                                  '500') {
                                            _addmoneycontroller.text = '500';
                                            getaccountdetailProvider
                                                .updateamount('500');
                                          } else {
                                            _addmoneycontroller.text = '';
                                            getaccountdetailProvider
                                                .updateamount('');
                                          }
                                        },
                                        child: add_money(500)),
                                    GestureDetector(
                                        onTap: () {
                                          if (_addmoneycontroller.text !=
                                                  '1000' ||
                                              getaccountdetailProvider.amount !=
                                                  '1000') {
                                            _addmoneycontroller.text = '1000';
                                            getaccountdetailProvider
                                                .updateamount('1000');
                                          } else {
                                            _addmoneycontroller.text = '';
                                            getaccountdetailProvider
                                                .updateamount('');
                                          }
                                        },
                                        child: add_money(1000)),
                                    GestureDetector(
                                        onTap: () {
                                          if (_addmoneycontroller.text !=
                                                  '2000' ||
                                              getaccountdetailProvider.amount !=
                                                  '2000') {
                                            _addmoneycontroller.text = '2000';
                                            getaccountdetailProvider
                                                .updateamount('2000');
                                          } else {
                                            _addmoneycontroller.text = '';
                                            getaccountdetailProvider
                                                .updateamount('');
                                          }
                                        },
                                        child: add_money(2000))
                                  ],
                                ),
                                SizedBox(
                                  height: displaysize.height * .02,
                                ),
                                Container(
                                    height: displaysize.height * .06,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _addmoneycontroller.text = '';
                                        getaccountdetailProvider
                                            .selftransferamount(context);
                                        getaccountdetailProvider
                                            .updatebalance(context);
                                      },
                                      style: CustomElevatedButtonTheme(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Add Money",
                                            style: CustomTextStyler().styler(
                                                size: .018,
                                                type: 'R',
                                                color: neo_theme_white0),
                                          ),
                                          SizedBox(
                                              width: displaysize.width * .02),
                                          Text(
                                              getaccountdetailProvider
                                                      .amount.isEmpty
                                                  ? ''
                                                  : '₹${getaccountdetailProvider.amount}',
                                              style: CustomTextStyler().styler(
                                                  size: .018,
                                                  type: 'R',
                                                  color: neo_theme_white0))
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: displaysize.height * .02,
                                ),
                                Center(
                                  child: Text(
                                      'Instantly add money to your wallet for seamless\ntransactions!',
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyler().styler(
                                          size: .016,
                                          type: 'M',
                                          color: neo_theme_blue3)),
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

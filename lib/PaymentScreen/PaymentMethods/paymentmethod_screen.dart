import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

class PaymentmethodScreen extends StatefulWidget {
  const PaymentmethodScreen({super.key});

  @override
  State<PaymentmethodScreen> createState() => _PaymentmethodScreenState();
}

class _PaymentmethodScreenState extends State<PaymentmethodScreen> {
  List<Map<String, dynamic>> _payment_method_datas = [
    {'icon': icon_upi, 'title': 'UPI'},
    {'icon': icon_card, 'title': 'Credit / Debit Card'},
    {'icon': icon_financegoal, 'title': 'Net Banking'},
  ];
  @override
  Widget build(BuildContext context) {
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
                      height: displaysize.height * .33,
                      width: displaysize.width,
                      child: Padding(
                        //fixed sized
                        padding: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .04),
                        child: Column(
                          children: [
                            CustomBackButton(
                              boarder: false,
                              title: "Payment Methods",
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: displaysize.height * .09,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              displaysize.height / 4),
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: neo_theme_white0))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                displaysize.width * .04),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius:
                                                      displaysize.height * .03,
                                                  backgroundColor:
                                                      neo_theme_white2,
                                                  child: Image.asset(
                                                    icon_wallet,
                                                    color: neo_theme_white0,
                                                    height: displaysize.height *
                                                        .025,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      displaysize.width * .04,
                                                ),
                                                Text(
                                                  "Add Money to\nWallet",
                                                  style: CustomTextStyler()
                                                      .styler(
                                                          color:
                                                              neo_theme_white0,
                                                          size: .018,
                                                          type: 'R'),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "₹500.00",
                                              style: CustomTextStyler().styler(
                                                  size: .025,
                                                  type: 'R',
                                                  color: neo_theme_white0),
                                            )
                                          ],
                                        ),
                                      ))
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
                                  displaysize.height * .33,
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
                                Text("Payment Methods",
                                    style: TextStyle(
                                        fontFamily: 'general_sans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: displaysize.height * .025,
                                        color: neo_theme_blue3)),
                                SizedBox(
                                  height: displaysize.height * .03,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true, // Removes top padding
                                  removeBottom: true, // Removes bottom padding
                                  removeLeft: true, // Removes left padding
                                  removeRight: true, // Removes right padding
                                  child: ListView.builder(
                                    itemCount: _payment_method_datas.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return _Payment_options(
                                          _payment_method_datas[index]['icon'],
                                          _payment_method_datas[index]
                                              ['title']);
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
      bottomNavigationBar: Container(
        height: displaysize.height * .08,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: displaysize.height * .02,
              left: displaysize.height * .02,
              right: displaysize.height * .02),
          child: ElevatedButton(
            onPressed: () {
              CustomDialogBox(context, displaysize.height * .26,
                  SuccessPopup(content: 'Payment Successful'));
            },
            style: CustomElevatedButtonTheme(),
            child: Text("Add Amount ₹500.00",
                style: CustomTextStyler()
                    .styler(size: .018, type: 'R', color: neo_theme_white0)),
          ),
        ),
      ),
    );
  }
}

Widget _Payment_options(String imagepath, String title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: displaysize.width * .05),
    height: displaysize.height * .09,
    margin: EdgeInsets.symmetric(vertical: displaysize.height * .006),
    width: displaysize.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(displaysize.height * .022),
        color: neo_theme_white0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              imagepath,
              color: neo_theme_blue3,
              height: displaysize.height * .026,
            ),
            SizedBox(
              width: displaysize.width * .04,
            ),
            Text(
              title,
              style: CustomTextStyler()
                  .styler(size: .018, type: 'M', color: neo_theme_blue3),
            )
          ],
        ),
        Image.asset(
          icon_unselected,
          height: displaysize.height * .026,
        )
      ],
    ),
  );
}

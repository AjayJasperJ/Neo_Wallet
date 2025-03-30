import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

class PaymentPinScreen extends StatefulWidget {
  const PaymentPinScreen({super.key});

  @override
  State<PaymentPinScreen> createState() => _PaymentPinScreenState();
}

class _PaymentPinScreenState extends State<PaymentPinScreen> {
  TextEditingController _pin_a = TextEditingController();
  TextEditingController _pin_b = TextEditingController();
  TextEditingController _pin_c = TextEditingController();
  TextEditingController _pin_d = TextEditingController();
  final FocusNode _focus_a = FocusNode();
  final FocusNode _focus_b = FocusNode();
  final FocusNode _focus_c = FocusNode();
  final FocusNode _focus_d = FocusNode();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: neo_theme_white1.withValues(alpha: 0),
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: displaysize.height * .08,
                ),
                Container(
                    height: displaysize.height * .09,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(displaysize.height / 4),
                        border: Border.fromBorderSide(
                            BorderSide(color: neo_theme_grey0))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: displaysize.width * .04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: displaysize.height * .06,
                                width: displaysize.height * .06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      displaysize.height / 4),
                                ),
                              ),
                              SizedBox(
                                width: displaysize.width * .04,
                              ),
                              Text(
                                "Abitha A\n+91 1234567890",
                                style: CustomTextStyler().styler(
                                    color: neo_theme_blue3,
                                    size: .018,
                                    type: 'M'),
                              )
                            ],
                          ),
                          Text(
                            "₹250",
                            style: CustomTextStyler().styler(
                                size: .025, type: 'M', color: neo_theme_blue3),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: displaysize.height * .04),
                Text("Enter Your 4-Digit PIN",
                    style: CustomTextStyler()
                        .styler(size: .025, type: 'S', color: neo_theme_blue3)),
                SizedBox(
                  height: displaysize.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomOTPField(context, _pin_a, _focus_a,
                        nextFocus: _focus_b),
                    CustomOTPField(context, _pin_b, _focus_b,
                        nextFocus: _focus_c, previousFocus: _focus_a),
                    CustomOTPField(context, _pin_c, _focus_c,
                        nextFocus: _focus_d, previousFocus: _focus_b),
                    CustomOTPField(context, _pin_d, _focus_d,
                        previousFocus: _focus_c)
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
          child: SizedBox(
            height: displaysize.height * .09,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    height: displaysize.height * .06,
                    child: ElevatedButton(
                      onPressed: () {
                        CustomDialogBox(context, displaysize.height * .26,
                            SuccessPopup(content: 'Payment Successful'));
                      },
                      style: CustomElevatedButtonTheme(),
                      child: Center(
                          child: Text("Pay",
                              style: CustomTextStyler().styler(
                                  size: .018,
                                  type: 'R',
                                  color: neo_theme_white0))),
                    )),
                SizedBox(
                  height: displaysize.height * .02,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

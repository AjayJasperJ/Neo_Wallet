import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/registeration_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class VerifyPin extends StatefulWidget {
  final String contact_number;

  const VerifyPin({super.key, required this.contact_number});

  @override
  State<VerifyPin> createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  TextEditingController _pin_a = TextEditingController();
  TextEditingController _pin_b = TextEditingController();
  TextEditingController _pin_c = TextEditingController();
  TextEditingController _pin_d = TextEditingController();
  final FocusNode _focus_a = FocusNode();
  final FocusNode _focus_b = FocusNode();
  final FocusNode _focus_c = FocusNode();
  final FocusNode _focus_d = FocusNode();
  @override
  void dispose() {
    _pin_a.dispose();
    _pin_b.dispose();
    _pin_c.dispose();
    _pin_d.dispose();
    _focus_a.dispose();
    _focus_b.dispose();
    _focus_c.dispose();
    _focus_d.dispose();
    FocusNode().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(boarder: true),
              SizedBox(height: displaysize.height * .03),
              Text("Enter your 4-Digit PIN",
                  style: CustomTextStyler()
                      .styler(size: .025, type: 'S', color: neo_theme_blue3)),
              SizedBox(
                height: displaysize.height * .02,
              ),
              Text(
                  "Please type your 4-Digit PIN that you have already created to ${countryProvider.countryCode} ${widget.contact_number}",
                  style: CustomTextStyler()
                      .styler(size: .016, type: 'M', color: neo_theme_blue3)),
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
          height: displaysize.height * .15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Did not remember PIN? ",
                    style: CustomTextStyler()
                        .styler(size: .016, type: 'M', color: neo_theme_blue3)),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar("You will receive email shortly!"));
                      },
                    text: "Reset",
                    style: CustomTextStyler().styler(
                        size: .016,
                        type: 'S',
                        color: neo_theme_blue3,
                        decoration: 'U'))
              ])),
              Container(
                  height: displaysize.height * .06,
                  child: authProvider.isLoading
                      ? Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(
                              color: neo_theme_blue0,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            authProvider.userlogin(context,
                                phoneNumber: widget.contact_number,
                                accountPin:
                                    "${_pin_a.text}${_pin_b.text}${_pin_c.text}${_pin_d.text}",
                                countryid: countryProvider.countryCode);
                          },
                          style: CustomElevatedButtonTheme(),
                          child: Center(
                              child: Text("Verify",
                                  style: CustomTextStyler().styler(
                                      size: .018,
                                      type: 'R',
                                      color: neo_theme_white0))),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

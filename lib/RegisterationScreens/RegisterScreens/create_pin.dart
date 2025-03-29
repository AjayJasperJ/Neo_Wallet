import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/registeration_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class CreatePin extends StatefulWidget {
  final List<Map<String, dynamic>> registerationdata;

  const CreatePin({super.key, required this.registerationdata});
  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  TextEditingController _pin_a = TextEditingController();
  TextEditingController _pin_b = TextEditingController();
  TextEditingController _pin_c = TextEditingController();
  TextEditingController _pin_d = TextEditingController();
  final FocusNode _focus_a = FocusNode();
  final FocusNode _focus_b = FocusNode();
  final FocusNode _focus_c = FocusNode();
  final FocusNode _focus_d = FocusNode();
  TextEditingController _pin_a1 = TextEditingController();
  TextEditingController _pin_b1 = TextEditingController();
  TextEditingController _pin_c1 = TextEditingController();
  TextEditingController _pin_d1 = TextEditingController();
  final FocusNode _focus_a_ = FocusNode();
  final FocusNode _focus_b_ = FocusNode();
  final FocusNode _focus_c_ = FocusNode();
  final FocusNode _focus_d_ = FocusNode();
  void _verify4digitpin(BuildContext context) async {
    if (_pin_a.text.isEmpty ||
        _pin_b.text.isEmpty ||
        _pin_c.text.isEmpty ||
        _pin_d.text.isEmpty ||
        _pin_a1.text.isEmpty ||
        _pin_b1.text.isEmpty ||
        _pin_c1.text.isEmpty ||
        _pin_d1.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar("Please enter all 4-Digit in each fields!"));
      return;
    }

    if (_pin_a.text != _pin_a1.text ||
        _pin_b.text != _pin_b1.text ||
        _pin_c.text != _pin_c1.text ||
        _pin_d.text != _pin_d1.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("PIN doesn't match!"));
      return;
    }

    final userProvider =
        Provider.of<UserRegistrationProvider>(context, listen: false);
    final countryProvider =
        Provider.of<CountryProvider>(context, listen: false);

    userProvider.userRegister(
      context: context,
      name: widget.registerationdata[0]['name'] ?? '',
      email: widget.registerationdata[0]['email'] ?? '',
      dob: widget.registerationdata[0]['dob'] ?? '',
      address: widget.registerationdata[0]['address'] ?? '',
      aadharNo: widget.registerationdata[0]['aadhar'] ?? '',
      phoneNumber: widget.registerationdata[0]['phone_number'] ?? '',
      countrycode: countryProvider.countryCode,
      accountPin:
          "${_pin_a1.text}${_pin_b1.text}${_pin_c1.text}${_pin_d1.text}",
      avatar: widget.registerationdata[0]['profile'],
      idDocument: widget.registerationdata[0]['identity'],
    );
  }

  @override
  void dispose() {
    _pin_a.dispose();
    _pin_a1.dispose();
    _pin_b.dispose();
    _pin_b1.dispose();
    _pin_c.dispose();
    _pin_c1.dispose();
    _pin_d.dispose();
    _pin_d1.dispose();
    _focus_a.dispose();
    _focus_b.dispose();
    _focus_c.dispose();
    _focus_d.dispose();
    _focus_a_.dispose();
    _focus_b_.dispose();
    _focus_c_.dispose();
    _focus_d_.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserRegistrationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(boarder: true),
              SizedBox(height: displaysize.height * .03),
              Text("Generate Your 4-Digit PIN",
                  style: CustomTextStyler()
                      .styler(size: .025, type: 'S', color: neo_theme_blue3)),
              SizedBox(
                height: displaysize.height * .02,
              ),
              Text(
                  "Set up your secure 4-digit PIN for safe and easy transactions!",
                  style: CustomTextStyler()
                      .styler(size: .016, type: 'M', color: neo_theme_blue3)),
              SizedBox(
                height: displaysize.height * .04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter 4-Digit PIN",
                      style: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_blue3)),
                  SizedBox(
                    height: displaysize.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOTPField(context, _pin_a, _focus_a_,
                          nextFocus: _focus_b_),
                      CustomOTPField(context, _pin_b, _focus_b_,
                          nextFocus: _focus_c_, previousFocus: _focus_a_),
                      CustomOTPField(context, _pin_c, _focus_c_,
                          nextFocus: _focus_d_, previousFocus: _focus_b_),
                      CustomOTPField(context, _pin_d, _focus_d_,
                          previousFocus: _focus_c_)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: displaysize.height * .02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Re-enter 4-Digit PIN",
                      style: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_blue3)),
                  SizedBox(
                    height: displaysize.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOTPField(context, _pin_a1, _focus_a,
                          nextFocus: _focus_b),
                      CustomOTPField(context, _pin_b1, _focus_b,
                          nextFocus: _focus_c, previousFocus: _focus_a),
                      CustomOTPField(context, _pin_c1, _focus_c,
                          nextFocus: _focus_d, previousFocus: _focus_b),
                      CustomOTPField(context, _pin_d1, _focus_d,
                          previousFocus: _focus_c)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
        child: SizedBox(
          height: displaysize.height * .1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: displaysize.height * .06,
                  child: userProvider.isLoading
                      ? Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(
                              color: neo_theme_blue0,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _verify4digitpin(context);
                          },
                          style: CustomElevatedButtonTheme(),
                          child: Center(
                              child: Text("Create",
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

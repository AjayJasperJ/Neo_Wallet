import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/OnBoardingScreens/onboarding_screen.dart';
import 'package:neo_pay/RegisterationScreens/LoginScreens/verify_pin.dart';
import 'package:neo_pay/RegisterationScreens/RegisterScreens/register_screen.dart';
import 'package:neo_pay/ShimmerPages/country_shimmer.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/registeration_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final bool method;

  const LoginScreen({super.key, required this.method});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _selectCountry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CountryShimmer(
                value: true,
              )),
    );

    if (result != null) {
      setState(() {
        selectedCountryCode = result['country_code'];
        selectedFlag = result['country_flag'];
      });
    }
  }

  String selectedCountryCode = "";
  String selectedFlag = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCountryCode = context.read<CountryProvider>().countryCode;
    selectedFlag = context.read<CountryProvider>().countryImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(boarder: true),
                SizedBox(height: displaysize.height * .03),
                Text("Enter your phone number",
                    style: CustomTextStyler()
                        .styler(size: .025, type: 'S', color: neo_theme_blue3)),
                SizedBox(height: displaysize.height * .02),
                Text(
                    widget.method
                        ? "Provide your phone number to log in and access your account."
                        : "Provide your phone number to Sign up and access your account securely.",
                    style: CustomTextStyler()
                        .styler(size: .016, type: 'M', color: neo_theme_blue3)),
                SizedBox(height: displaysize.height * .04),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _contactController, // Attach controller
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  cursorColor: neo_theme_blue0,
                  style: CustomTextStyler()
                      .styler(size: .018, type: 'M', color: neo_theme_blue3),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 17),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: displaysize.width * .05),
                      child: GestureDetector(
                        onTap: _selectCountry,
                        child: Container(
                          color: neo_theme_blue0.withValues(alpha: 0),
                          width: displaysize.width * .22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: displaysize.height * .012,
                                backgroundColor: neo_theme_white1,
                                backgroundImage: NetworkImage(selectedFlag),
                              ),
                              Text(
                                selectedCountryCode,
                                style: CustomTextStyler().styler(
                                    size: .016,
                                    type: 'M',
                                    color: neo_theme_grey2),
                              ),
                              Image.asset(
                                icon_down,
                                height: displaysize.height * .02,
                                color: neo_theme_grey2,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    hintText: "Phone Number",
                    hintStyle: CustomTextStyler()
                        .styler(size: .016, type: 'M', color: neo_theme_grey2),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                      borderSide: BorderSide(color: neo_theme_grey1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                      borderSide: BorderSide(color: neo_theme_blue0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                      borderSide: BorderSide(color: neo_theme_blue0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    } else if (value.length < 10) {
                      return "Enter a valid 10-digit phone number";
                    }
                    return null;
                  },
                ),
              ],
            ),
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
              Container(
                height: displaysize.height * .06,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.method == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => AuthProvider(),
                              child: VerifyPin(
                                contact_number: _contactController.text.trim(),
                              ),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterAddData(
                              phonenumber: _contactController.text.trim(),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: CustomElevatedButtonTheme(),
                  child: Center(
                    child: Text(
                      "Next",
                      style: CustomTextStyler().styler(
                          size: .018, type: 'R', color: neo_theme_white0),
                    ),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.method
                          ? "Don't have an account? "
                          : "Already have an account? ",
                      style: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_blue3),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.method
                              ? Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginScreen(method: false)),
                                  (route) =>
                                      route is OnboardingScreen ||
                                      route.isFirst)
                              : Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginScreen(method: true)),
                                  (route) =>
                                      route is OnboardingScreen ||
                                      route.isFirst);
                        },
                      text: widget.method ? "Sign Up" : "Login",
                      style: CustomTextStyler().styler(
                        size: .016,
                        type: 'S',
                        color: neo_theme_blue3,
                        decoration: 'U',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

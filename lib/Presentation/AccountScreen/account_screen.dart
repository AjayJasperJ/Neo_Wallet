import 'package:flutter/material.dart';
import 'package:neo_pay/OnBoardingScreens/onboarding_screen.dart';
import 'package:neo_pay/Presentation/AccountScreen/AboutScreen/about_screen.dart';
import 'package:neo_pay/Presentation/AccountScreen/FaqScreen/faq_screen.dart';
import 'package:neo_pay/Presentation/AccountScreen/PrivacypolicyScreen/privacypolicy_Screen.dart';
import 'package:neo_pay/Presentation/AccountScreen/account_screen_widgets.dart';
import 'package:neo_pay/Presentation/WalletScreen/wallet_screen_widgets.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/transaction_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Map<String, dynamic>> _settings_fields = [
    {'icon': icon_about, 'title': 'About', 'num': 1, 'target': AboutScreen()},
    {'icon': icon_faq, 'title': 'FAQ', 'num': 1, 'target': FaqScreen()},
    {
      'icon': icon_privacy,
      'title': 'Privacy Policy',
      'num': 1,
      'target': PrivacypolicyScreen()
    }
  ];

  @override
  Widget build(BuildContext context) {
    final userdataProvider = Provider.of<GetAccountDetailsProvider>(context);
    if (userdataProvider.userData == null) {
      return Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(gradient: neo_theme_gradient),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    Container(
                        height: displaysize.height * .45,
                        width: displaysize.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: displaysize.width * .04),
                          child: Column(
                            children: [
                              jumptopage(context, 2, "Account"),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    profile_card(context,
                                        profile: userdataProvider
                                            .userData?['avatar'],
                                        username:
                                            userdataProvider.userData?['name'],
                                        email:
                                            userdataProvider.userData?['email'],
                                        dob: userdataProvider
                                            .userData?['date_of_birth'],
                                        address: userdataProvider
                                            .userData?['address'],
                                        phone_number: userdataProvider
                                            .userData?['phone_number'])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
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
                                  displaysize.height * .45,
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
                                Text("Settings",
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
                                  child: ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (index == _settings_fields.length) {
                                        return GestureDetector(
                                          onTap: () =>
                                              _logout_alert_box(context),
                                          child: settings_options(
                                              icon_logout, "Logout"),
                                        );
                                      }
                                      return GestureDetector(
                                        onTap: () => pushmetopage(context, 1,
                                            _settings_fields[index]['target']),
                                        child: settings_options(
                                            _settings_fields[index]['icon'],
                                            _settings_fields[index]['title']),
                                      );
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

_logout_alert_box(BuildContext context) {
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('user_pin');
    await prefs.remove('contacts');
    await prefs.remove('user_country_data');
    print("Data cleared");
    context.read<GetAccountDetailsProvider>().resetbalance();
    context.read<FinancialgoalDataprovider>().resetviewfinancialdetail();
    context.read<FinancialgoalDataprovider>().resetprogresslist();
    context.read<GetAccountDetailsProvider>().resetrecenttransactionhistory();
    context.read<TransactionProvider>().resethistory();
    context.read<GetAccountDetailsProvider>().resetoveralldata();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
      (Route<dynamic> route) => false,
    );
  }

  return CustomDialogBox(
      context,
      displaysize.height * .25,
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: displaysize.width * .01,
            vertical: displaysize.height * .005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Logout",
                style: CustomTextStyler()
                    .styler(size: .025, type: 'M', color: neo_theme_blue3)),
            Center(
                child: Text("Are you sure you want to logout?",
                    style: CustomTextStyler().styler(
                        size: .018, type: 'M', color: neo_theme_blue3))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: displaysize.height * .055,
                  width: displaysize.width * .38,
                  child: ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        displaysize.width / 4),
                                    side: BorderSide(
                                        color: neo_theme_blue0, width: 1.5))),
                            splashFactory: InkSplash.splashFactory,
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(neo_theme_white0))
                        .copyWith(
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return neo_theme_blue0.withValues(alpha: .2);
                          } else if (states.contains(WidgetState.hovered)) {
                            return neo_theme_grey0.withValues(alpha: .0);
                          }
                          return null;
                        },
                      ),
                    ),
                    child: Center(
                        child: Text("Yes",
                            style: CustomTextStyler().styler(
                                size: .018,
                                type: 'M',
                                color: neo_theme_blue0))),
                  ),
                ),
                Container(
                    height: displaysize.height * .055,
                    width: displaysize.width * .38,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: CustomElevatedButtonTheme(),
                      child: Center(
                          child: Text(
                        "No",
                        style: CustomTextStyler().styler(
                            size: .018, type: 'R', color: neo_theme_white0),
                      )),
                    )),
              ],
            )
          ],
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:neo_pay/PaymentScreen/PaymentchatScreen/paymentchat_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/FinancegoalScreen/financegoal_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/PaycontactScreen/paycontact_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/PaynumberScreen/paynumber_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/home_screen_widgets.dart';
import 'package:neo_pay/Presentation/homeScreen/QRScreen/QRscan_screen.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/chat_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/othercontact_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/contact_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:neo_pay/Presentation/homeScreen/QRScreen/QRcode_screen.dart';
import 'package:provider/provider.dart';

late double flexiblecontainerheight;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAll = false;
  @override
  void initState() {
    super.initState();
    final userdataProvider =
        Provider.of<GetAccountDetailsProvider>(context, listen: false);
    userdataProvider.updatebalance(context);
  }

  @override
  Widget build(BuildContext context) {
    final userdataProvider = Provider.of<GetAccountDetailsProvider>(context);
    final countryProvider = Provider.of<CountryProvider>(context);
    final chatdataProvider = Provider.of<ChatDataprovider>(context);
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: displaysize.width * .04),
                      child: Container(
                        height: displaysize.height * .56,
                        child: Column(
                          children: [
                            SizedBox(height: displaysize.height * .08),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: displaysize.height * .055,
                                      width: displaysize.height * .055,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              displaysize.height * .055 / 2),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  userdataProvider
                                                      .userData?['avatar']),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: displaysize.width * .02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Hii, ${userdataProvider.userData?['name']}!",
                                            style: CustomTextStyler().styler(
                                                size: .016,
                                                type: 'M',
                                                color: neo_theme_white0)),
                                        Text(
                                            userdataProvider.userData?['email'],
                                            style: CustomTextStyler().styler(
                                                size: .013,
                                                type: 'R',
                                                color: neo_theme_blue4))
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    QRCodeScreen(),
                                              ));
                                        },
                                        child: CircleAvatar(
                                          radius: displaysize.height * .025,
                                          backgroundColor: neo_theme_blue0
                                              .withValues(alpha: 0),
                                          child: Image.asset(
                                            icon_qrcode,
                                            height: displaysize.height * .025,
                                          ),
                                        )),
                                    SizedBox(
                                      width: displaysize.width * .02,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Track your finance goal",
                                          style: CustomTextStyler().styler(
                                              size: .02,
                                              type: 'R',
                                              color: neo_theme_white0),
                                        ),
                                        SizedBox(
                                          height: displaysize.height * .014,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            userdataProvider
                                                .fetchrecenttransaction(
                                                    context);
                                            userdataProvider
                                                .totalfinancialtransaction(
                                                    context);
                                          },
                                          child: Text(
                                              '${countryProvider.user_country[5]}${double.parse(userdataProvider.balance).toStringAsFixed(2)}/-',
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
                                                style: CustomTextStyler()
                                                    .styler(
                                                        size: .016,
                                                        type: 'R',
                                                        color:
                                                            neo_theme_white0)),
                                            Text(
                                                "${countryProvider.user_country[5]}${double.parse(userdataProvider.total_limit).toStringAsFixed(2)}/-",
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
                                              value: double.parse(userdataProvider
                                                          .overall_percentage) >
                                                      1
                                                  ? 1
                                                  : double.parse(userdataProvider
                                                      .overall_percentage), // percent filled
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      neo_theme_white0),
                                              backgroundColor: neo_theme_white2,
                                            ),
                                          ),
                                        )),
                                        SizedBox(
                                          height: displaysize.height * .035,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                                create: (context) =>
                                                                    QrDataprovider(),
                                                                child:
                                                                    QrscanScreen())));
                                              },
                                              child: payment_methods(
                                                  icon_qrscan, 'Scan &\npay'),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChangeNotifierProvider(
                                                              create: (context) =>
                                                                  ContactDataprovider(),
                                                              child:
                                                                  PaycontactScreen()),
                                                    ));
                                              },
                                              child: payment_methods(
                                                  icon_paycontact,
                                                  'Pay\nContact'),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaynumberScreen(),
                                                    ));
                                              },
                                              child: payment_methods(
                                                  icon_paynumber,
                                                  'Pay\nNumber'),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FinancegoalScreen(),
                                                    ));
                                              },
                                              child: payment_methods(
                                                  icon_financegoal,
                                                  'Finance\nGoal'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Flexible Growing Container
                    LayoutBuilder(
                      builder: (context, boxConstraints) {
                        flexiblecontainerheight =
                            (constraints.maxHeight - displaysize.height * .56);
                        return Container(
                          constraints: BoxConstraints(
                              minHeight: flexiblecontainerheight,
                              minWidth: constraints.maxWidth),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top:
                                      Radius.circular(displaysize.width * .04)),
                              color: neo_theme_white1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: displaysize.height * .02),
                                Text('People',
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
                                  child: userdataProvider
                                          .recenttransactionhistory.isNotEmpty
                                      ? GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing:
                                                displaysize.width * .05,
                                            mainAxisSpacing: (constraints
                                                        .maxHeight -
                                                    displaysize.height * .56) *
                                                .01,
                                            childAspectRatio: .7,
                                            crossAxisCount: 4,
                                          ),
                                          itemCount: userdataProvider
                                                      .recenttransactionhistory
                                                      .length ==
                                                  8
                                              ? 8
                                              : userdataProvider
                                                          .recenttransactionhistory
                                                          .length >
                                                      8
                                                  ? (showAll
                                                      ? userdataProvider
                                                              .recenttransactionhistory
                                                              .length +
                                                          1
                                                      : 8)
                                                  : userdataProvider
                                                      .recenttransactionhistory
                                                      .length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final totalProfiles =
                                                userdataProvider
                                                    .recenttransactionhistory
                                                    .length;

                                            if (!showAll &&
                                                totalProfiles > 8 &&
                                                index == 7) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showAll = true;
                                                  });
                                                },
                                                child: lessOrMore(false),
                                              );
                                            }

                                            if (showAll &&
                                                index == totalProfiles) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showAll = false;
                                                  });
                                                },
                                                child: lessOrMore(true),
                                              );
                                            }

                                            final extracteddata = userdataProvider
                                                    .recenttransactionhistory[
                                                index];
                                            return GestureDetector(
                                              onTap: () async {
                                                await chatdataProvider
                                                    .fetchchatdata(context,
                                                        extracteddata.user_id);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentchatScreen(
                                                      country_id: extracteddata
                                                          .country_id,
                                                      target_id:
                                                          extracteddata.user_id,
                                                      name: extracteddata.name,
                                                      profile_pic: extracteddata
                                                          .profile_pic,
                                                      country_code:
                                                          extracteddata
                                                              .country_code,
                                                      phone:
                                                          extracteddata.phone,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: profile_view(
                                                  extracteddata.profile_pic,
                                                  extracteddata.name),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height:
                                                      displaysize.height * .08),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChangeNotifierProvider(
                                                                  create: (context) =>
                                                                      ContactDataprovider(),
                                                                  child:
                                                                      PaycontactScreen())));
                                                },
                                                child: Text(
                                                  "No contacts yet!- let's start building\nyour network",
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStyler()
                                                      .styler(
                                                          size: .018,
                                                          type: 'M',
                                                          color:
                                                              neo_theme_blue3),
                                                ),
                                              ),
                                            ],
                                          ),
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

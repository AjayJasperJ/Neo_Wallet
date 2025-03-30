import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                                      Container(
                      height: displaysize.height * .2,
                      width: displaysize.width,
                      child: Padding(

                        padding: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .04),
                        child: Column(
                          children: [
                            CustomBackButton(
                              boarder: false,
                              title: 'About',
                            )
                          ],
                        ),
                      ),
                    ),
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
                              minWidth: constraints.maxWidth 
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .045),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: displaysize.height * .02),
                                  Center(
                                    child: Text(
                                      "About Neo Wallet\n",
                                      style: CustomTextStyler().styler(
                                          type: 'S',
                                          size: .02,
                                          color: neo_theme_blue3),
                                    ),
                                  ),
                                  Text(
                                    "Secure. Fast. Global.\n\nNEO Wallet values your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our app.",
                                    style: CustomTextStyler().styler(
                                        type: 'M',
                                        size: .015,
                                        color: neo_theme_blue3),
                                  ),
                                  SizedBox(height: displaysize.height * .02),
                                  Text(
                                    "Why Choose NEO Wallet?\n",
                                    style: CustomTextStyler().styler(
                                        type: 'S',
                                        size: .02,
                                        color: neo_theme_blue3),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("•  ",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3)),
                                          Expanded(
                                            child: Text(
                                              "Global Transfers: Send money across borders in seconds.",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("•  ",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3)),
                                          Expanded(
                                            child: Text(
                                              "Smart Expense Tracking: Know where your money goes and set budgets.",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("•  ",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3)),
                                          Expanded(
                                            child: Text(
                                              "Secure Transactions: Bank-grade encryption ensures your funds stay safe.",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("•  ",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3)),
                                          Expanded(
                                            child: Text(
                                              "User-Friendly Interface: Designed for a smooth and effortless experience.",
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: displaysize.height * .02),
                                  Text(
                                    "Join thousands of users who trust NEO Wallet to handle their daily transactions securely and efficiently. Your money, your control.",
                                    style: CustomTextStyler().styler(
                                        type: 'M',
                                        size: .015,
                                        color: neo_theme_blue3),
                                  ),
                                  SizedBox(height: displaysize.height * .03),
                                  Center(
                                    child: Text(
                                      "Start your journey with NEO Wallet today!",
                                      style: CustomTextStyler().styler(
                                          type: 'M',
                                          size: .015,
                                          color: neo_theme_blue3),
                                    ),
                                  )
                                ]),
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

import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

class PrivacypolicyScreen extends StatefulWidget {
  const PrivacypolicyScreen({super.key});

  @override
  State<PrivacypolicyScreen> createState() => _PrivacypolicyScreenState();
}

class _PrivacypolicyScreenState extends State<PrivacypolicyScreen> {
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
                      height: displaysize.height * .2,
                      width: displaysize.width,
                      child: Padding(
                        //fixed sized
                        padding: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .04),
                        child: Column(
                          children: [
                            CustomBackButton(
                              boarder: false,
                              title: 'Privacy Policy',
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
                                  displaysize.height * .2,
                              minWidth: constraints.maxWidth // Remaining space
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .045),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: displaysize.height * .03),
                                  Text(
                                      """Last Updated: 12/12/2024\n\nNEO Wallet values your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our app""",
                                      style: CustomTextStyler().styler(
                                          type: 'M',
                                          size: .015,
                                          color: neo_theme_blue3)),
                                  SizedBox(height: displaysize.height * .02),
                                  Text("Information We Collect",
                                      style: CustomTextStyler().styler(
                                          type: 'S',
                                          size: .018,
                                          color: neo_theme_blue3)),
                                  SizedBox(height: displaysize.height * .02),
                                  Text(
                                    """We may collect the following information:""",
                                    style: CustomTextStyler().styler(
                                        type: 'M',
                                        size: .015,
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
                                              "Personal Details: Name, phone number, email, and address.",
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
                                              "Transaction Data: Payment history, account balance, and transaction details.",
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
                                              "Device Information: IP address, device type, and operating system.",
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
                                              "Usage Data: App interactions, preferences, and settings.",
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
                                  Text("How We Use Your Information",
                                      style: CustomTextStyler().styler(
                                          type: 'S',
                                          size: .018,
                                          color: neo_theme_blue3)),
                                  SizedBox(height: displaysize.height * .02),
                                  Text(
                                    """We use your information to:""",
                                    style: CustomTextStyler().styler(
                                        type: 'M',
                                        size: .015,
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
                                              "Process payments and transactions securely.",
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
                                              "Provide a seamless user experience.",
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
                                              "Enhance security and prevent fraud.",
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
                                              "Send important updates and notifications.",
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
                                              "Analyze app performance and improve features.",
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
                                  Text("Data Protection & Security",
                                      style: CustomTextStyler().styler(
                                          type: 'S',
                                          size: .018,
                                          color: neo_theme_blue3)),
                                  SizedBox(height: displaysize.height * .02),
                                  Text(
                                    """We implement strong security measures, including encryption, two-factor authentication, and secure servers, to protect your data from unauthorized access.""",
                                    style: CustomTextStyler().styler(
                                        type: 'M',
                                        size: .015,
                                        color: neo_theme_blue3),
                                  ),
                                  SizedBox(height: displaysize.height * .02),
                                  Text("Contact Us",
                                      style: CustomTextStyler().styler(
                                          type: 'S',
                                          size: .018,
                                          color: neo_theme_blue3)),
                                  SizedBox(height: displaysize.height * .02),
                                  Text(
                                    "If you have any questions or concerns, contact us at:",
                                    style: CustomTextStyler().styler(
                                        type: 'M',
                                        size: .015,
                                        color: neo_theme_blue3),
                                  ),
                                  SizedBox(height: displaysize.height * .01),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            icon_mail,
                                            height: displaysize.height * .018,
                                            color: neo_theme_blue3,
                                          ),
                                          Text(' neowallet@gmail.com',
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            icon_call,
                                            height: displaysize.height * .018,
                                            color: neo_theme_blue3,
                                          ),
                                          Text(' +91 1234567890',
                                              style: CustomTextStyler().styler(
                                                  type: 'M',
                                                  size: .015,
                                                  color: neo_theme_blue3))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: displaysize.height * .03,
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

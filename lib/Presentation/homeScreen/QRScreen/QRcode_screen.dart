import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final userdataProvider =
        Provider.of<GetAccountDetailsProvider>(context, listen: false);
    final countryProvider =
        Provider.of<CountryProvider>(context, listen: false);
    Map<String, dynamic> qrData = {
      'country_id': countryProvider.user_country[0],
      'user_id': userdataProvider.userData?['id']
    };
    String encypt = jsonEncode(qrData);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: neo_theme_gradient),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
            child: Column(
              children: [
                CustomBackButton(
                  boarder: false,
                  title: 'QR Code',
                ),
                SizedBox(height: displaysize.height * .1),
                Container(
                  height: displaysize.height * .6,
                  width: displaysize.width * .85,
                  decoration: BoxDecoration(
                      color: neo_theme_white0,
                      borderRadius:
                          BorderRadius.circular(displaysize.width * .04),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: neo_theme_blue3)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${userdataProvider.userData?['name']}@neopay',
                        style: CustomTextStyler().styler(
                            size: .02, type: 'M', color: neo_theme_blue0),
                      ),
                      Column(
                        children: [
                          Center(
                            child: QrImageView(
                              data: encrypt(encypt),
                              version: QrVersions.auto,
                              size: displaysize.height * .32,
                              embeddedImage: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/10136/10136860.png'), // Centered image
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                size: const Size(50,
                                    50), // Adjust size of the logo inside QR
                              ),
                            ),
                          ),
                          Text(
                            'Scan to pay with any Neoapp Wallet',
                            style: CustomTextStyler().styler(
                                size: .013, type: 'M', color: neo_theme_grey2),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  color: neo_theme_blue0,
                                ),
                                SizedBox(
                                  width: displaysize.width * .02,
                                ),
                                Text(
                                  '${countryProvider.countryCode}  ${userdataProvider.userData?['phone_number']}',
                                  style: CustomTextStyler().styler(
                                      size: .018,
                                      type: 'M',
                                      color: neo_theme_blue0),
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail_outline_rounded,
                                color: neo_theme_blue0,
                              ),
                              SizedBox(
                                width: displaysize.width * .02,
                              ),
                              Text(
                                userdataProvider.userData?['email'],
                                style: CustomTextStyler().styler(
                                    size: .018,
                                    type: 'M',
                                    color: neo_theme_blue0),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String encrypt(String data) {
  return base64Encode(utf8.encode(data));
}

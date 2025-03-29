import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neo_pay/ShimmerPages/pay_country_shimmer.dart';
import 'package:neo_pay/api/DataProvider/othercontact_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrscanScreen extends StatefulWidget {
  const QrscanScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QrscanScreenState();
}

class _QrscanScreenState extends State<QrscanScreen> {
  bool light_status = true;
  Barcode? result;
  QRViewController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final qrdataProvider = Provider.of<QrDataprovider>(context);
    return Scaffold(
        body: Stack(
      children: [
        _buildQrView(context),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: displaysize.width * .04),
                child: CustomBackButton(
                  boarder: false,
                  title: 'Scan QR',
                ))),
        Positioned(
            bottom: displaysize.height * .13,
            right: 0,
            left: 0,
            child: SizedBox(
              child: Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller?.toggleFlash();
                        qrdataProvider.updatelightmode();
                      },
                      child: CircleAvatar(
                        radius: displaysize.height * .035,
                        backgroundColor: Colors.black.withValues(alpha: 0),
                        child: Icon(
                          qrdataProvider.light_mode
                              ? Icons.flashlight_off_rounded
                              : Icons.flashlight_on_rounded,
                          color: qrdataProvider.light_mode
                              ? neo_theme_white0
                              : neo_theme_grey2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: displaysize.height * .05,
                    ),
                    Container(
                      height: displaysize.height * .1,
                      width: displaysize.width * .8,
                      decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .3),
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          'Scan the QR code to make fast and secure payments instantly!',
                          textAlign: TextAlign.center,
                          style: CustomTextStyler().styler(
                              size: .015, color: neo_theme_white0, type: 'M'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          overlayColor: Colors.black.withValues(alpha: .5),
          borderRadius: 10,
          borderLength: 30,
          cutOutBottomOffset: 90,
          borderWidth: 15,
          cutOutSize: displaysize.height * .35),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this._controller = controller;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid = await prefs.getString('user_id');
    controller.scannedDataStream.listen((scanData) {
      print(scanData.code);
      Map<String, dynamic> data =
          jsonDecode(decrypt((scanData.code).toString()));
      if (data['user_id'].toString() != userid &&
          data['country_id'] != null &&
          data['user_id'] != null &&
          data['country_id'].toString().isNotEmpty &&
          data['user_id'].toString().isNotEmpty) {
        controller.pauseCamera();
        print(decrypt((scanData.code).toString()));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayCountryShimmer(
              route: true,
              receiver_id: data['user_id'],
              receiver_country: data['country_id'],
            ),
          ),
        ).then((_) {
          controller.resumeCamera();
        });
      }
    });
  }
}

String decrypt(String encryptedData) {
  return utf8.decode(base64Decode(encryptedData));
}

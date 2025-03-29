import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/main.dart';

Widget getTransactionIcon(
  dynamic transaction,
) {
  return switch (transaction.type) {
    "self" => Container(
        height: displaysize.height * .05,
        width: displaysize.height * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(displaysize.height / 4),
          color: neo_theme_blue0,
        ),
        child: Center(
          child: Image.asset(
            icon_wallet,
            height: displaysize.height * .025,
            color: neo_theme_white0,
          ),
        ),
      ),
    "Merchant" => Container(
        height: displaysize.height * .05,
        width: displaysize.height * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(displaysize.height / 4),
          color: Colors.amber,
        ),
        child: Center(
          child: Image.asset(
            icon_qrscan,
            height: displaysize.height * .025,
            color: neo_theme_white0,
          ),
        ),
      ),
    _ => Container(
        // Default case
        height: displaysize.height * .05,
        width: displaysize.height * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(displaysize.height / 4),
          image: DecorationImage(
            image: NetworkImage(transaction.partnerphoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
  };
}

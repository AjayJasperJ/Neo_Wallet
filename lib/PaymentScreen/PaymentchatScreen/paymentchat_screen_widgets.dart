import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

Widget CustomPaymentContainer(
    {required String receiver,
    required double amount,
    required bool status,
    required bool isSender,
    required DateTime date}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: displaysize.height * .01),
    padding: EdgeInsets.symmetric(
        vertical: displaysize.height * .02,
        horizontal: displaysize.width * .04),
    height: displaysize.height * .14,
    width: displaysize.width * .55,
    decoration: BoxDecoration(
      color: status
          ? neo_theme_blue0.withValues(alpha: 0.15)
          : Colors.red.withValues(alpha: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(displaysize.width * .06)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment ${isSender ? 'to' : 'from'} ${receiver.split(" ").first}",
            style: CustomTextStyler()
                .styler(type: 'M', size: .016, color: neo_theme_blue3)),
        Text("₹$amount",
            style: CustomTextStyler()
                .styler(type: 'M', size: .03, color: neo_theme_blue3)),
        Row(
          children: [
            CircleAvatar(
                backgroundColor: status ? neo_theme_green0 : Colors.red,
                radius: displaysize.height * .007,
                child: status
                    ? Image.asset(
                        icon_tick,
                        color: neo_theme_white0,
                        height: displaysize.height * .0065,
                      )
                    : Icon(
                        Icons.close,
                        size: displaysize.height * .01,
                        color: neo_theme_white0,
                      )),
            SizedBox(width: displaysize.width * .01),
            Text(status ? "Paid" : "Fail",
                style: CustomTextStyler()
                    .styler(type: 'M', size: .013, color: neo_theme_blue3)),
            SizedBox(width: displaysize.width * .01),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("•  ",
                    style: CustomTextStyler()
                        .styler(type: 'M', size: .013, color: neo_theme_blue3)),
                Text(
                  "${date.day} ${GetAlphabeticMonth(date.month)} ${date.year}",
                  style: CustomTextStyler()
                      .styler(type: 'M', size: .013, color: neo_theme_blue3),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

Widget CustomChatBackButton(BuildContext context,
    {required String receiver,
    required String phonenumber,
    required String profile}) {
  return Column(
    children: [
      SizedBox(height: displaysize.height * .08),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                height: (displaysize.height * .03) * 2,
                width: (displaysize.height * .03) * 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(displaysize.width / 4),
                    color: neo_theme_white2),
                child: Center(
                  child: Image.asset(
                    icon_back,
                    height: displaysize.height * .03,
                    color: neo_theme_white0,
                  ),
                ))),
        Row(
          children: [
            Container(
              height: (displaysize.height * .027) * 2,
              width: (displaysize.height * .027) * 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(profile), fit: BoxFit.cover),
                border: Border.all(color: neo_theme_white0, width: .3),
                borderRadius: BorderRadius.circular(displaysize.width / 4),
                color: neo_theme_white2,
              ),
            ),
            SizedBox(
              width: displaysize.width * .02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(receiver,
                    style: CustomTextStyler().styler(
                        type: 'R', size: .018, color: neo_theme_white0)),
                Text(phonenumber,
                    style: CustomTextStyler()
                        .styler(type: 'R', size: .015, color: neo_theme_white0))
              ],
            )
          ],
        ),
        CircleAvatar(
          radius: displaysize.height * .03,
          backgroundColor: neo_theme_white0.withValues(alpha: 0),
        )
      ]),
    ],
  );
}

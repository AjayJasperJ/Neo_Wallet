import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

Widget payment_methods(String icons, String title) {
  //payment option in home
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: neo_theme_white2,
        radius: displaysize.height * .042,
        child: Image.asset(
          icons,
          height: displaysize.height * .025,
        ),
      ),
      SizedBox(
        height: 2,
      ),
      Text(
        title,
        style: CustomTextStyler()
            .styler(size: .015, type: 'R', color: neo_theme_white0),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget profile_view(String icons, String title) {
  //people profile (history)
  return Column(
    children: [
      Container(
        height: displaysize.height * .070,
        width: displaysize.height * .070,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(displaysize.height * .082 / 2),
            image:
                DecorationImage(image: NetworkImage(icons), fit: BoxFit.cover)),
      ),
      SizedBox(
        height: displaysize.height * .008,
      ),
      Text(
        title.split(" ").first,
        style: CustomTextStyler()
            .styler(size: .016, type: 'M', color: neo_theme_blue3),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget lessOrMore(bool value) {
  //less and more button under people
  return Column(
    children: [
      Container(
        height: displaysize.height * .070,
        width: displaysize.height * .070,
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: neo_theme_grey1)),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: EdgeInsets.all(displaysize.height * .022),
          child: Image.asset(
            value ? icon_up : icon_more,
            color: neo_theme_blue3,
          ),
        ),
      ),
      SizedBox(
        height: displaysize.height * .004,
      ),
      Text(
        value ? "Less" : 'More',
        style: CustomTextStyler()
            .styler(size: .018, type: 'M', color: neo_theme_blue3),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/Presentation/NavigationScreen/navigationbar.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

Widget add_money(int amount) {
  return Container(
    height: displaysize.height * .05,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(displaysize.height / 4),
        border: Border.all(color: neo_theme_blue0, width: 1.5)),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: displaysize.width * .1),
      child: Center(
          child: Text("$amount",
              style: CustomTextStyler()
                  .styler(size: .018, type: 'M', color: neo_theme_blue0))),
    ),
  );
}

Widget jumptopage(BuildContext context, int pagenum, String title) {
  return Column(
    children: [
      SizedBox(
        height: displaysize.height * .08,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              context.read<GetAccountDetailsProvider>().updateamount('');
              Navigatorbar.pageController.jumpToPage(pagenum);
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
        Text(title,
            style: CustomTextStyler()
                .styler(size: .025, type: 'R', color: neo_theme_white0)),
        CircleAvatar(
          radius: displaysize.height * .03,
          backgroundColor: neo_theme_white0.withValues(alpha: 0),
        )
      ]),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:neo_pay/RegisterationScreens/LoginScreens/login_screen.dart';

RegisterationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: neo_theme_white0,
    barrierColor: Colors.white.withValues(alpha: 0),
    constraints: BoxConstraints(maxHeight: displaysize.height * .23),
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(displaysize.width * .04))),
    builder: (BuildContext context) {
      return Container(
          height: displaysize.height * .25,
          decoration: BoxDecoration(
              color: neo_theme_white0,
              boxShadow: [
                BoxShadow(
                    blurRadius: displaysize.height * .01,
                    color: neo_theme_grey2.withValues(alpha: .5))
              ],
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(displaysize.height * .02))),
          padding: EdgeInsets.symmetric(
              horizontal: displaysize.width * .04,
              vertical: displaysize.height * .01),
          child: _Sheetdata(context));
    },
  );
}

Column _Sheetdata(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: displaysize.height * .003,
        width: displaysize.width * .12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(displaysize.height / 4),
            color: neo_theme_grey2),
      ),
      SizedBox(),
      Container(
          height: displaysize.height * .06,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      method: true,
                    ),
                  ));
            },
            style: CustomElevatedButtonTheme(),
            child: Center(
                child: Text(
              "Login",
              style: CustomTextStyler()
                  .styler(size: .018, type: 'R', color: neo_theme_white0),
            )),
          )),
      Row(
        children: [
          Expanded(
              child: Divider(
            color: neo_theme_grey1,
            thickness: 1,
          )),
          SizedBox(
            width: displaysize.width * .03,
          ),
          Text("Or",
              style: CustomTextStyler()
                  .styler(size: .018, type: 'R', color: neo_theme_grey2)),
          SizedBox(
            width: displaysize.width * .03,
          ),
          Expanded(
              child: Divider(
            color: neo_theme_grey1,
            thickness: 1,
          ))
        ],
      ),
      Container(
        height: displaysize.height * .06,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    method: false,
                  ),
                ));
          },
          style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                      side: BorderSide(color: neo_theme_blue0, width: 1.5))),
                  splashFactory: InkSplash.splashFactory,
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(neo_theme_white0))
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
              child: Text("Sign Up",
                  style: CustomTextStyler()
                      .styler(size: .018, type: 'R', color: neo_theme_blue0))),
        ),
      ),
      SizedBox()
    ],
  );
}

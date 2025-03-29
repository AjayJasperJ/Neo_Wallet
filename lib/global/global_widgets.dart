import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatelessWidget {
  final dynamic title;
  final bool boarder;
  const CustomBackButton({super.key, this.title, required this.boarder});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: displaysize.height * .08),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                context.read<GetAccountDetailsProvider>().updateamount('');
                context
                    .read<GetAccountDetailsProvider>()
                    .updatebalance(context);

                Navigator.pop(context);
              },
              child: Container(
                  height: (displaysize.height * .03) * 2,
                  width: (displaysize.height * .03) * 2,
                  decoration: boarder
                      ? BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(displaysize.width / 4),
                          border: Border.fromBorderSide(
                              BorderSide(color: neo_theme_grey1)))
                      : BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(displaysize.width / 4),
                          color: neo_theme_white2),
                  child: Center(
                    child: Image.asset(
                      icon_back,
                      height: displaysize.height * .03,
                      color: boarder ? neo_theme_blue3 : neo_theme_white0,
                    ),
                  ))),
          Text(title ?? "",
              style: CustomTextStyler().styler(
                  size: .025,
                  type: boarder ? 'M' : 'R',
                  color: boarder ? neo_theme_blue3 : neo_theme_white0)),
          CircleAvatar(
            radius: displaysize.height * .03,
            backgroundColor: neo_theme_white0.withValues(alpha: 0),
          )
        ]),
      ],
    );
  }
}

ButtonStyle CustomElevatedButtonTheme() {
  return ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(neo_theme_blue0))
      .copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.white.withValues(alpha: 0.1);
        }
        return null;
      },
    ),
  );
}

ButtonStyle CustomElevatedButtonBoardedTheme() {
  return ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
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
  );
}

class CustomTextFormField1 extends StatelessWidget {
  final String? fieldname;
  final dynamic iconpath;
  final dynamic suffixicon;
  final FocusNode? focusnode;
  final FocusNode? nextnode;
  final TextInputType? keyboardtype;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputformat;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CustomTextFormField1({
    super.key,
    this.fieldname,
    this.iconpath,
    this.suffixicon,
    this.focusnode,
    this.nextnode,
    this.keyboardtype,
    this.controller,
    this.inputformat,
    this.readOnly = false,
    this.validator,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    void _fieldFocusChange(
        BuildContext context, FocusNode current, FocusNode? next) {
      current.unfocus();
      if (next != null) {
        FocusScope.of(context).requestFocus(next);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: focusnode,
          controller: controller,
          keyboardType: keyboardtype,
          cursorColor: neo_theme_blue0,
          inputFormatters: inputformat,
          readOnly: readOnly,
          validator: validator,
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          onChanged: onChanged,
          onFieldSubmitted: (_) {
            _fieldFocusChange(context, focusnode!, nextnode);
          },
          style: CustomTextStyler()
              .styler(size: .018, type: 'M', color: neo_theme_blue3),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 17),
            suffixIcon: suffixicon != null
                ? Padding(
                    padding: EdgeInsets.only(right: displaysize.width * .02),
                    child: suffixicon)
                : null,
            prefixIcon: iconpath != null
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: displaysize.width * .04),
                    height: displaysize.height * .025,
                    width: displaysize.height * .025,
                    child: Image.asset(
                      iconpath!,
                      color: neo_theme_grey2,
                      height: displaysize.height * .025,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : null,
            hintText: fieldname,
            hintStyle: CustomTextStyler()
                .styler(size: .016, type: 'M', color: neo_theme_grey2),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
              borderSide: BorderSide(color: neo_theme_grey1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
              borderSide: BorderSide(color: neo_theme_blue0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
              borderSide: BorderSide(color: neo_theme_blue0),
            ),
          ),
        ),
      ],
    );
  }
}

SizedBox CustomOTPField(
    BuildContext context, TextEditingController controller, FocusNode focusNode,
    {FocusNode? nextFocus, FocusNode? previousFocus}) {
  return SizedBox(
    height: displaysize.height * .065,
    width: displaysize.width * .2,
    child: RawKeyboardListener(
      focusNode: FocusNode(), // Listens for keyboard events
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            controller.text.isEmpty) {
          FocusScope.of(context).requestFocus(previousFocus);
        }
      },
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: CustomTextStyler()
            .styler(size: .018, type: 'M', color: neo_theme_blue3),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: "",
          contentPadding:
              EdgeInsets.symmetric(vertical: displaysize.height * .018),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(displaysize.width / 4),
            borderSide: BorderSide(color: neo_theme_grey1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(displaysize.width / 4),
            borderSide: BorderSide(color: neo_theme_blue0),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
      ),
    ),
  );
}

CustomDialogBox(BuildContext context, double height, Widget content) =>
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: neo_theme_white1,
                borderRadius: BorderRadius.circular(
                    displaysize.width * .06), // ✅ Increased Radius
              ),
              child: content,
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );

Column SuccessPopup({String? content, bool? payment}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundColor: payment ?? false ? neo_theme_green0 : neo_theme_blue0,
        radius: displaysize.height * .055,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: displaysize.height * .005),
            Image.asset(
              icon_tick,
              color: neo_theme_white0,
              height: displaysize.height * .04,
            ),
          ],
        ),
      ),
      SizedBox(
        height: displaysize.height * .03,
      ),
      Text(
        "$content!",
        style: CustomTextStyler()
            .styler(type: 'M', size: .025, color: neo_theme_blue3),
      )
    ],
  );
}

String GetAlphabeticMonth(int month) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[month - 1];
}

String GetFullAlphabeticMonth(int month) {
  const months = [
    "January",
    "February",
    "March",
    "Apri;",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return months[month - 1];
}

List<Map<String, dynamic>> transactions = [
  {
    "sender": "Alice",
    "receiver": "Abitha A",
    "amount": 50.0,
    "status": true,
    "date": DateTime(2025, 2, 25, 14, 13, 15, 500)
  },
  {
    "sender": "Abitha A",
    "receiver": "Alice",
    "amount": 100.0,
    "status": false,
    "date": DateTime(2025, 2, 24, 9, 44, 10, 200)
  },
  {
    "sender": "Abitha A",
    "receiver": "Alice",
    "amount": 100.0,
    "status": true,
    "date": DateTime(2025, 2, 24, 9, 45, 10, 200)
  },
  {
    "sender": "Alice",
    "receiver": "Abitha A",
    "amount": 120.0,
    "status": false,
    "date": DateTime(2025, 2, 22, 12, 5, 49, 300)
  },
  {
    "sender": "Alice",
    "receiver": "Abitha A",
    "amount": 75.5,
    "status": true,
    "date": DateTime(2025, 2, 23, 18, 10, 30, 800)
  },
  {
    "sender": "Alice",
    "receiver": "Abitha A",
    "amount": 120.0,
    "status": true,
    "date": DateTime(2025, 2, 22, 12, 5, 50, 300)
  },
  {
    "sender": "Abitha A",
    "receiver": "Alice",
    "amount": 90.0,
    "status": true,
    "date": DateTime(2025, 2, 22, 16, 25, 40, 600)
  },
];

SnackBar CustomSnackBar(String textdata) {
  return SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      textdata,
      style: CustomTextStyler()
          .styler(size: .015, color: neo_theme_white0, type: 'M'),
    ),
    backgroundColor: neo_theme_blue0,
  );
}

class GlobalAlertDialog {
  static void show(BuildContext context,
      {required int value, required String msg}) {
    final Completer<void> dialogCompleter = Completer<void>();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        // Wait for 3 seconds, then close the dialog safely
        Future.delayed(Duration(seconds: 3), () {
          if (!dialogCompleter.isCompleted && context.mounted) {
            Navigator.pop(context);
            dialogCompleter.complete(); // Mark as completed
          }
        });

        final List<Map<String, dynamic>> dialogdata = [
          {
            'gif': 'assets/animation/animation1.json',
            'color': neo_theme_white1
          },
          {'gif': 'assets/animation/animation4.json', 'color': Colors.red[50]},
          {
            'gif': 'assets/animation/animation2.json',
            'color': neo_theme_white1
          },
          {'gif': 'assets/animation/animation3.json', 'color': neo_theme_white1}
        ];

        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: displaysize.height * .3,
              width: displaysize.width * .5,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: dialogdata[value]['color']!,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(dialogdata[value]['gif']!, repeat: false),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: CustomTextStyler()
                        .styler(size: .018, color: neo_theme_blue3, type: 'M'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then((_) {
      // Mark dialog as completed when manually closed
      if (!dialogCompleter.isCompleted) {
        dialogCompleter.complete();
      }
    });
  }
}

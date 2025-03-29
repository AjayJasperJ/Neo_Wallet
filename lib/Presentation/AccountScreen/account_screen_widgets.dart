import 'package:flutter/material.dart';
import 'package:neo_pay/Presentation/AccountScreen/EditaccountScreen/edit_account_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/QRScreen/QRcode_screen.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

Widget profile_card(BuildContext context,
    {String? username,
    String? phone_number,
    String? email,
    String? dob,
    String? profile,
    String? address}) {
  return Stack(children: [
    Container(
      padding: EdgeInsets.symmetric(
          horizontal: displaysize.width * .05,
          vertical: displaysize.height * .02),
      height: (displaysize.height * .45) * .5,
      decoration: BoxDecoration(
          color: neo_theme_white2,
          borderRadius: BorderRadius.circular(displaysize.width * .04)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: displaysize.height * .13,
                    width: displaysize.height * .13,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(displaysize.height / 4),
                        image: DecorationImage(
                            image: profile == null
                                ? AssetImage(image_empty_profile)
                                : NetworkImage(profile),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QRCodeScreen()));
                        },
                        child: CircleAvatar(
                          radius: displaysize.height * .02,
                          backgroundColor: neo_theme_blue0,
                          child: Center(
                              child: Image.asset(
                            icon_qrcode,
                            height: displaysize.height * .02,
                          )),
                        ),
                      ))
                ],
              ),
              SizedBox(width: displaysize.width * .06),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username!.length > 18
                        ? (username[0].toUpperCase() + username.substring(1))
                                .substring(0, 18) +
                            "..."
                        : username[0].toUpperCase() + username.substring(1),
                    style: TextStyle(
                        color: neo_theme_white0,
                        fontSize: displaysize.height * .02),
                  ),
                  SizedBox(), //temp
                  _card_data(icon_call, phone_number),
                  _card_data(icon_mail, email?.toLowerCase()),
                  _card_data(icon_calender, dob),
                  _card_data(
                      icon_location,
                      address![0].toUpperCase() +
                          address.substring(1).toLowerCase())
                ],
              )
            ],
          ),
        ],
      ),
    ),
    Positioned(
        top: displaysize.height * .02,
        right: displaysize.width * .04,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => EditAccountdetailProvider(
                        Provider.of<GetAccountDetailsProvider>(context,
                            listen: false)),
                    child: EditAccountScreen(
                      currentimage: profile!,
                      currentusername:
                          username[0].toUpperCase() + username.substring(1),
                      currentemail: email!,
                      currentdob: dob!,
                      currentaddress: address,
                    ),
                  ),
                ));
          },
          child: CircleAvatar(
            backgroundColor: neo_theme_blue0.withValues(alpha: 0),
            child: Image.asset(
              icon_edit,
              color: neo_theme_white0,
              height: displaysize.height * .025,
            ),
          ),
        ))
  ]);
}

Row _card_data(String imagepath, textdata) {
  return Row(
    children: [
      Image.asset(
        color: neo_theme_white0,
        imagepath,
        height: displaysize.height * .018,
      ),
      SizedBox(
        width: 10,
      ),
      Text(
          textdata!.toString().length < 18
              ? textdata!
              : textdata!.toString().substring(0, 18) + "...",
          style: CustomTextStyler()
              .styler(size: .015, type: 'R', color: neo_theme_white0))
    ],
  );
}

Widget settings_options(String imagepath, String title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: displaysize.width * .05),
    height: displaysize.height * .08,
    margin: EdgeInsets.symmetric(vertical: displaysize.height * .006),
    width: displaysize.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(displaysize.height * .022),
        color: neo_theme_white0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              imagepath,
              height: displaysize.height * .026,
            ),
            SizedBox(
              width: displaysize.width * .04,
            ),
            Text(
              title,
              style: CustomTextStyler()
                  .styler(size: .018, type: 'M', color: neo_theme_blue3),
            )
          ],
        ),
        Image.asset(
          icon_forward,
          height: displaysize.height * .026,
        )
      ],
    ),
  );
}

pushmetopage(BuildContext context, int num, Widget target) {
  if (num == 1) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => target));
  } else if (num == 2) {
    return target;
  }
}

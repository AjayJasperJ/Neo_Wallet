import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/ShimmerPages/country_shimmer.dart';
import 'package:neo_pay/ShimmerPages/pay_country_shimmer.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/othercontact_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PaynumberScreen extends StatefulWidget {
  const PaynumberScreen({super.key});

  @override
  State<PaynumberScreen> createState() => _PaynumberScreenState();
}

class _PaynumberScreenState extends State<PaynumberScreen> {
  TextEditingController contact_controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedCountryCode = '';
  String selectedFlag = '';
  String selectedName = '';
  Future<void> _selectCountry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CountryShimmer(
                value: false,
              )),
    );

    if (result != null) {
      setState(() {
        selectedCountryCode = result['country_code'];
        selectedFlag = result['country_flag'];
        selectedName = result['country_name'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCountryCode = context.read<CountryProvider>().receivercode;
    selectedFlag = context.read<CountryProvider>().receiverflage;
    selectedName = context.read<CountryProvider>().receivercname;
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);
    final othercontactProvider = Provider.of<OtherusercontactProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                boarder: true,
                title: "Pay Number",
              ),
              SizedBox(height: displaysize.height * .03),
              Text("Enter Recipent number",
                  style: CustomTextStyler()
                      .styler(size: .025, type: 'S', color: neo_theme_blue3)),
              SizedBox(
                height: displaysize.height * .02,
              ),
              Text(
                  "Send money instantly to any phone number, any country effortlessly!",
                  style: CustomTextStyler()
                      .styler(size: .016, type: 'M', color: neo_theme_blue3)),
              SizedBox(
                height: displaysize.height * .04,
              ),
              GestureDetector(
                onTap: _selectCountry,
                child: Container(
                  height: displaysize.height * .068,
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                        BorderSide(color: neo_theme_grey1)),
                    borderRadius: BorderRadius.circular(displaysize.width / 4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: displaysize.width * .04),
                    child: _country_format(
                        context,
                        countryProvider.receiverflage,
                        countryProvider.receivercname),
                  ),
                ),
              ),
              SizedBox(
                height: displaysize.height * .04,
              ),
              Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: contact_controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    cursorColor: neo_theme_blue0,
                    style: CustomTextStyler()
                        .styler(size: .018, type: 'M', color: neo_theme_blue3),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 17),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: displaysize.width * .05),
                        child: Consumer<CountryProvider>(
                          builder: (context, value, child) {
                            return Container(
                              color: neo_theme_blue0.withValues(alpha: 0),
                              width: displaysize.width * .15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${value.receivercode}',
                                    style: CustomTextStyler().styler(
                                        size: .016,
                                        type: 'M',
                                        color: neo_theme_grey2),
                                  ),
                                  Image.asset(
                                    icon_down,
                                    height: displaysize.height * .02,
                                    color: neo_theme_grey2,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      hintText: "Phone Number",
                      hintStyle: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_grey2),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(displaysize.width / 4),
                        borderSide: BorderSide(color: neo_theme_grey1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(displaysize.width / 4),
                        borderSide: BorderSide(color: neo_theme_blue0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(displaysize.width / 4),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(displaysize.width / 4),
                        borderSide: BorderSide(color: neo_theme_blue0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      } else if (value.length < 10) {
                        return "Enter a valid 10-digit phone number";
                      }
                      return null;
                    },
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
        child: SizedBox(
          height: displaysize.height * .1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: displaysize.height * .06,
                  child: othercontactProvider.checkloading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: neo_theme_blue0,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final status =
                                  await othercontactProvider.contactcheck(
                                      context,
                                      contact_controller.text,
                                      countryProvider.receivercode);
                              if (status[0] == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PayCountryShimmer(route: false,
                                            receiver_country: status[1],
                                            receiver_id: status[2])));
                              }
                            }
                          },
                          style: CustomElevatedButtonTheme(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next",
                                  style: CustomTextStyler().styler(
                                      size: .018,
                                      type: 'R',
                                      color: neo_theme_white0)),
                              SizedBox(
                                width: displaysize.width * .015,
                              ),
                              Image.asset(
                                icon_right_arrow,
                                height: displaysize.height * .03,
                              )
                            ],
                          ),
                        )),
              SizedBox(
                height: displaysize.height * .02,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Row _country_format(BuildContext context, String imagepath, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(children: [
        CircleAvatar(
          radius: displaysize.width * .03,
          backgroundColor: neo_theme_white1,
          backgroundImage: NetworkImage(imagepath),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: CustomTextStyler()
              .styler(size: .016, type: 'M', color: neo_theme_blue3),
        )
      ]),
      Image.asset(
        icon_down,
        height: displaysize.height * .025,
        color: neo_theme_blue3,
      )
    ],
  );
}

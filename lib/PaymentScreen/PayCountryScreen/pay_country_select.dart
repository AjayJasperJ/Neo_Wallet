import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PayCountrySelect extends StatefulWidget {
  const PayCountrySelect({super.key});

  @override
  State<PayCountrySelect> createState() => _PayCountrySelectState();
}

class _PayCountrySelectState extends State<PayCountrySelect> {
  TextEditingController countryController = TextEditingController();

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displaysize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(boarder: true),
                SizedBox(height: displaysize.height * 0.03),
                Text(
                  "Pick recipient country",
                  style: CustomTextStyler().styler(
                    size: 0.025,
                    type: 'S',
                    color: neo_theme_blue3,
                  ),
                ),
                SizedBox(height: displaysize.height * 0.02),
                Text(
                  "Choose the nation where recipient currently live or reside.",
                  style: CustomTextStyler().styler(
                    size: 0.016,
                    type: 'M',
                    color: neo_theme_blue3,
                  ),
                ),
                SizedBox(height: displaysize.height * 0.03),
                CustomTextFormField1(
                  controller: countryController,
                  fieldname: "Search Here...",
                  iconpath: icon_search,
                  onChanged: (value) {
                    countryProvider.searchCountry(value);
                  },
                ),
                SizedBox(height: displaysize.height * .01),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: countryProvider.countryList.length,
              padding:
                  EdgeInsets.symmetric(vertical: displaysize.height * 0.01),
              itemBuilder: (context, index) {
                final country = countryProvider.countryList[index];

                return GestureDetector(
                  onTap: () {
                    countryProvider.updatereceiverCountry(
                        country.country_code,
                        country.country_flag,
                        country.country_id,
                        country.country_name);
                    Navigator.pop(context, {
                      'country_code': country.country_code,
                      'country_flag': country.country_flag,
                      'country_name': country.country_name
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: displaysize.height * 0.008,
                      horizontal: displaysize.width * 0.04,
                    ),
                    height: displaysize.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(color: neo_theme_grey0),
                      borderRadius:
                          BorderRadius.circular(displaysize.width / 4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: displaysize.width * .04),
                      child: _countryFormat(
                        context,
                        country.country_name,
                        country.country_flag,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Row _countryFormat(
  BuildContext context,
  String countryName,
  String imagePath,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: displaysize.height * .012,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(imagePath),
          ),
          SizedBox(width: displaysize.width * .04),
          Text(
            countryName,
            style: CustomTextStyler().styler(
              size: 0.016,
              type: 'M',
              color: neo_theme_blue3,
            ),
          ),
        ],
      ),
      Image.asset(
        icon_unselected,
        height: displaysize.height * .025,
      ),
    ],
  );
}

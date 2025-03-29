import 'package:flutter/material.dart';
import 'package:neo_pay/ShimmerPages/navigatorbar_shimmer.dart';
import 'package:neo_pay/ShimmerPages/pay_country_shimmer.dart';
import 'package:neo_pay/api/DataProvider/contact_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PaycontactScreen extends StatefulWidget {
  const PaycontactScreen({super.key});

  @override
  State<PaycontactScreen> createState() => _PaycontactScreenState();
}

class _PaycontactScreenState extends State<PaycontactScreen> {
  final TextEditingController _searchcontactcontroller =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    final contactProvider = Provider.of<ContactDataprovider>(
      context,
      listen: false,
    );
    contactProvider.fetchContactsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final contactdataProvider = Provider.of<ContactDataprovider>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(boarder: true, title: 'Pay contact'),
                SizedBox(height: displaysize.height * .02),
                CustomTextFormField1(
                  controller: _searchcontactcontroller,
                  fieldname: "Search Contacts...",
                  iconpath: icon_search,
                  onChanged: (value) =>
                      contactdataProvider.searchContacts(value),
                ),
                SizedBox(height: displaysize.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Contact",
                      style: CustomTextStyler().styler(
                        size: .025,
                        type: 'M',
                        color: neo_theme_blue3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: displaysize.height * .01),
              ],
            ),
          ),
          Expanded(
            child: contactdataProvider.isLoading
                ? ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: displaysize.height * .01),
                      child: customShimmerEffect(
                        height: displaysize.height * .075,
                        width: displaysize.width,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: contactdataProvider.filteredContacts.length,
                    padding: EdgeInsets.symmetric(
                        vertical: displaysize.height * .01),
                    itemBuilder: (context, index) {
                      var contact = contactdataProvider.filteredContacts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PayCountryShimmer(
                                    route: false,
                                    receiver_country: contact['country_id'],
                                    receiver_id: contact['id']),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: displaysize.height * .008,
                            horizontal: displaysize.width * .04,
                          ),
                          height: displaysize.height * .075,
                          decoration: BoxDecoration(
                            border: Border.fromBorderSide(
                              BorderSide(color: neo_theme_grey1, width: 0.5),
                            ),
                            borderRadius: BorderRadius.circular(
                              displaysize.width / 4,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: displaysize.width * .03,
                            ),
                            child: _Contacts_list(
                              context,
                              Countrycode: contact['country_code'],
                              imagepath: contact['avatar'],
                              username: contact['name'],
                              Number: contact['phone'],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}

Row _Contacts_list(BuildContext context,
    {String? imagepath,
    String? username,
    String? Number,
    String? Countrycode}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: displaysize.width * .055,
            backgroundColor: neo_theme_white1,
            backgroundImage: NetworkImage(imagepath!),
          ),
          SizedBox(width: displaysize.width * .04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username!,
                style: CustomTextStyler().styler(
                  size: .02,
                  type: 'M',
                  color: neo_theme_blue3,
                ),
              ),
              Row(
                children: [
                  Text(
                    Countrycode ?? 'D',
                    style: CustomTextStyler().styler(
                      size: .015,
                      type: 'M',
                      color: neo_theme_blue3,
                    ),
                  ),
                  SizedBox(width: displaysize.width * .01),
                  Text(
                    Number!,
                    style: CustomTextStyler().styler(
                      size: .015,
                      type: 'M',
                      color: neo_theme_blue3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Container(
            height: displaysize.width * .05,
            width: displaysize.width * .05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.fromBorderSide(BorderSide(color: neo_theme_grey0)),
            ),
          ),
          SizedBox(width: displaysize.width * .02),
        ],
      ),
    ],
  );
}

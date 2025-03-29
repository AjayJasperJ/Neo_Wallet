import 'package:flutter/material.dart';
import 'package:neo_pay/PaymentScreen/PayCountryScreen/pay_different_country.dart';
import 'package:neo_pay/PaymentScreen/PayCountryScreen/pay_same_country.dart';
import 'package:neo_pay/ShimmerPages/navigatorbar_shimmer.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/othercontact_dataprovider.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PayCountryShimmer extends StatefulWidget {
  final bool route;
  final String receiver_country;
  final String receiver_id;

  const PayCountryShimmer(
      {super.key,
      required this.route,
      required this.receiver_country,
      required this.receiver_id});

  @override
  _PayCountryShimmerState createState() => _PayCountryShimmerState();
}

class _PayCountryShimmerState extends State<PayCountryShimmer> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final otherusercontactProvider =
          Provider.of<OtherusercontactProvider>(context, listen: false);
      await otherusercontactProvider.fetchothercontacts();
      if (widget.receiver_country !=
          Provider.of<CountryProvider>(context, listen: false)
              .user_country[0]) {
        await Provider.of<CountryProvider>(context, listen: false)
            .findusercountrywithID(
                countryid: widget.receiver_country, save: false);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return FakePayCountry(); // Show loading state
    }

    final countryProvider = Provider.of<CountryProvider>(context);
    final otherusercontactProvider =
        Provider.of<OtherusercontactProvider>(context, listen: false);

    return Consumer<OtherusercontactProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading || provider.apiContacts.isEmpty) {
          return FakePayCountry();
        }

        final data = otherusercontactProvider.apiContacts
            .firstWhere((id) => id.id == widget.receiver_id);

        if (widget.receiver_country == countryProvider.user_country[0]) {
          return PaySameCountry(
            route: widget.route,
            receiver_data: data,
          );
        } else {
          return PayDifferentCountry(
            receiver_data: data,
            sender_country: countryProvider.user_country,
          );
        }
      },
    );
  }
}

class FakePayCountry extends StatefulWidget {
  const FakePayCountry({super.key});

  @override
  State<FakePayCountry> createState() => _FakePayCountryState();
}

class _FakePayCountryState extends State<FakePayCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: displaysize.height * .08),
                Align(
                  alignment: Alignment.centerLeft,
                  child: customShimmerEffect(
                    height: (displaysize.height * .03) * 2,
                    width: (displaysize.height * .03) * 2,
                  ),
                ),
                SizedBox(height: displaysize.height * .03),
                customShimmerEffect(
                  height: displaysize.height * .11,
                  width: displaysize.height * .11,
                ),
                SizedBox(height: displaysize.height * .02),
                customShimmerEffect(
                    height: displaysize.height * .03,
                    width: displaysize.height * .18,
                    radius: displaysize.width * .02),
                SizedBox(height: displaysize.height * .01),
                customShimmerEffect(
                  height: displaysize.height * .015,
                  width: displaysize.height * .15,
                  radius: displaysize.width * .02,
                ),
                SizedBox(height: displaysize.height * .12),
                customShimmerEffect(
                    height: displaysize.height * .04,
                    width: displaysize.height * .18,
                    radius: displaysize.width * .02),
                SizedBox(
                  height: displaysize.height * .08,
                ),
                customShimmerEffect(
                  height: displaysize.height * .06,
                  width: displaysize.width * .8,
                ),
              ],
            ),
            Column(
              children: [
                customShimmerEffect(
                  height: displaysize.height * .06,
                  width: displaysize.width,
                ),
                SizedBox(height: displaysize.height * .02),
              ],
            )
          ],
        ),
      ),
    );
  }
}

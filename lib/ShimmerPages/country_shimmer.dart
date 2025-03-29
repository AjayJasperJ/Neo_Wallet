import 'package:flutter/material.dart';
import 'package:neo_pay/PaymentScreen/PayCountryScreen/pay_country_select.dart';
import 'package:neo_pay/RegisterationScreens/LoginScreens/select_country.dart';
import 'package:neo_pay/ShimmerPages/navigatorbar_shimmer.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class CountryShimmer extends StatefulWidget {
  final bool value;

  const CountryShimmer({super.key, required this.value});
  @override
  _CountryShimmerState createState() => _CountryShimmerState();
}

class _CountryShimmerState extends State<CountryShimmer> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final countryProvider =
          Provider.of<CountryProvider>(context, listen: false);
      countryProvider.getCountryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return FakeSelectContactscreen();
        } else {
          if (widget.value) {
            return SelectCountry();
          } else {
            return PayCountrySelect();
          }
        }
      },
    );
  }
}

class FakeSelectContactscreen extends StatelessWidget {
  const FakeSelectContactscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displaysize.height * .08),
              customShimmerEffect(
                height: (displaysize.height * .03) * 2,
                width: (displaysize.height * .03) * 2,
              ),
              SizedBox(height: displaysize.height * 0.03),
              customShimmerEffect(
                  height: displaysize.height * .04,
                  width: displaysize.width * .6,
                  radius: displaysize.width * .03),
              SizedBox(height: displaysize.height * 0.02),
              customShimmerEffect(
                  height: displaysize.height * .015,
                  width: displaysize.width * .85,
                  radius: displaysize.width * .03),
              SizedBox(height: displaysize.height * 0.01),
              customShimmerEffect(
                  height: displaysize.height * .015,
                  width: displaysize.width * .3,
                  radius: displaysize.width * .03),
              SizedBox(height: displaysize.height * 0.03),
              customShimmerEffect(
                height: displaysize.height * .065,
                width: displaysize.width,
              ),
              ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: displaysize.height * .01),
                  child: customShimmerEffect(
                    height: displaysize.height * .075,
                    width: displaysize.width,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:neo_pay/Presentation/NavigationScreen/navigationbar.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/connection_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class NavigatorbarShimmer extends StatefulWidget {
  @override
  _NavigatorbarShimmerState createState() => _NavigatorbarShimmerState();
}

class _NavigatorbarShimmerState extends State<NavigatorbarShimmer> {
  Future<void> fetchUserCredential() async {
    final prefs = await SharedPreferences.getInstance();
    final getAccountDetailsProvider =
        Provider.of<GetAccountDetailsProvider>(context, listen: false);
    final countryProvider =
        Provider.of<CountryProvider>(context, listen: false);
    final finanacialgoalProvider =
        Provider.of<FinancialgoalDataprovider>(context, listen: false);

    await getAccountDetailsProvider.fetchUserDetails(context);
    await getAccountDetailsProvider.totalfinancialtransaction(context);
    await finanacialgoalProvider.view_financial_goal(context);
    getAccountDetailsProvider.updatebalance(context);
    finanacialgoalProvider.getcategoriesdata(context);

    final data = prefs.getStringList('user_country_data');
    if (data == null ||
        data.isEmpty ||
        data[0] != getAccountDetailsProvider.userData!['country_id']) {
      await countryProvider.findusercountrywithID(
          countryid: getAccountDetailsProvider.userData!['country_id'],
          save: true);
      getAccountDetailsProvider.updateloading();
    } else {
      countryProvider
          .update_user_country(prefs.getStringList('user_country_data'));
      getAccountDetailsProvider.updateloading();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      fetchUserCredential();
    });
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    connectivityProvider.addListener(
      () {
        if (connectivityProvider.isConnected) {
          fetchUserCredential();
        }
      },
    );
    return Consumer<GetAccountDetailsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return FakeNavigatorbar();
        } else if (provider.userData == null) {
          return FakeNavigatorbar();
        } else {
          return Navigatorbar();
        }
      },
    );
  }
}

Widget customShimmerEffect({double? height, double? width, double? radius}) {
  return Shimmer.fromColors(
    baseColor: neo_theme_grey0.withValues(alpha: .3),
    highlightColor: neo_theme_grey0,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? displaysize.height / 4),
        color: Colors.white,
      ),
    ),
  );
}

class FakeNavigatorbar extends StatefulWidget {
  const FakeNavigatorbar({super.key});

  @override
  State<FakeNavigatorbar> createState() => _FakeNavigatorbarState();
}

class _FakeNavigatorbarState extends State<FakeNavigatorbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: displaysize.height * .08),
                        Row(
                          children: [
                            customShimmerEffect(
                              height: displaysize.height * .08,
                              width: displaysize.height * .08,
                            ),
                            SizedBox(width: displaysize.width * .04),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customShimmerEffect(
                                    height: displaysize.height * .02,
                                    width: displaysize.width * .5,
                                    radius: displaysize.width * .02),
                                SizedBox(height: displaysize.height * .01),
                                customShimmerEffect(
                                    height: displaysize.height * .02,
                                    width: displaysize.width * .3,
                                    radius: displaysize.width * .02),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: displaysize.height * .02),
                        customShimmerEffect(
                            height: displaysize.height * .25,
                            width: displaysize.width,
                            radius: displaysize.width * .06),
                        SizedBox(height: displaysize.height * .03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(4, (_) {
                            return Column(
                              children: [
                                customShimmerEffect(
                                    height: displaysize.height * .08,
                                    width: displaysize.height * .08),
                                SizedBox(height: displaysize.height * .01),
                                customShimmerEffect(
                                    height: displaysize.height * .01,
                                    width: displaysize.width * .10,
                                    radius: displaysize.width * .02),
                                SizedBox(height: displaysize.height * .005),
                                customShimmerEffect(
                                    height: displaysize.height * .01,
                                    width: displaysize.width * .16,
                                    radius: displaysize.width * .02)
                              ],
                            );
                          }),
                        ),
                        SizedBox(height: displaysize.height * .03),
                        customShimmerEffect(
                            height: displaysize.height * .025,
                            width: displaysize.width * .3,
                            radius: displaysize.width * .02)
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          customShimmerEffect(
                              height: displaysize.height * .02,
                              width: displaysize.width * .5,
                              radius: displaysize.width * .02),
                        ],
                      ),
                      SizedBox(height: displaysize.height * .02),
                      customShimmerEffect(
                          height: displaysize.height * .01,
                          width: displaysize.width,
                          radius: displaysize.width * .01),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: displaysize.height * .1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customShimmerEffect(
                height: displaysize.height * .005,
                width: displaysize.width,
                radius: displaysize.width * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (_) {
                return Column(
                  children: [
                    customShimmerEffect(
                        height: displaysize.height * .04,
                        width: displaysize.height * .04,
                        radius: displaysize.width * .02),
                    SizedBox(height: displaysize.height * .01),
                    customShimmerEffect(
                        height: displaysize.height * .01,
                        width: displaysize.height * .04,
                        radius: displaysize.width * .02)
                  ],
                );
              }),
            ),
            SizedBox(
              height: displaysize.height * .01,
            )
          ],
        ),
      ),
    );
  }
}

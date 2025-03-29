import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_pay/SplashScreens/splash_screen.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/chat_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/connection_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/othercontact_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/transaction_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:provider/provider.dart';

late Size displaysize;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    displaysize = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: neo_theme_white1,
          fontFamily: 'general_sans'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((context) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
          ChangeNotifierProvider(create: (context) => ChatDataprovider()),
          ChangeNotifierProvider(create: (context) => TransactionProvider()),
          ChangeNotifierProvider(
              create: (context) => FinancialgoalDataprovider()),
          ChangeNotifierProvider(
              create: (context) => OtherusercontactProvider(
                    Provider.of<ConnectivityProvider>(context, listen: false),
                  )),
          ChangeNotifierProvider(
            create: (context) => GetAccountDetailsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CountryProvider(
              Provider.of<ConnectivityProvider>(context, listen: false),
            ),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

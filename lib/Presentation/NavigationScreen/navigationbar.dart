import 'package:flutter/material.dart';
import 'package:neo_pay/Presentation/AccountScreen/account_screen.dart';
import 'package:neo_pay/Presentation/TransactionScreen/transaction_screen.dart';
import 'package:neo_pay/Presentation/WalletScreen/wallet_screen.dart';
import 'package:neo_pay/Presentation/homeScreen/home_screen.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class Navigatorbar extends StatefulWidget {
  static final PageController pageController = PageController();
  const Navigatorbar({super.key});

  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    WalletScreen(),
    TransactionScreen(),
    AccountScreen(),
  ];

  void onTabTapped(int index) {
    Navigatorbar.pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: Navigatorbar.pageController,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                children: _pages,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: constraints.maxHeight * 0.09,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(constraints.maxWidth * 0.04),
                  ),
                  color: neo_theme_white0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navigationIcon(icon_home, 'Home', 0),
                    _navigationIcon(icon_wallet, 'Wallet', 1),
                    _navigationIcon(icon_transaction, 'Transaction', 2),
                    _navigationIcon(icon_account, 'Account', 3),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _navigationIcon(String iconPath, String title, int index) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index != 1) {
          context.read<GetAccountDetailsProvider>().updateamount('');
        }
        onTabTapped(index);
      },
      child: Container(
        color: neo_theme_white0.withValues(alpha: 0),
        width: displaysize.width * .18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: isSelected ? neo_theme_blue0 : neo_theme_blue3,
              height: displaysize.height * .028,
            ),
            SizedBox(height: displaysize.height * .003),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'general_sans',
                    fontWeight: FontWeight.w500,
                    fontSize: displaysize.height * .013,
                    color: isSelected ? neo_theme_blue0 : neo_theme_blue3,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

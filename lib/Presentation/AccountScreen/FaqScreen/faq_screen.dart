import 'package:flutter/material.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int currentIndex = -1;

  List<Map<String, String>> _faq_data = [
    {
      "title": "How do I add money to my NEO Wallet?",
      "data":
          'You can add money by linking your bank account, debit/credit card, or using supported payment methods within the app.'
    },
    {
      'title': "Is my money safe in Neo Wallet?",
      "data":
          'Yes! We use bank-grade encryption and security protocols to protect your transactions and personal data.'
    },
    {
      'title': 'Can I send money internationally?',
      "data":
          'Absolutely! NEO Wallet allows you to transfer money globally with minimal fees and instant processing.'
    },
    {
      'title': 'How do I set a montly spending limit?',
      "data":
          'Go to the "spending Tracker" section and set a custome limit to manage your expenses effectively.'
    },
    {
      'title': 'What happens if i forget my 4-digit PIN?',
      "data":
          'You can reset your PIN by verifying your identity throgh your registered phone number or email.'
    },
    {
      'title': 'Are there any transaction fees',
      "data":
          'Basic transactions are free, but some international transfers or instant withdrawals may have minimal charges.'
    },
    {
      'title': 'How can I track where I spend the most?',
      "data":
          'The app provides detailed insights and categorizes your spending so you can easily monitor and manage expenses.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: neo_theme_gradient),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomBackButton(
                boarder: false,
                title: "FAQs",
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _faq_data.length,
                itemBuilder: (context, index) {
                  return ExpandableItem(
                    title: "${index + 1}. ${_faq_data[index]['title']}",
                    data: _faq_data[index]['data'].toString(),
                    isExpanded: currentIndex == index,
                    onTap: () {
                      setState(() {
                        currentIndex = (currentIndex == index) ? -1 : index;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableItem extends StatefulWidget {
  final String title;
  final String data;
  final bool isExpanded;
  final VoidCallback onTap;

  const ExpandableItem(
      {super.key,
      required this.title,
      required this.data,
      required this.isExpanded,
      required this.onTap});

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<double>(begin: -10, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant ExpandableItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: displaysize.height * .065,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(400),
              border: Border.all(width: 1.2, color: neo_theme_white0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                    style: CustomTextStyler().styler(
                        size: .015, color: neo_theme_white0, type: 'M')),
                AnimatedRotation(
                  turns: widget.isExpanded ? -0.125 : 0,
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.add,
                    size: displaysize.height * .03,
                    color: neo_theme_white0,
                  ),
                ),
              ],
            ),
          ),
        ),

        /// **Fix: Using AnimatedSize for smooth expansion**
        AnimatedSize(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: widget.isExpanded
              ? FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation.drive(
                      Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0)),
                    ),
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: displaysize.height * .008),
                        width: displaysize.width * .9,
                        padding: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .06,
                            vertical: displaysize.height * .02),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(displaysize.width * .06),
                          color: neo_theme_white0,
                        ),
                        child: Text(
                          widget.data,
                          style: TextStyle(
                              fontSize: displaysize.height * .017,
                              height: 1.8,
                              color: neo_theme_blue3,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              : SizedBox(), // Prevents size glitch
        ),
      ],
    );
  }
}

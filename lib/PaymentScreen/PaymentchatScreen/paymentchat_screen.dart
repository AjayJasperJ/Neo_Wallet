import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo_pay/PaymentScreen/PaymentchatScreen/paymentchat_screen_widgets.dart';
import 'package:neo_pay/ShimmerPages/pay_country_shimmer.dart';
import 'package:neo_pay/api/DataProvider/chat_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PaymentchatScreen extends StatefulWidget {
  final String target_id;
  final String profile_pic;
  final String name;
  final String country_code;
  final String phone;
  final String country_id;
  const PaymentchatScreen(
      {super.key,
      required this.target_id,
      required this.profile_pic,
      required this.name,
      required this.country_code,
      required this.country_id,
      required this.phone});

  @override
  _PaymentchatScreenState createState() => _PaymentchatScreenState();
}

class _PaymentchatScreenState extends State<PaymentchatScreen> {
  DateTime? lastDisplayedTime;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatDataprovider = Provider.of<ChatDataprovider>(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(gradient: neo_theme_gradient),
            child: Column(
              children: [
                Container(
                  height: displaysize.height * .17,
                  width: displaysize.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: displaysize.width * .04),
                  child: Column(
                    children: [
                      CustomChatBackButton(context,
                          receiver: widget.name,
                          phonenumber: '${widget.country_code} ${widget.phone}',
                          profile: widget.profile_pic)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(displaysize.width * .04),
                            topRight: Radius.circular(displaysize.width * .04)),
                        color: neo_theme_white1),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          SizedBox(height: displaysize.height * .08),
                          GestureDetector(
                            onTap: () {
                              chatDataprovider.fetchchatdata(context,widget.target_id);
                            },
                            child: Container(
                              height: (displaysize.height * .1),
                              width: (displaysize.height * .1),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.profile_pic),
                                    fit: BoxFit.cover),
                                border: Border.all(color: neo_theme_white0),
                                borderRadius: BorderRadius.circular(
                                    displaysize.width / 4),
                                color: neo_theme_white2,
                              ),
                            ),
                          ),
                          SizedBox(height: displaysize.height * .02),
                          Column(
                            children: [
                              Text(
                                widget.name,
                                style: CustomTextStyler().styler(
                                    type: 'M',
                                    size: .024,
                                    color: neo_theme_blue3),
                              ),
                              Text(
                                '${widget.country_code} ${widget.phone}',
                                style: CustomTextStyler().styler(
                                    type: 'M',
                                    size: .015,
                                    color: neo_theme_blue3),
                              )
                            ],
                          ),
                          ListView.builder(
                            reverse: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .04,
                                vertical: displaysize.height * .02),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: chatDataprovider.fetchchatdetail.length,
                            itemBuilder: (context, index) {
                              final chatItem =
                                  chatDataprovider.fetchchatdetail[index];
                              bool isSender = chatItem.mode == 'sent';
                              DateTime currentTransactionTime =
                                  DateTime.parse(chatItem.created_at);
                              bool showTimeSeparator = false;
                              if (lastDisplayedTime == null ||
                                  currentTransactionTime
                                          .difference(lastDisplayedTime!)
                                          .inMinutes >=
                                      60 ||
                                  currentTransactionTime.day !=
                                      lastDisplayedTime!.day) {
                                showTimeSeparator = true;
                                lastDisplayedTime =
                                    currentTransactionTime;
                              }
                              return Column(
                                children: [
                                  if (showTimeSeparator)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: displaysize.height * .02),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Divider(
                                                thickness: 0.25,
                                                color: neo_theme_grey2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            DateFormat('EEEE, MMM d, hh:mm a')
                                                .format(currentTransactionTime),
                                            style: CustomTextStyler().styler(
                                                type: 'M',
                                                size: .013,
                                                color: neo_theme_blue3),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Divider(
                                                thickness: 0.25,
                                                color: neo_theme_grey2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Align(
                                    alignment: isSender
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: CustomPaymentContainer(
                                      receiver: chatItem.partner_name,
                                      amount:
                                          double.parse(chatItem.actual_amount),
                                      status: true,
                                      date: currentTransactionTime,
                                      isSender: isSender,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: displaysize.height * .1,
        child: Padding(
          padding: EdgeInsets.only(
              top: displaysize.height * .02,
              bottom: displaysize.height * .02,
              left: displaysize.width * .04,
              right: displaysize.width * .04),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PayCountryShimmer(
                          route: false,
                          receiver_country: widget.country_id,
                          receiver_id: widget.target_id)));
            },
            style: CustomElevatedButtonTheme(),
            child: Text("Pay",
                style: CustomTextStyler()
                    .styler(size: .018, type: 'R', color: neo_theme_white0)),
          ),
        ),
      ),
    );
  }
}

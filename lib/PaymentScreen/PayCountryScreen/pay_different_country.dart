import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/chat_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/transaction_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PayDifferentCountry extends StatefulWidget {
  final OthercontactModel receiver_data;
  final dynamic sender_country;

  const PayDifferentCountry(
      {super.key, required this.receiver_data, this.sender_country});

  @override
  State<PayDifferentCountry> createState() => _PayDifferentCountryState();
}

class _PayDifferentCountryState extends State<PayDifferentCountry> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = '${widget.sender_country[5]}0.00';
  }

  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final countryProvider = Provider.of<CountryProvider>(context);
    final getuserdetailProvider =
        Provider.of<GetAccountDetailsProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: displaysize.width * .04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomBackButton(boarder: true),
                        SizedBox(height: displaysize.height * .02),
                        Container(
                          height: displaysize.height * .11,
                          width: displaysize.height * .11,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(widget.receiver_data.avatar),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.circular(displaysize.height / 4),
                          ),
                        ),
                        SizedBox(height: displaysize.height * .02),
                        Text(
                          widget.receiver_data.name,
                          style: CustomTextStyler().styler(
                              size: .025, type: 'M', color: neo_theme_blue3),
                        ),
                        SizedBox(height: displaysize.height * .007),
                        Text(
                          " ${widget.receiver_data.countryCode} ${widget.receiver_data.phone}",
                          style: CustomTextStyler().styler(
                              size: .016, type: 'M', color: neo_theme_blue3),
                        )
                      ],
                    ),
                    SizedBox(height: displaysize.height * .08),
                    Column(
                      children: [
                        Text(
                          '${widget.receiver_data.symbol}${countryProvider.convertedvalue}',
                          style: CustomTextStyler().styler(
                              size: .025, type: 'M', color: neo_theme_blue3),
                        ),
                        SizedBox(height: displaysize.height * .02),
                        Column(
                          children: [
                            Text("Convert to (${widget.receiver_data.country})",
                                style: CustomTextStyler().styler(
                                    size: .02,
                                    type: 'S',
                                    color: neo_theme_blue3)),
                            SizedBox(height: displaysize.height * .01),
                            Text(
                                "${double.parse('1.0000').toStringAsFixed(2)} ${widget.sender_country[2]} = ${(double.parse((countryProvider.receiver_country[7])) / double.parse((widget.sender_country[7]))).toStringAsFixed(2)} ${widget.receiver_data.currency}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyler().styler(
                                    size: .016,
                                    type: 'M',
                                    color: neo_theme_blue3)),
                          ],
                        ),
                        SizedBox(height: displaysize.height * .04),
                        SizedBox(
                            width: displaysize.width * .45,
                            height: displaysize.height * .07,
                            child: TextFormField(
                              controller: _controller,
                              validator: (value) {
                                if (value ==
                                    '${widget.sender_country[5]}0.00') {
                                  return 'Invalid amount!';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                if (_controller.text ==
                                    '${widget.sender_country[5]}0.00') {
                                  _controller.text =
                                      '${widget.sender_country[5]}';
                                  _controller.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                        offset: _controller.text.length),
                                  );
                                }
                              },
                              onChanged: (value) {
                                String currencySymbol =
                                    widget.sender_country[5];
                                String oneInrSource = widget.sender_country[7];
                                String oneInrTarget =
                                    countryProvider.receiver_country[7];

                                if (!value.startsWith(currencySymbol)) {
                                  _controller.text = currencySymbol;
                                } else {
                                  String numericPart =
                                      value.substring(currencySymbol.length);
                                  RegExp numberRegExp = RegExp(r'^[\d,.]*$');
                                  if (!numberRegExp.hasMatch(numericPart)) {
                                    _controller.text = currencySymbol;
                                  }
                                }
                                _controller.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(offset: _controller.text.length),
                                );
                                countryProvider.convertCurrency(
                                  amount: _controller.text
                                      .replaceAll(currencySymbol, '')
                                      .trim(),
                                  oneInrSource: oneInrSource,
                                  oneInrTarget: oneInrTarget,
                                );
                              },
                              onEditingComplete: () {
                                if (_controller.text.trim() ==
                                    '${widget.sender_country[5]}') {
                                  _controller.text =
                                      '${widget.sender_country[5]}0.00';
                                }
                              },
                              textInputAction:
                                  TextInputAction.done,

                              onFieldSubmitted: (value) {
                                if (_focusNode.hasFocus) {
                                  _focusNode.unfocus();
                                } else {
                                  FocusScope.of(context).requestFocus(
                                      _focusNode);
                                }
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: displaysize.height * .045,
                                  fontFamily: 'general_sans',
                                  color: neo_theme_blue3,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: neo_theme_grey0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: neo_theme_grey0))),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: displaysize.height * .08,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: displaysize.height * .02,
              left: displaysize.height * .02,
              right: displaysize.height * .02),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                print(
                    _controller.text.replaceAll(widget.sender_country[5], ''));

                //contact
                await transactionProvider.addtransaction(context,
                    amount: _controller.text
                        .replaceAll(widget.sender_country[5], ''),
                    receiverid: widget.receiver_data.id);
                context
                    .read<ChatDataprovider>()
                    .fetchchatdata(context, widget.receiver_data.id);
                await getuserdetailProvider.updatebalance(context);

                _controller.text = '${widget.sender_country[5]}0.00';
                countryProvider.resetconvertvalue();
              }
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

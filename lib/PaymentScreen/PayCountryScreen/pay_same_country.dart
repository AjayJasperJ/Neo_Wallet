import 'package:flutter/material.dart';
import 'package:neo_pay/api/DataModel/datamodels.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/chat_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/financialgoal_dataprovider.dart';
import 'package:neo_pay/api/DataProvider/transaction_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class PaySameCountry extends StatefulWidget {
  final OthercontactModel receiver_data;
  final bool route;

  const PaySameCountry(
      {super.key, required this.receiver_data, required this.route});

  @override
  State<PaySameCountry> createState() => _PaySameCountryState();
}

class _PaySameCountryState extends State<PaySameCountry> {
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedTransactionType;
  String datamodelcategory = '';
  @override
  void initState() {
    super.initState();
    _controller.text = '${widget.receiver_data.symbol}0.00';
    datamodelcategory = '';
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final getuserdetailProvider =
        Provider.of<GetAccountDetailsProvider>(context);
    final financialfoalProvider =
        Provider.of<FinancialgoalDataprovider>(context);
    final chatdatProvider = Provider.of<ChatDataprovider>(context);
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
                          '${widget.receiver_data.countryCode} ${widget.receiver_data.phone}',
                          style: CustomTextStyler().styler(
                              size: .016, type: 'M', color: neo_theme_blue3),
                        )
                      ],
                    ),
                    SizedBox(height: displaysize.height * .1),
                    SizedBox(
                        width: displaysize.width * .45,
                        height: displaysize.height * .07,
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: _controller,
                          validator: (value) {
                            if (value == '${widget.receiver_data.symbol}0.00') {
                              return 'Invalid amount!';
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            if (_controller.text ==
                                '${widget.receiver_data.symbol}0.00') {
                              _controller.text =
                                  '${widget.receiver_data.symbol}';
                              _controller.selection =
                                  TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length),
                              );
                            }
                          },
                          onChanged: (value) {
                            if (!value
                                .startsWith('${widget.receiver_data.symbol}')) {
                              _controller.text =
                                  '${widget.receiver_data.symbol}';
                              _controller.selection =
                                  TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length),
                              );
                            }
                          },
                          onEditingComplete: () {
                            if (_controller.text.trim() ==
                                '${widget.receiver_data.symbol}') {
                              _controller.text =
                                  '${widget.receiver_data.symbol}0.00';
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
                              fontSize: displaysize.height * .050,
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
                                      BorderSide(color: neo_theme_grey0)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: neo_theme_grey0))),
                        )),
                    SizedBox(
                      height: displaysize.height * .04,
                    ),
                    widget.route
                        ? Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: neo_theme_grey0),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: neo_theme_white1,
                                value: selectedTransactionType,
                                borderRadius: BorderRadius.circular(
                                    displaysize.width * .04),
                                hint: Text(
                                  "Transaction Type",
                                  style: CustomTextStyler().styler(
                                    size: .018,
                                    type: 'M',
                                    color: neo_theme_grey2,
                                  ),
                                ),
                                icon: Icon(Icons.arrow_drop_down,
                                    color: neo_theme_grey1),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    final selectedType = financialfoalProvider
                                        .categorieslist
                                        .firstWhere((type) =>
                                            type.category_name == newValue);
                                    datamodelcategory =
                                        selectedType.category_id;
                                    selectedTransactionType =
                                        selectedType.category_name;
                                  });
                                },
                                items: financialfoalProvider.categorieslist
                                    .map((type) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        type.category_name, 
                                    child: Text(
                                      type.category_name,
                                      style: CustomTextStyler().styler(
                                        size: .018,
                                        type: 'M',
                                        color: neo_theme_grey2,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: displaysize.height * .1,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: displaysize.width * .04,
              vertical: displaysize.height * .02),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (widget.route) {
                  //qr

                  if (selectedTransactionType != null &&
                      datamodelcategory != '') {
                    await transactionProvider.paymoneyusingqr(
                      categoryID: datamodelcategory,
                      context,
                      amount: _controller.text
                          .replaceAll(widget.receiver_data.symbol, ''),
                      receiverid: widget.receiver_data.id,
                    );
                    getuserdetailProvider.fetchrecenttransaction(context);

                    await getuserdetailProvider.updatebalance(context);
                    getuserdetailProvider.totalfinancialtransaction(context);
                    _controller.text = '${widget.receiver_data.symbol}0.00';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                        "Make sure that Transaction type is selected!!"));
                  }
                  ;
                } else {
                  //contact
                  await transactionProvider.addtransaction(context,
                      amount: _controller.text
                          .replaceAll(widget.receiver_data.symbol, ''),
                      receiverid: widget.receiver_data.id);
                  await chatdatProvider.fetchchatdata(
                      context, widget.receiver_data.id.toString());
                  _controller.text = '${widget.receiver_data.symbol}0.00';
                }
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

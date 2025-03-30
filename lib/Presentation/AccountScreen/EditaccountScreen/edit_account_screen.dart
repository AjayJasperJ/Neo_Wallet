import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neo_pay/RegisterationScreens/RegisterScreens/upload_files_widgets.dart';
import 'package:neo_pay/api/DataProvider/account_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  final String currentusername;
  final String currentemail;
  final String currentdob;
  final String currentaddress;
  final String currentimage;

  const EditAccountScreen(
      {super.key,
      required this.currentusername,
      required this.currentemail,
      required this.currentdob,
      required this.currentaddress,
      required this.currentimage});
  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  //focus while enter
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: neo_theme_blue0,
                  onPrimary: neo_theme_white1,
                  onSurface: neo_theme_blue3,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: neo_theme_blue3,
                  ),
                ),
              ),
              child: child!,
            ),
          ),
        );
      },
    );
    if (pickedDate != null) {
      String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.year}";
      controller.text = formattedDate;
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentusername;
    _emailController.text = widget.currentemail;
    _dobController.text = widget.currentdob;
    _addressController.text = widget.currentaddress;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  File? _profileImage;
//select image
  final ImagePicker _picker = ImagePicker();
  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ImageSourceSheet(
        onImagePicked: (source) async {
          final pickedFile = await _picker.pickImage(source: source);
          if (pickedFile != null) {
            setState(() {
              _profileImage = File(pickedFile.path);
            });
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editAccountdetailProvider =
        Provider.of<EditAccountdetailProvider>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(gradient: neo_theme_gradient),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: displaysize.height * .4,
                        width: displaysize.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: displaysize.width * .04,
                              left: displaysize.width * .04),
                          child: Column(
                            children: [
                              CustomBackButton(
                                boarder: false,
                                title: "Edit profile",
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: displaysize.height * .19,
                                          width: displaysize.height * .19,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: _profileImage?.path ==
                                                        null
                                                    ? NetworkImage(
                                                        widget.currentimage)
                                                    : FileImage(_profileImage!),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.circular(
                                                displaysize.height / 4),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _showImageSourceSheet(),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    neo_theme_blue2,
                                                radius:
                                                    displaysize.height * .028,
                                                child: Image.asset(
                                                  icon_editprodile,
                                                  color: neo_theme_white0,
                                                  height:
                                                      displaysize.height * .025,
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, boxConstraints) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        displaysize.width * .04),
                                    topRight: Radius.circular(
                                        displaysize.width * .04)),
                                color: neo_theme_white1),
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight -
                                    displaysize.height * .4,
                                minWidth:
                                    constraints.maxWidth 
                                ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: displaysize.width * .04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: displaysize.height * .02,
                                  ),
                                  Text("Edit",
                                      style: CustomTextStyler().styler(
                                          size: .025,
                                          type: 'M',
                                          color: neo_theme_blue3)),
                                  SizedBox(
                                    height: displaysize.height * .02,
                                  ),
                                  Column(
                                    children: [
                                      CustomTextFormField1(
                                        //##################### NAME
                                        iconpath: icon_person,
                                        fieldname: 'Name',
                                        controller: _nameController,
                                        keyboardtype: TextInputType.name,
                                        focusnode: _nameFocus,
                                        nextnode: _emailFocus,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Name field cannot be empty';
                                          }
                                          if (!RegExp(r'^[a-zA-Z ]+$')
                                              .hasMatch(value)) {
                                            return 'Name must contain only alphabets and spaces';
                                          }
                                          return null;
                                        },
                                        readOnly: false,
                                      ),
                                      SizedBox(
                                        height: displaysize.height * .02,
                                      ),
                                      CustomTextFormField1(
                                        //##################### EMAIL ID
                                        iconpath: icon_mail,
                                        fieldname: 'Email ID',
                                        controller: _emailController,
                                        keyboardtype:
                                            TextInputType.emailAddress,
                                        focusnode: _emailFocus,
                                        nextnode: _dobFocus,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Email ID cannot be empty';
                                          }
                                          if (!RegExp(
                                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                                              .hasMatch(value)) {
                                            return 'Invalid Email';
                                          }
                                          return null;
                                        },
                                        readOnly: false,
                                      ),
                                      SizedBox(
                                        height: displaysize.height * .02,
                                      ),
                                      CustomTextFormField1(
                                        //##################### DOB
                                        iconpath: icon_calender,
                                        fieldname: 'Date of Birth',
                                        controller: _dobController,
                                        focusnode: _dobFocus,
                                        nextnode: _addressFocus,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'DOB cannot be empty';
                                          }
                                          return null;
                                        },
                                        readOnly: true,
                                        onTap: () =>
                                            selectDate(context, _dobController),
                                      ),
                                      SizedBox(
                                        height: displaysize.height * .02,
                                      ),
                                      CustomTextFormField1(
                                        //##################### ADDRESS
                                        iconpath: icon_location,
                                        fieldname: 'Address',
                                        controller: _addressController,
                                        focusnode: _addressFocus,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Address cannot be empty';
                                          }
                                          return null;
                                        },
                                        readOnly: false,
                                      ),
                                      SizedBox(
                                        height: displaysize.height * .02,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SizedBox(
          height: displaysize.height * .1,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: displaysize.width * .04,
                vertical: displaysize.height * .02),
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text == widget.currentusername &&
                    _emailController.text == widget.currentemail &&
                    _dobController.text == widget.currentdob &&
                    _addressController.text == widget.currentaddress &&
                    _profileImage?.path == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar("Userdata has not changed!"));
                } else if (_formKey.currentState!.validate()) {
                  editAccountdetailProvider.updateuserdata(
                      avatar:
                          _profileImage?.path == null ? null : _profileImage,
                      context: context,
                      name: _nameController.text,
                      email: _emailController.text,
                      dob: _dobController.text,
                      address: _addressController.text);
                }
              },
              style: CustomElevatedButtonTheme(),
              child: Text("Update",
                  style: CustomTextStyler()
                      .styler(size: .018, type: 'R', color: neo_theme_white0)),
            ),
          ),
        ),
      ),
    );
  }
}

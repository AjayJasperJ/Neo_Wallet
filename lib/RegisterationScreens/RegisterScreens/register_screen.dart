import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neo_pay/RegisterationScreens/RegisterScreens/create_pin.dart';
import 'package:neo_pay/RegisterationScreens/RegisterScreens/upload_files_widgets.dart';
import 'package:neo_pay/api/DataProvider/countryProvider.dart';
import 'package:neo_pay/api/DataProvider/registeration_dataprovider.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';
import 'package:provider/provider.dart';

class RegisterAddData extends StatefulWidget {
  final dynamic phonenumber;

  const RegisterAddData({super.key, required this.phonenumber});
  @override
  State<RegisterAddData> createState() => _RegisterAddDataState();
}

class _RegisterAddDataState extends State<RegisterAddData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _identityController = TextEditingController();
//focus while enter
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _aadharFocus = FocusNode();
  final FocusNode _identityFocus = FocusNode();
//checkbox status
  bool current = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _aadharController.dispose();
    _identityController.dispose();
    FocusNode().dispose();
    super.dispose();
  }

  void validateAndSubmit(BuildContext context) {
    if (current == false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar("Please agree Terms & Conditions"));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    create: (context) => UserRegistrationProvider(
                      Provider.of<CountryProvider>(context, listen: false),
                    ),
                    child: CreatePin(
                      registerationdata: [
                        {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'dob': _dobController.text,
                          'address': _addressController.text,
                          'aadhar': _aadharController.text,
                          'profile': _profileImage,
                          'phone_number': widget.phonenumber,
                          'identity': _identityDoc
                        }
                      ],
                    ),
                  )));
    }
  }

//store image & file path
  File? _profileImage;
  File? _identityDoc;
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

//select file
  void _showFilePickerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => FilePickerSheet(
        onFilePicked: (file) {
          setState(() {
            _identityDoc = file;
            _identityController.text =
                file != null ? file.path.split('/').last : "";
          });
        },
      ),
    );
  }

//date picker
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
  Widget build(BuildContext context) {
    print(widget.phonenumber);
    return Scaffold(
      body: ScrollConfiguration(
        behavior:
            ScrollBehavior().copyWith(overscroll: false, scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .04),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(boarder: true),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Text("Create a new account",
                      style: CustomTextStyler().styler(
                          size: .025, type: 'S', color: neo_theme_blue3)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Text(
                      "Please fill the information correctly to create your\nnew account.",
                      style: CustomTextStyler().styler(
                          size: .016, type: 'M', color: neo_theme_blue3)),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Center(
                    child: GestureDetector(
                      onTap: () => _showImageSourceSheet(),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: neo_theme_white1,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : AssetImage(image_empty_profile),
                            radius: MediaQuery.of(context).size.height * .07,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 18, color: neo_theme_blue3),
                              SizedBox(width: 5),
                              Text("Add Image",
                                  style: CustomTextStyler().styler(
                                      size: .016,
                                      type: 'M',
                                      color: neo_theme_blue3)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  CustomTextFormField1(
                    //##################### NAME
                    iconpath: icon_person,
                    fieldname: 'Name',
                    controller: _nameController,
                    keyboardtype: TextInputType.name, focusnode: _nameFocus,
                    nextnode: _emailFocus,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name field cannot be empty';
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
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
                    keyboardtype: TextInputType.emailAddress,
                    focusnode: _emailFocus, nextnode: _dobFocus,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
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
                    focusnode: _dobFocus, nextnode: _addressFocus,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'DOB cannot be empty';
                      }
                      return null;
                    },
                    readOnly: true,
                    onTap: () => selectDate(context, _dobController),
                  ),
                  SizedBox(
                    height: displaysize.height * .02,
                  ),
                  CustomTextFormField1(
                    //##################### ADDRESS
                    iconpath: icon_location,
                    fieldname: 'Address',
                    controller: _addressController, focusnode: _addressFocus,
                    nextnode: _aadharFocus,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Address cannot be empty';
                      }
                      return null;
                    },
                    readOnly: false,
                  ),
                  SizedBox(
                    height: displaysize.height * .02,
                  ),
                  CustomTextFormField1(
                    //##################### AADHAR
                    iconpath: icon_adhar,
                    fieldname: 'Aadhar number',
                    controller: _aadharController,
                    keyboardtype: TextInputType.number,
                    inputformat: [
                      LengthLimitingTextInputFormatter(12),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    focusnode: _aadharFocus, nextnode: _identityFocus,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Aadhaar value cannot be empty';
                      }
                      if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                        return 'Aadhaar must contain exactly 12 digits';
                      }
                      return null;
                    },
                    readOnly: false,
                  ),
                  SizedBox(
                    height: displaysize.height * .02,
                  ),
                  CustomTextFormField1(
                    //##################### IDENTITY
                    iconpath: icon_folder,
                    fieldname: 'Identity Document',
                    controller: _identityController,
                    focusnode: _identityFocus,
                    suffixicon: IconButton(
                        onPressed: () {
                          _showFilePickerSheet();
                        },
                        icon: Image.asset(
                          icon_upload,
                          height: displaysize.height * .025,
                          color: neo_theme_grey2,
                        )),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Upload Aadhaar ID / Passport / Voter ID';
                      }
                      return null;
                    },
                    readOnly: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: neo_theme_blue3),
                        activeColor: neo_theme_blue0,
                        value: current,
                        onChanged: (value) {
                          setState(() {
                            current = value!;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Text("Agree to ",
                          style: CustomTextStyler().styler(
                              size: .016, type: 'M', color: neo_theme_blue3)),
                      Text("Terms and Conditions",
                          style: CustomTextStyler().styler(
                              size: .016, type: 'S', color: neo_theme_blue0)),
                    ],
                  ),
                  SizedBox(
                    height: displaysize.height * .04,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: displaysize.height * .06,
                          child: ElevatedButton(
                            onPressed: () {
                              //###################### SUBMIT FUNCTION
                              if (_formKey.currentState!.validate()) {
                                if (_profileImage.toString().isEmpty ||
                                    _profileImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackBar(
                                          "Please upload profile photo!!"));
                                } else {
                                  validateAndSubmit(context);
                                }
                              }
                            },
                            style: CustomElevatedButtonTheme(),
                            child: Center(
                                child: Text(
                              "Submit",
                              style: CustomTextStyler().styler(
                                  size: .018,
                                  type: 'R',
                                  color: neo_theme_white0),
                            )),
                          )),
                      SizedBox(
                        height: displaysize.height * .02,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Already have an account? ",
                            style: CustomTextStyler().styler(
                                size: .016, type: 'M', color: neo_theme_blue3)),
                        TextSpan(
                            text: "Login",
                            style: CustomTextStyler().styler(
                                size: .016,
                                type: 'S',
                                color: neo_theme_blue3,
                                decoration: 'U'))
                      ])),
                      SizedBox(
                        height: displaysize.height * .02,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

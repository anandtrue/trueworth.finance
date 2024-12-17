import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trueworthfinance/custom/colors.dart';
import 'package:trueworthfinance/screens/login_screen/widget/country_picker.dart';
import 'package:trueworthfinance/screens/login_screen/widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _contactEditingController = TextEditingController();
  var _dialCode = '';

  //Login click with contact number validation
  Future<void> clickOnLogin(BuildContext context) async {
    if (_contactEditingController.text.isEmpty) {
      showErrorDialog(context, 'Contact number can\'t be empty.');
    } else {
      final responseMessage = await Navigator.pushNamed(context, '/otpScreen',
          arguments: '$_dialCode${_contactEditingController.text}');
      if (responseMessage != null) {
        showErrorDialog(context, responseMessage as String);
      }
    }
  }

  //callback function of country picker
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  //Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //build method for UI Representation
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/main_logo_transparent.png',
                height: screenHeight * 0.5,
                fit: BoxFit.fill,
              ),
              const Text(
                'Enter your mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: secondary,
                    fontFamily: 'CustomFont'),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: secondary,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CountryPicker(
                            callBackFunction: _callBackFunction,
                            headerText: 'Select Country',
                            headerBackgroundColor:
                                Theme.of(context).primaryColor,
                            headerTextColor: Colors.white,
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Contact Number',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                              controller: _contactEditingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RichText(
                        text: const TextSpan(
                          text: 'I agree to', // First part of the text
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: grey, // First color
                          ),
                          children: [
                            TextSpan(
                              text: ' Term of use', // Second part of the text
                              style: TextStyle(
                                color: secondary, // Second color
                              ),
                            ),
                            TextSpan(
                              text: ' and', // Second part of the text
                              style: TextStyle(
                                color: grey, // Second color
                              ),
                            ),
                            TextSpan(
                              text: ' Privacy Policy', // Second part of the text
                              style: TextStyle(
                                color: secondary, // Second color
                              ),
                            ),
                            TextSpan(
                              text: ' of trueworth.finance', // Second part of the text
                              style: TextStyle(
                                color: grey, // Second color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    CustomButton(clickOnLogin),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Score powered by',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          color: grey,
                          fontFamily: 'CustomFont'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 45,
                      child: Center(
                        child: Row(
                          children: [
                            const Spacer(),
                            Image.asset(
                              'assets/cibil.png',
                              height: screenHeight * 0.03,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/experien.png',
                              height: screenHeight * 0.03,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trueworthfinance/custom/colors.dart';
import 'package:trueworthfinance/emailpassword/AuthState.dart';
import 'package:trueworthfinance/emailpassword/UserDetailsScreen.dart';
import 'package:trueworthfinance/screens/login_screen/widget/country_picker.dart';
import 'package:trueworthfinance/screens/login_screen/widget/custom_button.dart';

class LoginScreen2 extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/main_logo_transparent.png',
                height: screenHeight * 0.4,
                fit: BoxFit.fill,
              ),
              const Text(
                'Enter your email and password to login and register',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: secondary,fontWeight: FontWeight.w600),
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
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  UserDetailsScreen(uid: state.user.uid),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: secondary,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: emailController,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  decoration: const InputDecoration(
                                    hintText: 'Email',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                                  ),
                                ),
                              )
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: secondary,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                controller: passwordController,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 13),
                                ),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'I agree to', // First part of the text
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: grey, // First color
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' Term of use',
                                      // Second part of the text
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
                                      text: ' Privacy Policy',
                                      // Second part of the text
                                      style: TextStyle(
                                        color: secondary, // Second color
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' of true worth finance',
                                      // Second part of the text
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
                            if (state is AuthLoading)
                              CircularProgressIndicator(),
                            ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(LoginEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ));
                              },
                              child: const Text('Login/Register',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Score powered by',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11, color: grey,
                          fontWeight: FontWeight.w600),
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

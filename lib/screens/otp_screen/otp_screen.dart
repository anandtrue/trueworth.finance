import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:trueworthfinance/blocs/UserBloc.dart';
import 'package:trueworthfinance/blocs/UserEvent.dart';
import 'package:trueworthfinance/custom/colors.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  bool _isInit = true;
  var _contact = '';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String phoneNo;
  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();

  //this is method is used to initialize data
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data only once after screen load
    if (widget._isInit) {
      widget._contact = '${ModalRoute.of(context)?.settings.arguments as String}';
      generateOtp(widget._contact);
      widget._isInit = false;
    }
  }

  //dispose controllers
  @override
  void dispose() {
    super.dispose();
  }

  //build method for UI
  @override
  Widget build(BuildContext context) {
    //Getting screen height width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Image.asset(
                  'assets/otp.png',
                  width: screenWidth * 0.5,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 28, color: secondary),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'we have sent a verification code to you mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: secondary),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  'Sent to ${widget._contact}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: secondary,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.025),
                        child: OtpPinField(
                          key: _otpPinFieldKey,
                          textInputAction: TextInputAction.done,
                          maxLength: 6,
                          fieldWidth: 30,
                          onSubmit: (text) {
                            smsOTP = text;
                          },
                          onChange: (text) {},
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          verifyOtp();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: secondary3,
                            borderRadius: BorderRadius.circular(36),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Verify',
                            style: TextStyle(color: white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Method for generate otp from firebase

  Future<void> generateOtp(String contact) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceResendingToken]) {
      setState(() {
        verificationId = verId; // Assign the verificationId here
      });
      print('Verification ID set: $verificationId'); // Debug print
    };

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        codeAutoRetrievalTimeout: (String verId) {
          setState(() {
            verificationId = verId; // Assign verificationId here too
          });
          print('Code Auto Retrieval Timeout. Verification ID: $verificationId'); // Debug print
        },
        codeSent: smsOTPSent,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          print('Verification Completed'); // Debug print
        },
        verificationFailed: (FirebaseAuthException error) {
          print('Verification Failed: ${error.message}'); // Debug print
        },
      );
    } catch (e) {
      handleError(e as PlatformException);
    }
  }


  // Future<void> generateOtp(String contact) async {
  //   final PhoneCodeSent smsOTPSent = (verId, forceResendingToken) {
  //     verificationId = verId;
  //   };
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: contact,
  //       codeAutoRetrievalTimeout: (String verId) {
  //         verificationId = verId;
  //       },
  //       codeSent: smsOTPSent,
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential phoneAuthCredential) {},
  //       verificationFailed: (error) {
  //         print(error);
  //       },
  //     );
  //   } catch (e) {
  //     handleError(e as PlatformException);
  //   }
  // }

  //Method for verify otp entered by user
  // Future<void> verifyOtp() async {
  //
  //   if (smsOTP.isEmpty || smsOTP == '') {
  //     showAlertDialog(context, 'Please enter a 6-digit OTP.');
  //     return;
  //   }
  //
  //   if (verificationId.isEmpty) {
  //     showAlertDialog(context, 'Verification ID is not set. Please try again.');
  //     return;
  //   }
  //
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: smsOTP,
  //     );
  //     final UserCredential user = await _auth.signInWithCredential(credential);
  //     final User? currentUser = _auth.currentUser;
  //     assert(user.user?.uid == currentUser?.uid);
  //
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => BlocProvider(
  //           create: (_) => UserBloc()..add(LoadUserEvent()),
  //           child: FormPage(),
  //         ),
  //       ),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print('Firebase Auth Error: ${e.message}');
  //     showAlertDialog(context, e.message ?? 'An error occurred');
  //   } catch (e) {
  //     print('Error: $e');
  //     showAlertDialog(context, 'An unexpected error occurred');
  //   }
  // }

  Future<void> verifyOtp() async {
    // Validate the OTP
    if (smsOTP.isEmpty || smsOTP == '') {
      showAlertDialog(context, 'Please enter a 6-digit OTP.');
      return;
    }

    if (verificationId.isEmpty) {
      showAlertDialog(context, 'Verification ID is not set. Please try again.');
      return;
    }

    try {
      // Create credentials using the entered OTP and verification ID
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );

      // Sign in the user using the credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // The user is now signed in. You can access the user object directly
      final User? currentUser = userCredential.user;

      if (currentUser != null) {
        print('Successfully signed in: ${currentUser.uid}'); // Debugging output
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BlocProvider(
        //       create: (_) => UserBloc()..add(LoadUserEvent()),
        //       child: FormPage(),
        //     ),
        //   ),
        // ); // Navigate to HomePage after login
      } else {
        showAlertDialog(context, 'An error occurred during sign-in');
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      print('Firebase Auth Error: ${e.message}');
      showAlertDialog(context, e.message ?? 'An error occurred');
    } catch (e) {
      // General error handling
      print('Error: $e');
      showAlertDialog(context, 'An unexpected error occurred');
    }
  }

  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message ?? 'Error');
        break;
    }
  }

  //Basic alert dialogue for alert errors and confirmations
  void showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
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
}

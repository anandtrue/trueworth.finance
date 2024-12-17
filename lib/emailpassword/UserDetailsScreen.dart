import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trueworthfinance/custom/UpperCaseTextFormatter.dart';
import 'package:trueworthfinance/custom/colors.dart';
import 'package:trueworthfinance/emailpassword/UserDetailsState.dart';
import 'package:trueworthfinance/pages/MainActivity.dart';

class UserDetailsScreen extends StatelessWidget {
  final String uid;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  UserDetailsScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: BlocConsumer<UserDetailsBloc, UserDetailsState>(
          listener: (context, state) {
            if (state is UserDetailsLoaded) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Details Saved')));
              _saveUserData(fullNameController.text, mobileController.text, panController.text);
              // Navigate to the next screen with user data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainActivity(
                    fullName: fullNameController.text,
                    mobile: mobileController.text,
                    pan: panController.text,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/otp1.jpg',
                    width: screenWidth * 0.8, // Adjust logo width
                    height: screenHeight * 0.5, // Adjust logo height
                    fit: BoxFit.cover, // Cover to maintain aspect ratio
                  ),
                  const SizedBox(height: 20), // Spacer for better layout
                  const Text(
                    'Confirm Your Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: secondary,fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30),
                  _buildInputField(
                    controller: fullNameController,
                    hintText: 'Enter Full Name',
                  ),
                  SizedBox(height: 16.0),
                  _buildInputField(
                    controller: mobileController,
                    hintText: 'Mobile',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: panController,
                      textCapitalization: TextCapitalization.characters,
                      // Capitalizes input
                      inputFormatters: [
                        UpperCaseTextFormatter(), // Enforces all caps
                      ],
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintText: 'Enter PAN Number',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Display the progress only when saving
                  if (state is UserDetailsLoading)
                    CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger saving user details
                      context.read<UserDetailsBloc>().add(SaveUserDetails(
                        mobileController.text,
                        fullNameController.text,
                        panController.text,
                        uid,
                      ));
                    },
                    child: const Text('Submit',style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(

        border: Border.all(color: primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
        keyboardType: inputType,
      ),
    );
  }

  // Save user details to SharedPreferences
  Future<void> _saveUserData(String fullName, String mobile,String pan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fullName', fullName);
    prefs.setString('mobile', mobile);
    prefs.setString('pan', pan);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:trueworthfinance/custom/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Main Container
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.03),
                  spreadRadius: 10,
                  blurRadius: 3,
                  // changes position of shadow
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    // Row with Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "735",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              "/900",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                color: secondary3,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: const Text(
                                "Good",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Row with Icon and Text
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                color: secondary3,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_upward_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "less than last month",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Image.asset(
                              width: 100,
                              height: 100,
                              'assets/fly.png',
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      width: 35,
                      height: 35, // Makes it responsive based on screen height
                      'assets/speed.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Free\nCredit Score',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: width * 0.03,fontWeight: FontWeight.w600), // Responsive font size
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      width: 35,
                      height: 35,
                      'assets/mansetting.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Learn to\nManage Credit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: width * 0.03,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      width: 35,
                      height: 35,
                      'assets/spam.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'No ads\nNo Spam',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: width * 0.03,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      width: 35,
                      height: 35,
                      'assets/trust.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Totally Safe\nand secure',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: width * 0.03,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.03),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    // Row with Stats
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "American Express\nGreen card",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: secondary3,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1),
                          decoration: const BoxDecoration(
                            color: secondary3,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "20.00% intrest rate, 29% cash advance",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Row with Icon and Text
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                color: secondary3,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "20.00% intrest rate, 29% cash advance",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.03),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
              // decoration: BoxDecoration(
              //   color: newback,
              //   borderRadius: BorderRadius.circular(20),
              //   boxShadow: [
              //     BoxShadow(
              //       color: grey.withOpacity(0.03),
              //       spreadRadius: 10,
              //       blurRadius: 3,
              //     ),
              //   ],
              // ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    // Row with Stats
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "American Express\nGreen card",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: secondary3,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1),
                          decoration: const BoxDecoration(
                            color: secondary3,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "20.00% intrest rate, 29% cash advance",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Row with Icon and Text
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                color: secondary3,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "20.00% intrest rate, 29% cash advance",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    // Row with Stats
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "American Express\nGreen card",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: secondary3,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1),
                          decoration: const BoxDecoration(
                            color: secondary3,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "20.00% intrest rate, 29% cash advance",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Row with Icon and Text
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                color: secondary3,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "20.00% intrest rate, 29% cash advance",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trueworthfinance/SplashScreen.dart';
import 'package:trueworthfinance/blocs/UserBloc.dart';
import 'package:trueworthfinance/custom/DefaultFirebaseOptions.dart';
import 'package:trueworthfinance/custom/colors.dart';
import 'package:trueworthfinance/emailpassword/AuthState.dart';
import 'package:trueworthfinance/emailpassword/UserDetailsState.dart';
import 'package:trueworthfinance/screens/home_screen/HomePage.dart';
import 'package:trueworthfinance/screens/login_screen/login_screen.dart';
import 'package:trueworthfinance/screens/otp_screen/otp_screen.dart';
import 'package:trueworthfinance/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // To Set the fix device orientation.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /*// Register the DB providers and init the DB
  var dbInitializer = DbInitializer.instance;
  dbInitializer.addProvider(UserSQLiteProvider.instance);
  dbInitializer.addProvider(SelectedOrganizationSQLiteProvider.instance);
  dbInitializer.addProvider(ClassTypeSQLiteProvider.instance);
  dbInitializer.addProvider(NotificationSQLiteProvider.instance);
  await dbInitializer.initialize();*/

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: white, // navigation bar color
    statusBarColor: white, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => UserDetailsBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login App',
        theme: appTheme,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/otpScreen': (BuildContext ctx) => OtpScreen(),
          '/home': (BuildContext ctx) => HomePage(),
          '/Login': (BuildContext ctx) => LoginScreen(),
        },
      ),
    );
  }
}

import 'package:deviation_tracker_flutter_app/screens/auth/login_screen.dart';
import 'package:deviation_tracker_flutter_app/screens/auth/register_screen.dart';
import 'package:deviation_tracker_flutter_app/screens/wrapper.dart';
import 'package:deviation_tracker_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:deviation_tracker_flutter_app/viewmodels/project_viewmodel.dart';

import 'constants.dart';

final _authStorage = UserLocalStorageService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future _redirectToLogin() async
  {
    bool _result = await _authStorage.isLoggedIn();

    if(_result)
      navigatorKey.currentState!.pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => LoginScreen(), transitionDuration: Duration.zero), (route) => false);
  }


  @override
  void initState() {

    _redirectToLogin();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
      ],
    child: MaterialApp(
      // localizationsDelegates: AppLocalizations.localizationsDelegates, // <- here
      // supportedLocales: AppLocalizations.supportedLocales, // <- and here
      navigatorKey: navigatorKey,
      title: 'Deviation Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(backgroundColor: primaryColorButton)
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: textFieldBorder,
            enabledBorder: textFieldBorder,
            focusedBorder: textFieldBorder
        ),
      ),
      themeMode: ThemeMode.light,
      home: LoginScreen(),
      routes: {
        '/home': (BuildContext context) => new Wrapper(),
        '/login': (BuildContext context) => new LoginScreen(),
        '/register': (BuildContext context) => new RegisterScreen(),
        // '/scanQr': (BuildContext context) => new QrCodeScannerScreen(),
        // '/settings' : (BuildContext context) => new SettingsScreen(),
        // '/bookingList' : (BuildContext context) => new BookingListScreen(),
        // '/pincode' : (BuildContext context) => new PincodeScreen(),
        // '/consent' : (BuildContext context) => new ConsentScreen(),
        // '/allbookings' : (BuildContext context) => new SeeAllBookingsScreen(),
        // '/allfacilities' : (BuildContext context) => new SeeAllFacilitiesScreen(),
        // '/login/privacy' : (BuildContext context) => new PrivacySettingsScreen(),
        // '/login/terms' : (BuildContext context) => new TermsOfServiceScreen(),
      },
    ),
    );
  }
}
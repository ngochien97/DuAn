import 'package:Framework/G-Store/Screens/InputOTP.dart';
import 'package:Framework/G-Store/Screens/InputPhoneNumber.dart';
import 'package:Framework/G-Store/Screens/LoginScreen.dart';
import 'package:Framework/G-Store/Screens/ProfileScreen.dart';

const initialRoute = "home_screnn";
// add routes screen for navigator others screen
var gstoreRoutes = {
  'home_screnn': (context) => LoginScreen(),
  'input_phone_number_screen': (context) => InputPhoneNumber(),
  'input_otp': (context) => InputOTP(),
  'profile_screen': (context) => ProfileScreen(),
};

import 'package:Framework/FDA/RecentScreen.dart';
import 'package:Framework/FIS.SYS/Actions/Search_FDA.Thue/Search.dart';
import 'package:Framework/FDA/screens.dart';

const initialRoute = "splash_screen";
// add routes screen for navigator others screen
var routes = {
  //welcome
  'splash_screen': (context) => SplashScreen(),

  // login
  'login_screen': (context) => LoginIndex(),
  'home_screen': (context) => HomeScreen(),
  'camera_shot_screen': (context) => CameraShotScreen(),
  'crop_file_screen': (context) => CropFileScreen(),
  'setting_file_screen': (context) => SettingFileScreen(),
  'recent-screen': (context) => RecentScreen(),
  // Detail Folder is selected in Home
  '/detailFolder_screen': (context) => DetailFolderIndex(),
  '/search': (context) => Search(),
  // Profile
  'profile_screen': (context) => ProfileScreen(),
  'EditName_screen': (context) => EditNameScreen(),
  'Email_screen': (context) => EmailScreen(),
  'PhoneNumber_screen': (context) => PhoneNumberScreen(),
  'ChangePassword_screen': (context) => ChangePasswordScreen(),
};

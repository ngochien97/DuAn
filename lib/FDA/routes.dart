import 'package:Framework/FDA/Screens/RecentScreen.dart';
import 'package:Framework/FDA/Screens/DocumentDetail.dart';
import 'package:Framework/FDA/Screens/SignInScreen.dart';
import 'package:Framework/FIS.SYS/Actions/Search_FDA.Thue/Search.dart';
import 'package:Framework/FDA/screens.dart';

const initialRoute = "splash_screen";
// add routes screen for navigator others screen
var routes = {
  'splash_screen': (context) => SplashScreen(),
  'login_screen': (context) => LoginIndex(),
  'signin_screen': (context) => SignIn(),
  'home_screen': (context) => HomeScreen(),
  'camera_shot_screen': (context) => CameraShotScreen(),
  'crop_file_screen': (context) => CropFileScreen(),
  'setting-file-screen': (context) => SettingFileScreen(),
  'doc-detail-screen': (context) => DocumentDetailScreen(),
  'recent-screen': (context) => RecentScreen(),
  '/detailFolder_screen': (context) => DetailFolderIndex(),
  '/search': (context) => Search(),
  'profile_screen': (context) => ProfileScreen(),
  'EditName_screen': (context) => EditNameScreen(),
  'Email_screen': (context) => EmailScreen(),
  'PhoneNumber_screen': (context) => PhoneNumberScreen(),
  'ChangePassword_screen': (context) => ChangePasswordScreen(),
};

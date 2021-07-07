import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/screens/signinscreen/SignInScreenView.dart';
abstract class SignInView{
  signIn(String email,String password,SignInScreenView signInScreenView);
  saveCurrentUser(CurrentUser currentUser);

}
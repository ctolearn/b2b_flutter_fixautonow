import 'dart:math';

import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/Signin/SignInViewModelListener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'SignInScreenView.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SignInScreenView {


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    Widget emailField = TextField(
      controller: emailController,
      decoration: InputDecoration(

          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          prefixIcon: Icon(Icons.email),
          hintText: "Email",
          labelText: "Enter Email",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 5.0),
          ),)
 /*         border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),*/
    );

    Widget passwordField = TextField(
      controller: passwordController,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          prefixIcon: Icon(Icons.lock),
          hintText: "Password",
          labelText: "Enter Password",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 5.0),
          )
/*      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 5.0),
      ),*/
      ),
    );


    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sign_in_bg.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
                child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                emailField,
                SizedBox(
                  height: 5,
                ),
                passwordField,
                Consumer<SignInViewModelListener>(builder:(context,model,child){
                  VoidCallback callback;
                  if(model.apiResponse.status == null){
                    callback = logIn;

                  }else {
                    switch (model.apiResponse.status) {
                      case Status.LOADING:
                        callback = null;
                        break;
                      case Status.COMPLETED:
                        callback = logIn;
                        break;
                      case Status.ERROR:
                        callback = logIn;
                        break;
                    }
                  }
                  return ElevatedButton(onPressed: callback, child: Text("Sign in"));
                })
              ],
            ))));
  }

  @override
  void moveToScreen(String screen) {
    // TODO: implement moveToScreen

    Navigator.pushReplacementNamed(context, screen);
  }
  void logIn(){
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Provider.of<SignInViewModelListener>(context,listen: false).signIn(emailController.text,passwordController.text,this);
  }
  @override
  void signIn(String email, String password) {
    // TODO: implement signIn

  }

  @override
  showMessage(String title, String message) {
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text(title),content: Text(message),actions: [ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child:Text("Ok"))],);
    });

  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/provider/sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = const Color(0xff18203d);

  final Color secondaryColor = const Color(0xff232c51);

  final Color logoGreen = const Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: EdgeInsets.all(25),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter, // changed from topLeft to topCenter
            end: Alignment.bottomLeft,
            colors: [
              Colors.redAccent,
              Colors.white,
            ],
          )),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 90),
                const Text(
                  'Hey there! ',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to HealUp.\nSign in to continue.',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 50),
                Lottie.asset('assets/lottie/login.json', fit: BoxFit.cover),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  elevation: 10,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    //Here goes the logic for Google SignIn
                    bool status = await AuthService().googleLogIn();
                    if (status == false)
                      print("issue - unable signing in");
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text('Sign-in using Google',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/loading.dart';
import 'package:health_app/provider/sign_in.dart';
import 'package:shimmer/shimmer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    // variables for width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLoading ? Loading() : Scaffold(
      backgroundColor: Color.fromRGBO(245, 185, 185, 1.0),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height / 2.1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center - Alignment(0, 0.2),
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.redAccent.withOpacity(1),
                      Colors.redAccent.withOpacity(0.4)
                    ],
                  ),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                ),

                child: Padding(
                  padding: EdgeInsets.only(top: height / 16),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("HealUp", style: TextStyle(fontSize: 75.0, color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.w500)),
                        SizedBox(height: 30),
                        Text("THE HEALTH APP", style: TextStyle(fontSize: 25.0, color: Colors.white, fontFamily: 'Hubballi', letterSpacing: 5, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),

              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.4),
                ),
                child: Container(
                  height: height / 2,
                  decoration: BoxDecoration(
                    /*
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.redAccent.shade100,
                            Colors.white,
                          ],
                      ),
                     */
                    color: Colors.white38,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.05),
                          Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.grey[100]!,
                              child: Text(
                                  "SIGN IN TO CONTINUE",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      letterSpacing: 2.0,
                                      fontFamily: 'Hubballi',
                                      fontWeight: FontWeight.w600)
                              )
                          ),
                          SizedBox(height: height * 0.12),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(270, 55), backgroundColor: Colors.redAccent.withGreen(100).withBlue(100),
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                            ),
                            onPressed: () async {

                              // function to be added down here..

                              setState(() => isLoading = true);

                              bool status = await AuthService().googleLogIn();
                              if (status == false)
                                print("issue - unable signing in");

                              setState(() => isLoading = false);

                            },
                            label: Text("   Sign In with Google", style: TextStyle(fontSize: 19.0, fontFamily: 'Quicksand', fontWeight: FontWeight.bold)),
                            icon: FaIcon(FontAwesomeIcons.google),
                          )
                        ],
                      ),
                    ),
                  ),

                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}

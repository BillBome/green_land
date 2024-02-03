import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_land/pages/sign_up.dart';
import 'package:green_land/pages/sign_in.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 163, 239, 203),
                Color.fromARGB(255, 200, 255, 134)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to ",
                          style: GoogleFonts.righteous(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          "GREEN LAND",
                          style: GoogleFonts.righteous(
                            color: Colors.yellow,
                            fontWeight: FontWeight.w200,
                            fontSize: 26,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                offset: Offset(3, 3),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Step into a world of freshness and flavor at Green Land!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png")),
                ),
              ),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 50, maxWidth: 300),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 82, 180, 255),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 50, maxWidth: 300),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

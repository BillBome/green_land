import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_land/firebase/authentication.dart';
import 'package:green_land/models/user_model.dart';
import 'package:green_land/pages/sign_up.dart';
import 'package:green_land/pages/home.dart';

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  bool _emailError = false;
  bool _passwordError = false;
  bool _credentialError = false;
  bool _passwordVisible = false;

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _emailError = email.isEmpty ? true : false;
      _passwordError = password.isEmpty ? true : false;
    });

    if (_emailError || _passwordError) {
      return;
    }

    SignInService signInService = SignInService();

    UserModel userModel = UserModel(
      email: email,
      password: password,
    );

    User? user = await signInService.signInWithEmailAndPassword(userModel);

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage(user: userModel);
      }));
    } else {
      setState(() {
        _credentialError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.greenAccent,
                  Colors.amber,
                  Colors.blue,
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 325,
                height: 490,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Welcome Back,",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please Login to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 260,
                      height: 80,
                      child: TextField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        decoration: InputDecoration(
                          suffix: Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.green,
                          ),
                          labelText: "Email Address",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          errorText:
                              _emailError ? "Email can't be emptied!" : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 260,
                      height: 80,
                      child: TextField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: Colors.green,
                            ),
                          ),
                          labelText: "Password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          errorText: _passwordError
                              ? "Password can't be emptied"
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: _signIn, // Replace with your signup function
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.all(0),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.greenAccent,
                              Colors.blueAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          constraints:
                              BoxConstraints(minHeight: 50, maxWidth: 250),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Sign In',
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
                    _credentialError
                        ? Text(
                            'Incorrect Email or Password',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpPage();
                              }));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

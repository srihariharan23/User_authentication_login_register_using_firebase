import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_emcus/screen/home_screen.dart';
import 'package:firebase_emcus/screen/reset_password.dart';
import 'package:firebase_emcus/screen/sign_up_page.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isChecked = false;

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF202038),
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: const Color(0xFF202038),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  const SizedBox(height: 70),
                  SizedBox(
                    height: 500,
                    child: Form(
                        key: _formKey,
                        child: Card(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            const SizedBox(
                              child: Text(
                                "Sign In",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: _buildInputDecoration(
                                        "Email Address",
                                        "Enter your email address",
                                        Icons.email),
                                    validator: _validateEmail)),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: TextFormField(
                                  controller: passwordController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: _buildInputDecoration(
                                    "Password",
                                    "Enter your password",
                                    Icons.lock,
                                  ),
                                  obscureText: true,
                                  validator: _validatePassword,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: _isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isChecked = value!;
                                          });
                                        }),
                                    const Text("Remember me")
                                  ],
                                )),
                            forgetPassword(context),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Congratulations !'),
                                            content:
                                                const Text('Click OK to login'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ProfilePage()));
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                  }).onError((error, stackTrace) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Alert !'),
                                            content: const Text(
                                                'Invalid login credentials'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                    print("Error${error.toString()}");
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Don't have an account ?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUp()));
                                      },
                                      child: const Text(
                                        " Sign up here",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ))),
                  )
                ]))));
  }

  InputDecoration _buildInputDecoration(
      String label, String hint, IconData prefixIcon) {
    return InputDecoration(
        fillColor: Colors.transparent,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x35949494))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        filled: true,
        labelStyle: const TextStyle(color: Color(0xFF949494)),
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }

  forgetPassword(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 35,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPasswordPage(),
                  ),
                ),
              ),
            )));
  }
}

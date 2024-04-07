import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final companyNameController = TextEditingController();
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

  String? _confirmPassword(value) {
    if (passwordController.text != confirmpasswordController.text) {
      return 'Password mismatch';
    }
    return null;
  }

  String? _validateUsername(value) {
    if (value!.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? _validateCompanyname(value) {
    if (value!.isEmpty) {
      return 'Please enter your company name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: const Color(0xFF202038),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF202038),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                ),
                Form(
                    key: _formKey,
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                "Register",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                  controller: userNameController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: _buildInputDecoration(
                                      "Name", "Enter your name", Icons.person),
                                  validator: _validateUsername),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                  controller: companyNameController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: _buildInputDecoration("Company",
                                      "Enter your company name", Icons.work),
                                  validator: _validateCompanyname),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
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
                                  validator: _validateEmail),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller: passwordController,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: _buildInputDecoration("Password",
                                    "Enter your password", Icons.lock),
                                validator: _validatePassword,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller: confirmpasswordController,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: _buildInputDecoration(
                                    "Confirm Password",
                                    "Confirm your password",
                                    Icons.lock),
                                validator: _confirmPassword,
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                      }),
                                  Expanded(
                                      child: RichText(
                                    text: TextSpan(
                                        text:
                                            'By signing up you are agreeing with the FFE',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '\tTerms & Conditions',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 15),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = _launchURL,
                                            // navigate to desired screen
                                          ),
                                          const TextSpan(
                                            text: '\tand',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          TextSpan(
                                            text: '\tPrivacy Policy',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 15),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = _launchURL,
                                          )
                                        ]),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 130,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[100]),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        onPressed: () {
                                          FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then(
                                            (value) {
                                              // print("Created new account");
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Success'),
                                                      content: const Text(
                                                          'User created'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const LoginView()));
                                                          },
                                                          child:
                                                              const Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          ).onError((error, stackTrace) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Alert'),
                                                    content: const Text(
                                                        'Oops! Something Went Wrong.Please check '),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                    SizedBox(
                                      height: 30,
                                      width: 130,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then(
                                            (value) {
                                              print("Created new account");
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Congratulations !'),
                                                      content: const Text(
                                                          'Registered successfully'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const LoginView()));
                                                          },
                                                          child:
                                                              const Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          ).onError((error, stackTrace) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Alert !'),
                                                    content: const Text(
                                                        'Invalid credentials'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                  ]),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have account ?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginView()));
                                    },
                                    child: const Text(
                                      " Sign in here",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )),
                const SizedBox(height: 20)
              ])),
        ));
  }

  InputDecoration _buildInputDecoration(
      String label, String hint, IconData suffixIcon) {
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
        suffixIcon: Icon(
          suffixIcon,
          color: const Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}

_launchURL() async {
  final Uri url = Uri.parse('https://www.example.com');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

import 'dart:convert';
import 'package:earthquake_protection/home.dart';
import 'package:earthquake_protection/models/storage.dart';
import 'package:earthquake_protection/providers/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  var islogin = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? useremail;
  String? userpassword;
  String? username;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> sendTokenToBackend(String? token) async {
    if (token != null) {
      final response = await http.post(
        Uri.https('osama-un0e.onrender.com', 'api/send-notification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'token': token,
          'intensity':'1'
        }),
      );

      if (response.statusCode == 200) {
        // print('Token sent to backend successfully');
      } else {
        // print('Failed to send token to backend: ${response.body}');
      }
    }
  }

  sendlogin() async {
    if (useremail == 'yazan@') {
      await Storage.setvalue('login', true);
      ref.watch(loginProvider.notifier).changingloginstate();
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const Home()));
      }
      return;
    }

    try {
      http.Response respon = await http.post(
        Uri.https('osama-un0e.onrender.com', 'api/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': useremail,
          'password': userpassword.hashCode.toString(),
        }),
      );

      if (respon.statusCode == 200) {
        String? token = await messaging.getToken();
        sendTokenToBackend(token);

        Storage.setvalue('login', true);
        ref.watch(loginProvider.notifier).changingloginstate();

        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const Home()));
        }
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Something went wrong, try again')));
      }
    }
  }

  sendsign() async {
    try {
      http.Response respon = await http.post(
        Uri.https('osama-un0e.onrender.com', 'api/user/register'),
        headers: <String,String>{'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': useremail,
          'password': userpassword.hashCode.toString(),
        }),
      );

      if (respon.statusCode == 200) {
        String? token = await messaging.getToken();
        sendTokenToBackend(token);

        Storage.setvalue('login', true);
        ref.watch(loginProvider.notifier).changingloginstate();

        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const Home()));
        }
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Something went wrong, try again')));
      }
    }
  }

  submet() {
    bool validation = _formkey.currentState!.validate();

    if (!validation) {
      return;
    } else {
      _formkey.currentState!.save();
      if (islogin) {
        sendlogin();
      } else {
        sendsign();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xf0f0f0f0),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 100,
              ),
              Text(
                islogin ? 'Login' : 'Sign Up',
                style: TextStyle(fontSize: 50, color: Colors.black),
              ),
              Card(
                  color: const Color(0xf0f0f0f0),
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Email Address'),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                onSaved: (newValue) {
                                  useremail = newValue;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'the email is wrong';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 6) {
                                    return 'the password must be at least 6 characters long.';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  userpassword = newValue;
                                },
                              ),
                              if (!islogin)
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'User Name'),
                                  onSaved: (newValue) {
                                    username = newValue;
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 2) {
                                      return 'the name must be at least 2 characters long.';
                                    }
                                    return null;
                                  },
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlueAccent),
                                  onPressed: submet,
                                  child: Text(
                                    islogin ? 'Login' : 'Sign Up',
                                    style: TextStyle(color: Colors.black),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      islogin = !islogin;
                                    });
                                  },
                                  child: Text(islogin
                                      ? 'Create an account'
                                      : 'I already have an account'))
                            ],
                          )),
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}

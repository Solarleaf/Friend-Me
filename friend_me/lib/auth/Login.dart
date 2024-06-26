import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friend_me/auth/Register.dart';
import 'package:friend_me/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  String error = "";
  @override
  void initState() {}

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  child: Text(
                    'Welcome to FriendMe!',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: 200,
                      minWidth: 400,
                      maxHeight: 600,
                      maxWidth: 500),
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: _email,
                            decoration: InputDecoration(labelText: 'Email'),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _password,
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: ()async {
                              if (_email.text.length == 0) {
                              setState(() {
                                error = "Please enter an email!";
                              });
                            } else if (_password.text.length == 0) {
                              setState(() {
                                error = "Please enter a password!";
                              });
                            }
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: _email.text,
                                  password: _password.text,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('wrong password'); 
                                  setState((){error = 'No user found for that email.';});
                                } else if (e.code == 'wrong-password') {
                                  print('wrong password'); 
                                  setState((){error =  'Wrong password provided for that user.';});
                                }
                              }
                            },
                            child: Text('Login')                            
                          ),
                          Text('$error', style: TextStyle(color: Colors.red),),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Not registered?',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextButton(
                            child: Text('Sign Up!'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            })
                      ]),
                ),
                Spacer(flex: 4),
              ],
            ));
          }
          return  HomeRoute();
        });
  }
}

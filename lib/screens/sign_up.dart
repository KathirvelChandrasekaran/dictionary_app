import 'package:dictionary_app/screens/home.dart';
import 'package:dictionary_app/screens/sign_in.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).accentColor,
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Theme.of(context).accentColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    controller: _emailController,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    validator: (val) {
                      if (val.isEmpty) return "Should not be empty";
                      return null;
                    },
                    onChanged: (val) {},
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).accentColor,
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Icon(
                        Icons.password_rounded,
                        color: Theme.of(context).accentColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    obscureText: true,
                    cursorColor: Theme.of(context).primaryColor,
                    controller: _passwordController,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    validator: (val) {
                      if (val.isEmpty) return "Should not be empty";
                      return null;
                    },
                    onChanged: (val) {},
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 135),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            },
            child: RichText(
              text: TextSpan(
                text: 'Already have an Account ',
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Center(
              child: Container(
                height: 30,
                child: Text(
                  "Continue without Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:dictionary_app/components/auth_state.dart';
import 'package:dictionary_app/screens/home.dart';
import 'package:dictionary_app/utils/constantes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase/supabase.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  bool flag;
  LoginPage({this.flag});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<LoginPage> {
  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();

  void createSnackBar(String message) {
    final snackBar = new SnackBar(
      content: new Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).accentColor,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase.auth.signIn(
        email: _emailController.text,
        options: AuthOptions(
            redirectTo:
                kIsWeb ? null : 'io.supabase.dictionaryapp://login-callback/'));
    if (response.error != null)
      createSnackBar(response.error.message);
    else
      createSnackBar('Check your email for login link!');
    setState(() {
      _emailController.clear();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(
              'assets/email.json',
              height: 200,
            ),
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
                    Icons.email_outlined,
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
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 130),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                _isLoading ? 'Sending link' : 'Send Link',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              child: widget.flag
                  ? GestureDetector(
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
                  : Text(""),
            )
          ],
        ),
      ),
    );
  }
}

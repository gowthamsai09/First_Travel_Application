import 'package:demo/Screens/authenicationscreens/Phone_auth.dart';
import 'package:demo/Screens/authenicationscreens/registeracc.dart';
import 'package:demo/Screens/authenicationscreens/reset.dart';
import 'package:demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/hello.jpeg",
            fit: BoxFit.cover,
            //color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.darken,
          ),
          isLoading == false
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //email
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid email';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                              decoration: InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //password
                            TextFormField(
                              controller: _password,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty || value.length <= 5) {
                                  return 'Invalid password';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                labelText: "Password",
                              ),
                            ),
                            FlatButton(
                                color: Colors.orange,
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  AuthClass().SiginIn(email: _email.text.trim(), Password: _password.text.trim())
                                      .then((value) {
                                    if (value == "Welcome") {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homepage()), (route) => false);
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                                    }
                                  });
                                },
                                child: Text("Login account")),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPage()));
                              },
                              child: Text("Forget password? reset"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                              child: Text("Don't have an account? register"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // SizedBox(height: 20.0),
                            //
                            // SignInButton(
                            //     Buttons.Google,
                            //     text: "Signup with google",
                            //     onPressed: (){}
                            // ),
       //Google signin
                            Column(
                              children: [


                            GestureDetector(
                              onTap: () {
                                AuthClass().signwithGoogle().then((UserCredential value){
                                  final displayName = value.user.displayName;
                                  print(displayName);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homepage()), (route) => false);
                                });
                              },
                                child: Container(
                                  color: Colors.orange,
                              padding: const EdgeInsets.all(10),
                              child: Text("SignIn with Google"))),
                                const SizedBox(
                                  height: 20,
                                ),
                                //phonenumber
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuth()));
                                  },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("Continue With Phone Number"),
                                )),
                                  const SizedBox(
                                    height: 20,
                                  ),


                            ],
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                ) : Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  }
}



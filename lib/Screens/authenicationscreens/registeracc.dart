import 'package:demo/Screens/authenicationscreens/login.dart';
import 'package:flutter/material.dart';
import '../../auth.dart';
import '../home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: isLoading == false ? Padding(
        padding: const EdgeInsets.all(10.0),

        child: Column(
        children: [
          TextFormField(
            controller: _email,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          const SizedBox(height: 30,),

          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              hintText: "password",
            ),
          ),

          FlatButton(
              color: Colors.deepOrangeAccent,
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                AuthClass().createAccount(email: _email.text.trim(), Password: _password.text.trim()).then((value) {
                  if(value == "Account Created"){
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                  }else{
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content : Text(value)));
                  }
                });
              },
              child: Text("Create account")),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("Alraedy have an account? login"),
          ),

          // const SizedBox(height: 30,),
          // GestureDetector(
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPage()));
          //   },
          //   child: Text("Forget password? reset"),
          // ),

        ],

      ),
      ): Center (child: CircularProgressIndicator())
    );
  }
}

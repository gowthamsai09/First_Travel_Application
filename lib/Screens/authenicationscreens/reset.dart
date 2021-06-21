
import 'package:demo/Screens/authenicationscreens/login.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController _email = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: isLoading == false? Padding(
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


            FlatButton(
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  AuthClass().
                  ResetPassword(email: _email.text.trim()).then((value) {
                    if(value == "Email sent"){
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
                }, child: Text("Reset Account")),
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
      ): Center(child: CircularProgressIndicator()),
    );
  }
}
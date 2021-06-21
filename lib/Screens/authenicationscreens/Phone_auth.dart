import 'dart:async';
import 'dart:ui';
import 'package:demo/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {

  String selectedCountry = "+91";
  List<String> country = ["+91", "+1", "+44"];
  String myVerificationId = "";
  TextEditingController _phone = TextEditingController();
  TextEditingController _code = TextEditingController();


   bool showClearIcon = false;

   String GetCodeText = "Get code";
   bool isSending = false;
   bool isLoading = false;

   Timer  _codeTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Phone Authentication"),

      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(

              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.5),
              ),
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  DropdownButton<String>(
                    underline: Container(),
                    value: selectedCountry,
                    items: country.map((String e){
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (String value){
                      setState(() {
                        selectedCountry = value;
                      });
                    },
                  ),
                  //Divider
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 25,
                    color: Colors.black,
                    width: 2,
                  ),

                  //phone field
                  Expanded(
                      child:TextFormField(
                        onChanged: (value){
                          setState(() {
                            if(value.isEmpty){
                              showClearIcon = false;
                            }else{
                              showClearIcon = true;
                            }
                          });
                        },
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter Phone Number"
                        ),
                      ),
                  ),

                  // clear icon
                  showClearIcon == false ? Text(""): IconButton(icon: Icon(Icons.close), onPressed: (){
                    setState(() {
                      _phone.clear();
                      showClearIcon = false;
                    });
                  }),

                ],
              ),
            ),


            // code field that user gets
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: TextFormField(
                          controller: _code,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Verification Code"
                          ),
                        ),
                      ),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      // get code button
                      Expanded(
                          child: GestureDetector(
                            onTap: isSending == false ? (){
                              if(_phone.text.isNotEmpty){
                                final number = selectedCountry + _phone.text;

                                print(number);//verify phone
                                verifyPhoneNumber(context, number);
                              }
                            } : null,
                            child: Container(
                              padding: const EdgeInsets.all(17),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.5),
                              ),
                              child: Text("$GetCodeText",
                              style: TextStyle(
                                color: isSending == false? Colors.grey: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ),
                      ),
                    ],
                  )
                ],
              ),

            ),
            // submit button
            GestureDetector(
              onTap: isLoading == false ? (){
                if(_code.text.isNotEmpty){
                  // verify code
                  verifySmsCode(context, _code.text.trim());
                  
                }
              } :null,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: Colors.amber,
                padding: const EdgeInsets.all(13),
                child: isLoading == false ?  Text("Verify Code") : Text("Loading......"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyPhoneNumber(BuildContext context, String phone) async{
    int duration = 60;
    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer){
      setState(() {

        isSending = true;
        if(duration < 1){
          _codeTimer.cancel();
          isSending = false;
          GetCodeText = "send again";
        }else{
          duration--;
          GetCodeText = "$duration s";

        }
      });
    });


    //Phone Auth
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await  _auth.signInWithCredential(credential);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homepage()), (route) => false);
        },
        timeout: const Duration(seconds: 60),
        verificationFailed: (FirebaseException error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.code)));
        },
        codeSent: (String verificatioId, int forceResendingToken){
      setState(() {
        myVerificationId = verificatioId;
      });
        },
        codeAutoRetrievalTimeout: (String verificationId) => null,
    );
  }
  // verify code

void verifySmsCode(BuildContext context, String code) async{
  FirebaseAuth auth = FirebaseAuth.instance;

  setState(() {

    isLoading  = true;
  });

  //create phone credential with code

  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: myVerificationId, smsCode: code);
  //sign in the user with credential
  await auth.signInWithCredential(credential);
  setState(() {
    isLoading = false;

  });
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homepage()), (route) => false);
  }
}

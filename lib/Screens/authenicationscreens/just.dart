// under verify
// key: _scaffoldkey,
// onTap: () async{
//
//   setState(() {
//     isLoading = true;
//   });
//
//   await _auth.verifyPhoneNumber(
//       phoneNumber: phoneController.text,
//       verificationCompleted: (phoneAuthCredential) async{
//         setState(() {
//           isLoading = false;
//         });
//       },
//       verificationFailed: (FirebaseException error) async{
//         setState(() {
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(error.code)));
//       },
//       codeSent: (String verifiactionId, int?  forceResendingToken) async{
//         setState(() {
//           isLoading = false;
//           myVerificationId = verifiactionId;
//         });
//       },
//       codeAutoRetrievalTimeout: (verificationId) async{
//
//       }
//   );
// },
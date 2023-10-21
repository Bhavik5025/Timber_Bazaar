import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_stockpile/Login%20&%20registration/login.dart';
import 'package:wood_stockpile/Login%20&%20registration/waiting_screen.dart';
import 'package:wood_stockpile/user_dashboard/home_screen.dart';
import 'package:wood_stockpile/wood_seller_dashboard/homescreen.dart';

final _firebase = FirebaseAuth.instance;
final _firebaseFirestore = FirebaseFirestore.instance;
var status = false;
var email = "";
var type = "";

// class IntermediateScreen extends StatefulWidget {
//   @override
//   State<IntermediateScreen> createState() => _IntermediateScreenState();
// }

// class _IntermediateScreenState extends State<IntermediateScreen> {
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     try {
//       print(_firebase.currentUser!.uid);
//       final DocumentSnapshot snapshot1 = await FirebaseFirestore.instance
//           .collection("unverified_users")
//           .doc(_firebase.currentUser!.uid)
//           .get();

//       if (snapshot1.exists) {
//         final Map<String, dynamic> data =
//             snapshot1.data() as Map<String, dynamic>;

//         // Set data in 'users' collection
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(_firebase.currentUser!.uid)
//             .set({
//           'email': data['email'],
//           'password': data['password'],
//           'mobile_number': data['mobile_number'],
//           'type': data['type'],
//           'username': data['username'],
//         });

//         // Delete document from 'unverified_users'
//         await FirebaseFirestore.instance
//             .collection('unverified_users')
//             .doc(_firebase.currentUser!.uid)
//             .delete();
//         prefs.setString("unumber", data['mobile_number']);
//         prefs.setString("uemail", data['email']);
//         print("Data moved and deleted successfully.");
//       } else {
//         print("Document not found in 'unverified_users'.");
//       }
// //--------------------------------------------------------------
//       final DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection("users")
//           .doc(_firebase.currentUser!.uid)
//           .get();

//       if (snapshot.exists) {
//         final Map<String, dynamic> data =
//             snapshot.data() as Map<String, dynamic>;
//         prefs.setString("unumber", data['mobile_number'] as String);
//         prefs.setString("uemail", data['email'] as String);

//         final String? fetchedEmail = data['email'] as String?;
//         final String? fetchedtype = data['type'] as String?;
//         // if (fetchedEmail != null && fetchedEmail.isNotEmpty) {
//         //   setState(() {
//         //     status = true;
//         //     email = fetchedEmail;
//         //     type = fetchedtype.toString();
//         //   });
//         //   if (type == "user") {
//         //     Navigator.pushReplacement(
//         //         context, MaterialPageRoute(builder: (context) => Homescreen()));
//         //   }
//         //   if (type == "wood_seller") {
//         //     await prefs.setString('company_email', fetchedEmail);
//         //     Navigator.pushReplacement(
//         //         context, MaterialPageRoute(builder: (context) => homescreen()));
//         //   }
//         // }
//         if (fetchedEmail != null && fetchedEmail.isNotEmpty) {
//           setState(() {
//             status = true;
//             email = fetchedEmail;
//             type = data['type'].toString(); // Safely access 'type'
//           });

//           if (type == "user") {
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => Homescreen()));
//           }
//           if (type == "wood_seller") {
//             await prefs.setString('company_email', fetchedEmail);
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => homescreen()));
//           }
//         } else {
//           // Handle the case where 'email' is empty or null
//           // Navigator.pushReplacement(
//           //     context, MaterialPageRoute(builder: (context) => login()));
//         }
//       } else {
//         // Handle the case where the document doesn't exist
//         final DocumentSnapshot snapshot2 = await FirebaseFirestore.instance
//             .collection("unverified_wood_seller")
//             .doc(_firebase.currentUser!.uid)
//             .get();
//         final Map<String, dynamic> data =
//             snapshot2.data() as Map<String, dynamic>;
//         final String? fetchedEmail = data['email'] as String?;
//         print(fetchedEmail);
//         if (fetchedEmail != null && fetchedEmail.isNotEmpty) {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => waiting_screen()));
//         }
//       }
//     } catch (error) {
//       // Handle errors that may occur during data retrieval
//       print("Error: $error");
//     }
//   }

//   void backtologin() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//               child: SizedBox(
//             height: 400, // Adjust the height as needed
//             child: Lottie.asset("assets/lottie/loading.json"),
//           )),
//           // ElevatedButton.icon(
//           //     style: ElevatedButton.styleFrom(
//           //       backgroundColor: Colors.black, // background color
//           //       foregroundColor: Colors.white,
//           //     ),
//           //     onPressed: backtologin,
//           //     icon: Icon(Icons.arrow_back),
//           //     label: Text("Back to Login Screen"))
//         ],
//       ),
//     );
//   }
// }
class IntermediateScreen extends StatefulWidget {
  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final DocumentSnapshot snapshot1 = await FirebaseFirestore.instance
          .collection("unverified_users")
          .doc(_firebase.currentUser!.uid)
          .get();

      if (snapshot1.exists) {
        final Map<String, dynamic>? data =
            snapshot1.data() as Map<String, dynamic>?;
        if (data != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_firebase.currentUser!.uid)
              .set({
            'email': data['email'],
            'password': data['password'],
            'mobile_number': data['mobile_number'],
            'type': data['type'],
            'username': data['username'],
          });

          await FirebaseFirestore.instance
              .collection('unverified_users')
              .doc(_firebase.currentUser!.uid)
              .delete();
          prefs.setString("unumber", data['mobile_number'] ?? '');
          prefs.setString("uemail", data['email'] ?? '');

          prefs.setString("uname", data["username"] ?? '');
          print("Data moved and deleted successfully.");
        } else {
          print("Document data in 'unverified_users' is null.");
        }
      } else {
        print("Document not found in 'unverified_users'.");
      }

      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(_firebase.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;
        final String? fetchedEmail = data?['email'];
        final String? fetchedType = data?['type'];

        if (fetchedEmail != null &&
            fetchedEmail.isNotEmpty &&
            fetchedType != null) {
          setState(() {
            status = true;
            email = fetchedEmail;
            type = fetchedType.toString();
          });

          if (type == "user") {
            prefs.setString("unumber", data?['mobile_number'] ?? '');
            prefs.setString("uemail", data?['email'] ?? '');
            prefs.setString("uname", data?["username"] ?? '');
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homescreen()));
          } else if (type == "wood_seller") {
            await prefs.setString('company_email', fetchedEmail);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => homescreen()));
          }
        } else {
          // Handle the case where 'email' is empty or null
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => login()));
        }
      } else {
        final DocumentSnapshot snapshot2 = await FirebaseFirestore.instance
            .collection("unverified_wood_seller")
            .doc(_firebase.currentUser!.uid)
            .get();
        final Map<String, dynamic>? data =
            snapshot2.data() as Map<String, dynamic>?;
        final String? fetchedEmail = data?['email'];
        print(fetchedEmail);
        if (fetchedEmail != null && fetchedEmail.isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => waiting_screen()));
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void backToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 400, // Adjust the height as needed
              child: Lottie.asset("assets/lottie/loading.json"),
            ),
          ),
          // ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.black, // background color
          //       foregroundColor: Colors.white,
          //     ),
          //     onPressed: backToLogin,
          //     icon: Icon(Icons.arrow_back),
          //     label: Text("Back to Login Screen"))
        ],
      ),
    );
  }
}

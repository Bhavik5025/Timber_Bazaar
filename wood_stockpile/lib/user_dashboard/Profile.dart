// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:wood_stockpile/Login%20&%20registration/login.dart';

// class Profile extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState

//     return _profile();
//   }
// }

// class _profile extends State<Profile> {
//   String email = "";
//   String mobileNumber = "";
//   String username = "";

//   @override
//   void initState() {
//     super.initState();
//     fetchUserDetails();
//   }

//   Future<void> fetchUserDetails() async {
//     // Fetch user details from Firebase Authentication
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         email = user.email ?? "";
//         username = user.displayName ?? "";
//         mobileNumber = user.phoneNumber ?? "";
//       });

//       // Fetch additional user details from Firestore (you may need to adapt this to your database structure)
//       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (userSnapshot.exists) {
//         setState(() {
//           // Assuming your Firestore document has fields like 'email' and 'mobileNumber'
//           email = userSnapshot['email'] ?? email;
//           mobileNumber = userSnapshot['mobileNumber'] ?? mobileNumber;
//           // You can fetch more fields as needed
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 60,
//               backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//               child: Text(
//                 username[
//                     0], // Display the first character of the username as the avatar
//                 style: TextStyle(fontSize: 48, color: Colors.white),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               username,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               email,
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               mobileNumber,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               onPressed: () {
//                 // Log Out action here
//                 FirebaseAuth.instance.signOut();
//                 // Navigate to the login screen
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           login()), // Replace with your login screen/widget.
//                 );
//               },
//               child: Text('Log Out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wood_stockpile/Login%20&%20registration/login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  String email = "";
  String mobileNumber = "";
  String username = "";

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    // Fetch user details from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? "";
        username = user.displayName ?? "";
        mobileNumber = user.phoneNumber ?? "";
      });

      // Fetch additional user details from Firestore (you may need to adapt this to your database structure)
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          // Assuming your Firestore document has fields like 'email' and 'mobileNumber'
          email = userSnapshot['email'] ?? email;
          username = userSnapshot['username'] ?? username;
          mobileNumber = userSnapshot['mobile_number'] ?? mobileNumber;
          // You can fetch more fields as needed
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              child: Text(
                username.isNotEmpty
                    ? username[0]
                    : "", // Display the first character of the username as the avatar
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text(
              username,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              mobileNumber,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Log Out action here
                FirebaseAuth.instance.signOut();
                // Navigate to the login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

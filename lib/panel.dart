// import 'package:flutter/material.dart';
// import 'package:shopping_app/pages/signup.dart';
//
// import 'Admin/admin_login.dart';
//
// class CircleScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff2f2f2),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // Admin Circle
//             GestureDetector(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
//               },
//               child: CircleContainer(
//                 label: 'Admin',
//                 color: Colors.blueAccent,
//               ),
//             ),
//             // User Circle
//             GestureDetector(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
//               },
//               child: CircleContainer(
//                 label: 'User',
//                 color: Colors.redAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CircleContainer extends StatelessWidget {
//   final String label;
//   final Color color;
//
//   CircleContainer({required this.label, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.3),
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: color,
//           width: 10,
//         ),
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/signup.dart';
import 'Admin/admin_login.dart';

class CircleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Panel',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0, // Removes the shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Navigate back
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Add title or other app bar properties here if needed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Admin Circle
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLogin()),
                );
              },
              child: CircleContainer(
                label: 'Admin',
                color: Colors.blueAccent,
              ),
            ),
            // User Circle
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: CircleContainer(
                label: 'User',
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  final String label;
  final Color color;

  CircleContainer({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 10,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}

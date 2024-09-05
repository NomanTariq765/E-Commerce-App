import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Admin/home_admin.dart';

import '../widget/support_widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController  usernamecontroller = new TextEditingController();
  TextEditingController  userpasswordcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 90,right: 40,left: 40),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('images/LogIn.png',height: 150,width: 150,)),
                Center(child: Text('Admin Panal',style: AppWidget.boldTextFieldStyle())),
                SizedBox(height: 50,),
                Text('Username',style: AppWidget.semiBoldTextFieldStyle()),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: usernamecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Text('Password',style: AppWidget.semiBoldTextFieldStyle()),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: userpasswordcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    LoginAdmin();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
  LoginAdmin(){
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['username']!= usernamecontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content:Text('Your Id is not correct',style: TextStyle(fontSize: 20),)));
        }
        else if(result.data()['password']!= userpasswordcontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content:Text('Your Password is not correct',style: TextStyle(fontSize: 20),)));
        }
        else
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeAdmin()));
          }
      });
    });
  }
}


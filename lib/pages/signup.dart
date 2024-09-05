import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/pages/bottomnav.dart';
import 'package:shopping_app/pages/login.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/services/shared_pref.dart';

import '../widget/support_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name , email , password;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration()async{
    if(password!=null && email !=null && name!=null){
      try{
        UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email!,
            password: password!
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content:Text('Registered Successfully',style: TextStyle(fontSize: 20),)));
        String Id =randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserEmail(emailController.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserImage('https://firebasestorage.googleapis.com/v0/b/shoppingapp-91674.appspot.com/o/blogImage%2Fimages.png?alt=media&token=5d0a4655-b3ee-429c-9996-6722be12941c');
        Map<String,dynamic> userInfoMap={
          'Name' : nameController.text,
          'Email' : emailController.text,
          'id' : Id,
          'image' : 'https://firebasestorage.googleapis.com/v0/b/shoppingapp-91674.appspot.com/o/blogImage%2Fimages.png?alt=media&token=5d0a4655-b3ee-429c-9996-6722be12941c'
        };
        await DatabaseMethod().addUserDetails(userInfoMap, Id);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
      } on FirebaseException catch(e){
        if(e.code=='weak-pasword'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content:Text('Password Provided it too Week',style: TextStyle(fontSize: 20),)));
        }
        else if(e.code=='email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content:Text('Account Already Exist',style: TextStyle(fontSize: 20),)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 90,right: 40,left: 40),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('images/LogIn.png',height: 150,width: 150,)),
                Center(child: Text('Sign Up',style: AppWidget.boldTextFieldStyle())),
                SizedBox(height: 10,),
                Center(
                  child: Text('Please enter the details below to \n                      '
                      'Continoue',style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 15,),
                Text('Name',style: AppWidget.semiBoldTextFieldStyle()),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Your Name';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text('Email',style: AppWidget.semiBoldTextFieldStyle()),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Your Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
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
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        name=nameController.text;
                        email=emailController.text;
                        password=passwordController.text;
                      });
                    }
                    registration();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('SIGN UP',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                        },
                        child: Text('Sign In',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w500),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


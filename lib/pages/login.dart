import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/bottomnav.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/pages/signup.dart';
import 'package:shopping_app/widget/support_widget.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email="",password="";

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
    } on FirebaseException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content:Text('No User Found for that Email',style: TextStyle(fontSize: 20),)));
      }
      else if(e.code=='wrong-passowrd'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content:Text('Wrong Password Provided by User',style: TextStyle(fontSize: 20),)));
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
                Center(child: Text('Sign In',style: AppWidget.boldTextFieldStyle())),
                SizedBox(height: 20,),
                Center(
                  child: Text('Please enter the details below to \n                      '
                      'Continoue',style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 40,),
                Text('Email',style: AppWidget.semiBoldTextFieldStyle()),
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email=emailController.text;
                        password=passwordController.text;
                      });
                    }
                    userLogin();
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
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                        child: Text('Sign Up',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w500),))

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

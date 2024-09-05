import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:shopping_app/pages/onboarding.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/services/shared_pref.dart';
import 'package:shopping_app/widget/support_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String? image, name , email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getthesharedpref()async{
    image = await SharedPreferenceHelper().getUserImage();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {
    });
  }

  @override
  void initState() {
    getthesharedpref();
    super.initState();
  }

  Future getImage ()async{
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage=File(image!.path);
    uploadItem();
    setState(() {

    });
  }

  uploadItem()async{
    if(selectedImage!=null){
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('blogImage').child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserImage(downloadUrl);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff2f2f2),
        title: Text('Profile',style: AppWidget.boldTextFieldStyle(),),
      ),
      backgroundColor: Color(0xfff2f2f2),
      body: name == null ? Center(child: CircularProgressIndicator()) : Container(
        child: Column(
          children: [
            selectedImage!=null?
        GestureDetector(
        onTap: (){
          getImage();
      },
             child: Center(child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.file(selectedImage!,height: 150,width: 150,fit: BoxFit.cover,)))):
              GestureDetector(
                  onTap: (){
                    getImage();
                  },
                  child: Center(child: ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.network(image!,height: 150,width: 150,fit: BoxFit.cover,)))),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person_outlined,size: 36,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',style: AppWidget.lightTextFieldStyle(),),
                          Text(name!,style: AppWidget.semiBoldTextFieldStyle(),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.mail_outlined,size: 36,),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email',style: AppWidget.lightTextFieldStyle(),),
                          Text(email!,style: AppWidget.semiBoldTextFieldStyle(),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                await AuthMethods().SignOut().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.logout_outlined,size: 36,),
                        SizedBox(width: 10,),
                        Text('Logout',style: AppWidget.semiBoldTextFieldStyle(),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                await AuthMethods().deleteuser().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outlined,size: 36,),
                        SizedBox(width: 10,),
                        Text('Delete Account',style: AppWidget.semiBoldTextFieldStyle(),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

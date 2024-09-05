import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/services/shared_pref.dart';
import 'package:shopping_app/widget/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String? email;

  getthesharedpref()async{
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {
    });
  }

  Stream? orderStream;

  getonload()async{
    await getthesharedpref();
    orderStream = await DatabaseMethod().getOrders(email!);
    setState(() {
    });
  }
  @override
  void initState() {
    getonload();
    super.initState();
  }

  Widget allOrders(){
    return StreamBuilder(stream: orderStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index){
        DocumentSnapshot ds= snapshot.data.docs[index];

        return  Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.only(left: 20,top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
              Row(
                children: [
                  Image.network(
                    ds['ProductImage'],
                    height: 120,width: 120,fit: BoxFit.cover,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: [
                        Text(ds['Product'],style: AppWidget.semiBoldTextFieldStyle(),),
                        Text("\$" + ds['Price'] ,style: TextStyle(color: Color(0xFFfd6f3e,),fontSize: 23,fontWeight: FontWeight.bold)),
                        Text("Status : " + ds['Status'] ,style: TextStyle(color: Color(0xFFfd6f3e,),fontSize: 18,fontWeight: FontWeight.bold)),


                      ],
                    ),
                  )
                ],
              ),

            ),
          ),
        );
      }):Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: Color(0xfff2f2f2),
          title: Center(child: Text('Current Orders',style: AppWidget.boldTextFieldStyle(),)),
        ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          children: [
            Expanded(child: allOrders()),
          ],
        ),
      ),
    );
  }
}

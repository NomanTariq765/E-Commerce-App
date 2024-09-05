import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/product_detail.dart';
import 'package:shopping_app/services/database.dart';
import '../widget/support_widget.dart';

class CategortyProduct extends StatefulWidget {
String category;
CategortyProduct({
  required this.category,
});

  @override
  State<CategortyProduct> createState() => _CategortyProductState();
}

class _CategortyProductState extends State<CategortyProduct> {

  Stream? CategoryStream;

  getontheload()async{
    CategoryStream=await DatabaseMethod().getProducts(widget.category);
    setState(() {

    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProduct(){
    return StreamBuilder(stream: CategoryStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?GridView.builder(
        padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,childAspectRatio: 0.6 ,mainAxisSpacing: 10, crossAxisSpacing: 10),itemCount: snapshot.data.docs.length, itemBuilder: (context,index){
          DocumentSnapshot ds= snapshot.data.docs[index];

          return  Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Image.network(
                    ds['Image'],
                    height: 150,width: 150,fit: BoxFit.contain,),
                  SizedBox(height: 10,),
                  Text(
                    ds['Name'],
                    style: AppWidget.semiBoldTextFieldStyle(),),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '\$'+ds['Price']
                        ,style: TextStyle(color: Color(0xFFfd6f3e),fontSize: 22,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(name: ds['Name'], image: ds['Image'], detail: ds['Detail'], price: ds['Price'])));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFfd6f3e,),borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      )
                    ],
                  )
                ],
              )
          );
      }):Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 13,right: 13),
        child: Column(
        children: [
        Expanded(child: allProduct())
      ],),),
    );
  }
}

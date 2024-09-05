import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shopping_app/Admin/add_product.dart';
import 'package:shopping_app/Admin/admin_login.dart';
import 'package:shopping_app/Admin/all_orders.dart';
import 'package:shopping_app/Admin/home_admin.dart';
import 'package:shopping_app/pages/bottomnav.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/pages/login.dart';
import 'package:shopping_app/pages/onboarding.dart';
import 'package:shopping_app/pages/product_detail.dart';
import 'package:shopping_app/pages/signup.dart';
import 'package:shopping_app/panel.dart';
import 'package:shopping_app/services/constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=publishablekey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Onboarding()
      // home : AllOrders()
      // home: SignUp(),
    );
  }
}


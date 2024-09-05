// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shopping_app/pages/categories_product.dart';
// import 'package:shopping_app/pages/product_detail.dart';
// import 'package:shopping_app/services/database.dart';
// import 'package:shopping_app/services/shared_pref.dart';
// import 'package:shopping_app/widget/support_widget.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   bool search = false;
//   List categories = [
//     'images/headphone_icon.png',
//     'images/laptop.png',
//     'images/watch.png',
//     'images/TV.png',
//   ];
//
//   List categoryNames = ['Headphones', 'Laptop', 'Watch', 'TV'];
//
//   var queryResultSet = [];
//   var tempSearchStore = [];
//   TextEditingController searchcontroller = new TextEditingController();
//   // Method to handle the search functionality
//   void initiateSearch(String value) {
//     if (value.isEmpty) {
//       setState(() {});
//       return;
//     }
//
//     setState(() {
//       search = true;
//     });
//
//     String capitalizedValue =
//         value.substring(0, 1).toUpperCase() + value.substring(1);
//     if (queryResultSet.isEmpty && value.length == 1) {
//       DatabaseMethod().search(value).then((QuerySnapshot docs) {
//         for (int i = 0; i < docs.docs.length; ++i) {
//           queryResultSet.add(docs.docs[i].data());
//         }
//       });
//     } else {
//       tempSearchStore = [];
//       queryResultSet.forEach((element) {
//         if (element['UpdatedName'].startsWith(capitalizedValue)) {
//           setState(() {
//             tempSearchStore.add(element);
//           });
//         }
//       });
//     }
//   }
//
//   String? name, image;
//
//   // Method to retrieve shared preferences for the username and profile image
//   Future<void> getSharedPref() async {
//     name = await SharedPreferenceHelper().getUserName();
//     image = await SharedPreferenceHelper().getUserImage();
//
//     setState(() {});
//   }
//
//   Future<void> onLoad() async {
//     await getSharedPref();
//   }
//
//   @override
//   void initState() {
//     onLoad();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff2f2f2),
//       body: name == null
//           ? Center(child: CircularProgressIndicator())
//           : Container(
//               margin: EdgeInsets.only(top: 50, left: 20, right: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildGreetingSection(),
//                     SizedBox(height: 30),
//                     _buildSearchField(),
//                     SizedBox(height: 20),
//                     search ? _buildSearchResults() : _buildCategoriesSection(),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
//
//   // Greeting section with user name and profile picture
//   Widget _buildGreetingSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Hey, $name', style: AppWidget.boldTextFieldStyle()),
//             Text('Good Morning', style: AppWidget.lightTextFieldStyle()),
//           ],
//         ),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Image.network(
//             image!,
//             height: 65,
//             width: 65,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return Icon(Icons.error,
//                   size: 40); // Fallback icon if image fails
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Search field for product search
//   Widget _buildSearchField() {
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       width: MediaQuery.of(context).size.width,
//       child: TextField(
//         controller: searchcontroller,
//         onChanged: (value) {
//           initiateSearch(value.toUpperCase());
//         },
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: 'Search Product',
//           hintStyle: AppWidget.lightTextFieldStyle(),
//           prefixIcon: search
//               ? GestureDetector(
//                   onTap: () {
//                     search = false;
//                     tempSearchStore = [];
//                     queryResultSet = [];
//                     searchcontroller.text = '';
//                     setState(() {});
//                   },
//                   child: Icon(Icons.close))
//               : Icon(Icons.search),
//         ),
//       ),
//     );
//   }
//
//   // Display search results
//   Widget _buildSearchResults() {
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       primary: false,
//       shrinkWrap: true,
//       children: tempSearchStore.map((element) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 10), // Add space between items
//           child: buildResultCard(element),
//         );
//       }).toList(),
//     );
//   }
//
//   // Build individual result card
//   Widget buildResultCard(data) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ProductDetail(
//                     name: data['Name'],
//                     image: data['Image'],
//                     detail: data['Detail'],
//                     price: data['Price'])));
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 20, right: 20),
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         height: 100,
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 data['Image'],
//                 height: 70,
//                 width: 70,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Text(data['Name'], style: AppWidget.semiBoldTextFieldStyle()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Categories section with category tiles and all products display
//   Widget _buildCategoriesSection() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(right: 20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Categories', style: AppWidget.semiBoldTextFieldStyle()),
//               Text(
//                 'see all',
//                 style: TextStyle(
//                   color: Color(0xFFfd6f3e),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20),
//         _buildCategoryList(),
//         SizedBox(height: 20),
//         _buildAllProductsSection(),
//       ],
//     );
//   }
//
//   // Display the list of categories
//   Widget _buildCategoryList() {
//     return Row(
//       children: [
//         Container(
//           height: 130,
//           padding: EdgeInsets.all(20),
//           margin: EdgeInsets.only(right: 20),
//           decoration: BoxDecoration(
//             color: Color(0xFFfd6f3e),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Center(
//             child: Text(
//               'All',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             height: 130,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               itemCount: categories.length,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return CategoryTile(
//                   image: categories[index],
//                   name: categoryNames[index],
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Display all products section
//   Widget _buildAllProductsSection() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(right: 20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('All Products', style: AppWidget.semiBoldTextFieldStyle()),
//               Text(
//                 'see all',
//                 style: TextStyle(
//                   color: Color(0xFFfd6f3e),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 30),
//         // Container(
//         //   height: 240,
//         //   child: ListView(
//         //     shrinkWrap: true,
//         //     scrollDirection: Axis.horizontal,
//         //     children: [
//         //       Container(
//         //         margin: EdgeInsets.only(right: 20),
//         //         padding:
//         //         EdgeInsets.symmetric(horizontal: 20),
//         //         decoration: BoxDecoration(
//         //           color: Colors.white,
//         //           borderRadius: BorderRadius.circular(15),
//         //         ),
//         //         child: Column(
//         //           children: [
//         //             Image.asset(
//         //               'images/headphone2.png',
//         //               height: 150,
//         //               width: 150,
//         //               fit: BoxFit.cover,
//         //             ),
//         //             Text(
//         //               'Headphone',
//         //               style:
//         //               AppWidget.semiBoldTextFieldStyle(),
//         //             ),
//         //             SizedBox(height: 10),
//         //             Row(
//         //               children: [
//         //                 Text(
//         //                   '\$100',
//         //                   style: TextStyle(
//         //                       color: Color(0xFFfd6f3e),
//         //                       fontSize: 22,
//         //                       fontWeight: FontWeight.bold),
//         //                 ),
//         //                 SizedBox(width: 40),
//         //                 Container(
//         //                   padding: EdgeInsets.all(5),
//         //                   decoration: BoxDecoration(
//         //                     color: Color(0xFFfd6f3e),
//         //                     borderRadius:
//         //                     BorderRadius.circular(7),
//         //                   ),
//         //                   child: Icon(
//         //                     Icons.add,
//         //                     color: Colors.white,
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       Container(
//         //         margin: EdgeInsets.only(right: 20),
//         //         padding:
//         //         EdgeInsets.symmetric(horizontal: 20),
//         //         decoration: BoxDecoration(
//         //           color: Colors.white,
//         //           borderRadius: BorderRadius.circular(15),
//         //         ),
//         //         child: Column(
//         //           children: [
//         //             Image.asset(
//         //               'images/watch2.png',
//         //               height: 150,
//         //               width: 150,
//         //               fit: BoxFit.cover,
//         //             ),
//         //             Text(
//         //               'Apple Watch',
//         //               style:
//         //               AppWidget.semiBoldTextFieldStyle(),
//         //             ),
//         //             SizedBox(height: 10),
//         //             Row(
//         //               children: [
//         //                 Text(
//         //                   '\$300',
//         //                   style: TextStyle(
//         //                       color: Color(0xFFfd6f3e),
//         //                       fontSize: 22,
//         //                       fontWeight: FontWeight.bold),
//         //                 ),
//         //                 SizedBox(width: 40),
//         //                 Container(
//         //                   padding: EdgeInsets.all(5),
//         //                   decoration: BoxDecoration(
//         //                     color: Color(0xFFfd6f3e),
//         //                     borderRadius:
//         //                     BorderRadius.circular(7),
//         //                   ),
//         //                   child: Icon(
//         //                     Icons.add,
//         //                     color: Colors.white,
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       Container(
//         //         margin: EdgeInsets.only(right: 20),
//         //         padding:
//         //         EdgeInsets.symmetric(horizontal: 20),
//         //         decoration: BoxDecoration(
//         //           color: Colors.white,
//         //           borderRadius: BorderRadius.circular(15),
//         //         ),
//         //         child: Column(
//         //           children: [
//         //             Image.asset(
//         //               'images/laptop2.png',
//         //               height: 150,
//         //               width: 150,
//         //               fit: BoxFit.cover,
//         //             ),
//         //             Text(
//         //               'Laptop',
//         //               style:
//         //               AppWidget.semiBoldTextFieldStyle(),
//         //             ),
//         //             SizedBox(height: 10),
//         //             Row(
//         //               children: [
//         //                 Text(
//         //                   '\$2000',
//         //                   style: TextStyle(
//         //                       color: Color(0xFFfd6f3e),
//         //                       fontSize: 22,
//         //                       fontWeight: FontWeight.bold),
//         //                 ),
//         //                 SizedBox(width: 40),
//         //                 Container(
//         //                   padding: EdgeInsets.all(5),
//         //                   decoration: BoxDecoration(
//         //                     color: Color(0xFFfd6f3e),
//         //                     borderRadius:
//         //                     BorderRadius.circular(7),
//         //                   ),
//         //                   child: Icon(
//         //                     Icons.add,
//         //                     color: Colors.white,
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         // Main Container Widget
//         Container(
//           height: 240,
//           child: ListView(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             children: [
//               // Reusable Product Container
//               buildProductItem(
//                 context,
//                 'images/headphone2.png',
//                 'Headphone',
//                 '100',
//                 'High-quality sound with noise cancellation features.',
//               ),
//               buildProductItem(
//                 context,
//                 'images/watch2.png',
//                 'Apple Watch',
//                 '300',
//                 'Smartwatch with fitness tracking and notifications.',
//               ),
//               buildProductItem(
//                 context,
//                 'images/laptop2.png',
//                 'Laptop',
//                 '2000',
//                 'High-performance laptop for gaming and professional work.',
//               ),
//             ],
//           ),
//         ),
//
// // Function to Build Each Product Item
//       ],
//     );
//   }
//
//   Widget buildProductItem(BuildContext context, String image, String name,
//       String price, String detail) {
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           Image.asset(
//             image,
//             height: 150,
//             width: 150,
//             fit: BoxFit.cover,
//           ),
//           Text(
//             name,
//             style: AppWidget.semiBoldTextFieldStyle(),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 '\$$price',
//                 style: TextStyle(
//                   color: Color(0xFFfd6f3e),
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProductDetail(
//                         name: name,
//                         image: image,
//                         detail: detail,
//                         price: price,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFfd6f3e),
//                     borderRadius: BorderRadius.circular(7),
//                   ),
//                   child: Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(String imagePath, String name, String price) {
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           Image.asset(imagePath, height: 150, width: 150, fit: BoxFit.cover),
//           Text(name, style: AppWidget.semiBoldTextFieldStyle()),
//           Text(price, style: TextStyle(color: Colors.red, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
//
// class CategoryTile extends StatelessWidget {
//   String image, name;
//   CategoryTile({required this.image, required this.name});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CategortyProduct(category: name)));
//       },
//       child: Container(
//         padding: EdgeInsets.all(20),
//         margin: EdgeInsets.only(right: 20),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset(
//               image,
//               height: 50,
//               width: 50,
//               fit: BoxFit.cover,
//             ),
//             Icon(Icons.arrow_forward),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // Product Detail Screen Widget
// class ProductDetail extends StatelessWidget {
//   final String name;
//   final String image;
//   final String detail;
//   final String price;
//
//   const ProductDetail({
//     Key? key,
//     required this.name,
//     required this.image,
//     required this.detail,
//     required this.price,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(name),
//         backgroundColor: Color(0xfff2f2f2),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.asset(
//                 image,
//                 height: 300,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               name,
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               '\$$price',
//               style: TextStyle(fontSize: 2, color: Color(0xFFfd6f3e)),
//             ),
//             SizedBox(height: 20),
//             Text(
//               detail,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/categories_product.dart';
import 'package:shopping_app/pages/product_detail.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/services/shared_pref.dart';
import 'package:shopping_app/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;
  List categories = [
    'images/headphone_icon.png',
    'images/laptop.png',
    'images/watch.png',
    'images/TV.png',
  ];

  List categoryNames = [
    'Headphones',
    'Laptop',
    'Watch',
    'TV'
  ];

  var queryResultSet = [];
  var tempSearchStore = [];
  TextEditingController searchcontroller = new TextEditingController();

  // Method to handle the search functionality
  void initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {});
      return;
    }

    setState(() {
      search = true;
    });

    String capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethod().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['UpdatedName'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  String? name, image;

  // Method to retrieve shared preferences for the username and profile image
  Future<void> getSharedPref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();

    setState(() {});
  }

  Future<void> onLoad() async {
    await getSharedPref();
  }

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingSection(),
              SizedBox(height: 30),
              _buildSearchField(),
              SizedBox(height: 20),
              search ? _buildSearchResults() : _buildCategoriesSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Greeting section with user name and profile picture
  Widget _buildGreetingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hey, $name', style: AppWidget.boldTextFieldStyle()),
            Text('Good Morning', style: AppWidget.lightTextFieldStyle()),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            image!,
            height: 65,
            width: 65,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 40); // Fallback icon if image fails
            },
          ),
        ),
      ],
    );
  }

  // Search field for product search
  Widget _buildSearchField() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: searchcontroller,
        onChanged: (value) {
          initiateSearch(value.toUpperCase());
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Product',
          hintStyle: AppWidget.lightTextFieldStyle(),
          prefixIcon: search ? GestureDetector(
              onTap: (){
                search = false;
                tempSearchStore = [];
                queryResultSet = [];
                searchcontroller.text = '';
                setState(() {});
              },
              child: Icon(Icons.close)) : Icon(Icons.search),
        ),
      ),
    );
  }

  // Display search results
  Widget _buildSearchResults() {
    return ListView(
      padding: EdgeInsets.only(left: 10, right: 10),
      primary: false,
      shrinkWrap: true,
      children: tempSearchStore.map((element) {
        return buildResultCard(element);
      }).toList(),
    );
  }

  // Build individual result card
  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(
            name: data['Name'], image: data['Image'], detail: data['Detail'], price: data['Price'])));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data['Image'],
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20,),
            Text(data['Name'], style: AppWidget.semiBoldTextFieldStyle()),
          ],
        ),
      ),
    );
  }

  // Categories section with category tiles and all products display
  Widget _buildCategoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories', style: AppWidget.semiBoldTextFieldStyle()),
              Text(
                'see all',
                style: TextStyle(
                  color: Color(0xFFfd6f3e),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        _buildCategoryList(),
        SizedBox(height: 20),
        _buildAllProductsSection(),
      ],
    );
  }

  // Display the list of categories
  Widget _buildCategoryList() {
    return Row(
      children: [
        Container(
          height: 130,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Color(0xFFfd6f3e),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'All',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 130,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryTile(
                  image: categories[index],
                  name: categoryNames[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Display all products section
  Widget _buildAllProductsSection() {
    // Dummy product data for demonstration purposes
    final products = [
      {'imagePath': 'images/headphone2.png', 'name': 'Headphone', 'price': '\$100'},
      {'imagePath': 'images/watch2.png', 'name': 'Apple Watch', 'price': '\$300'},
      {'imagePath': 'images/laptop2.png', 'name': 'Laptop', 'price': '\$2000'},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('All Products', style: AppWidget.semiBoldTextFieldStyle()),
              Text(
                'see all',
                style: TextStyle(
                  color: Color(0xFFfd6f3e),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 240,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(
                products[index]['imagePath']!,
                products[index]['name']!,
                products[index]['price']!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(String imagePath, String name, String price) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, height: 150, width: 150, fit: BoxFit.cover),
          Text(name, style: AppWidget.semiBoldTextFieldStyle()),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(price, style: TextStyle(color: Colors.red, fontSize: 22,fontWeight: FontWeight.bold)),
               SizedBox(width: 40,),
               Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFfd6f3e,),borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(Icons.add,color: Colors.white,),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;

  CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategortyProduct(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}

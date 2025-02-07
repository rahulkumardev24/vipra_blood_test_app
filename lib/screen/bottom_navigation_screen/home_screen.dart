import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/screen/order_test_screen.dart';
import 'package:vipra_lap/service/auth_service.dart';
import 'package:vipra_lap/widgets/banner_slider.dart';
import 'package:vipra_lap/widgets/categories_card.dart';
import 'package:vipra_lap/widgets/order_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  /// Offers Image
  List<Widget> offers = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
            image: const DecorationImage(
                image: AssetImage("assets/images/offers 1 .jpg"),
                fit: BoxFit.cover)),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
            image: const DecorationImage(
                image: AssetImage("assets/images/offers 2 .jpg"),
                fit: BoxFit.cover)),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
            image: const DecorationImage(
                image: AssetImage("assets/images/offers 3.jpg"),
                fit: BoxFit.cover)),
      ),
    ),
  ];

  int offerIndex = 0;

  /// categories data
  List<Map<String, dynamic>> cate = [
    {"title": "Medicine", "image": "assets/icons/medicine.png"},
    {"title": "Blood test", "image": "assets/icons/blood-test.png"},
    {"title": "Doctor", "image": "assets/icons/medical-team.png"},
    {"title": "Baby care", "image": "assets/icons/healthcare.png"},
  ];
  @override
  MediaQueryData? mqData;
  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      /// ______________________App Bar__________________________________///
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.primaryColor,
                          blurRadius: 2,
                          offset: Offset(2.0, 2.2))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset("assets/icons/menu (2).png"),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Vipra Lab",
          style: myTextStyle24(),
        ),
        centerTitle: true,
        shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      backgroundColor: Colors.white,

      /// _________________________DRAWER__________________________///

      drawer: Drawer(
        child: ListView(
          children: [

            /// Drawer Header
            DrawerHeader(
                child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.asset(
                      "assets/images/full body check up.png",
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                Text("Username" ,
                  style: myTextStyle24(fontWeight: FontWeight.bold),)
              ],
            )) ,
            ListTile(
              onTap: (){
                _authService.signOut(context);
              },
              leading: Icon(Icons.logout , color: AppColors.primaryColor, ) ,title: Text("Logout" , style: myTextStyle18(),),)

          ],
        ),
      ),

      ///_____________________BODY__________________________///
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),

            /// Slider Call Here
            const ImageAutoSlider(),

            const SizedBox(
              height: 10,
            ),

            /// Categories Grid
            SizedBox(
              height: mqData!.size.height * 0.39,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cate.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 11,
                      childAspectRatio: 1.4),
                  itemBuilder: (context, index) {
                    return CategoriesCard(
                      title: cate[index]['title'],
                      imagePath: cate[index]['image'],
                    );
                  },
                ),
              ),
            ),

            /// Order a test
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Get tested at your home in",
                              style: myTextStyle18(),
                            ),
                            Text("60 MINUTES",
                                style: myTextStyle36(
                                  fontFamily: "secondary",
                                )),
                            OrderButton(
                              buttonText: 'Order a test',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderTestScreen()));
                              },
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 20,
                          child: Image.asset(
                            "assets/images/3d-map.png",
                            height: 80,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            /// Full body check up
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Full Body Test
                              Text(
                                "Fullbody Checkup",
                                style:
                                    myTextStyle24(fontWeight: FontWeight.w900),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Rs 8372",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        decorationThickness: 2,
                                        fontSize: 21),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.orange.shade300,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "Rs",
                                                style: myTextStyle18(
                                                    fontColor: Colors.white)),
                                            TextSpan(
                                                text: "3499",
                                                style: myTextStyle24(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: "only",
                                                style: myTextStyle18(
                                                    fontColor: Colors.white)),
                                          ]),
                                        ),
                                      ))
                                ],
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              /// 100+ TESTS
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/blood-sample.png",
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "100+ TESTS",
                                    style: myTextStyle18(),
                                  )
                                ],
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              /// report
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/medical-history.png",
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Report in 5 HOURS",
                                    style: myTextStyle18(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              OrderButton(
                                buttonText: 'Book now',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: mqData!.size.height * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/full body check up.png"),
                                    fit: BoxFit.cover)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// Offers
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Offers",
                style: myTextStyle24(fontFamily: 'secondary'),
              ),
            ),

            Column(
              children: [
                /// here we apply
                CarouselSlider.builder(
                    itemCount: offers.length,
                    itemBuilder: (context, index, realIndex) {
                      return offers[index];
                    },
                    options: CarouselOptions(
                        height: mqData!.size.height * 0.5,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 16,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            offerIndex = index;
                          });
                        })),
                const SizedBox(
                  height: 8,
                ),

                /// here we show inductor
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(offers.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 4.0,
                      width: offerIndex == index ? 10 : 4,
                      decoration: BoxDecoration(
                        color:
                            offerIndex == index ? Colors.blue : Colors.black54,
                        borderRadius: BorderRadius.circular(6.8),
                      ),
                    );
                  }),
                )
              ],
            ),

            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

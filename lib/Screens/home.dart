import 'package:demo/Screens/travelcart.dart';
import 'package:demo/auth.dart';
import 'package:demo/utils/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authenicationscreens/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> urls = [
    "https://dh-prod-cdn.azureedge.net/-/media/property/jdv/park-south-hotel/parksouthhotel_reg28941-x-1600/parksouthhotel_reg28941-x-1600-x-760/parksouthhotel_reg28941w1600x760.jpg?ts=a13b22f8-4ae6-4a93-8bc0-5523af86464e.jpeg"
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F475552041875233200%2F&psig=AOvVaw0r5Zp2HbRrqPFYqF5lOrzD&ust=1618410005625000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCLiNqKO1--8CFQAAAAAdAAAAABAT.jpeg"
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fbr.pinterest.com%2Fpin%2F279715826842792178%2F&psig=AOvVaw0r5Zp2HbRrqPFYqF5lOrzD&ust=1618410005625000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCLiNqKO1--8CFQAAAAAdAAAAABAY.jpeg"
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-illustration%2Fhotel-sign-stars-3d-illustration-260nw-195879770.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fhotel&tbnid=LrbT7-lOnsCL1M&vet=12ahUKEwjm7rvetfvvAhVEJLcAHWizCAYQMygQegUIARD0AQ..i&docid=iOfI-XkmKeAR2M&w=392&h=280&q=hotel%20images&ved=2ahUKEwjm7rvetfvvAhVEJLcAHWizCAYQMygQegUIARD0AQ.jpeg"
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F0%2F09%2FMumbai_Aug_2018_%252843397784544%2529.jpg&imgrefurl=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTaj_Mahal_Palace_Hotel&tbnid=bwq-19298fv8mM&vet=12ahUKEwjm7rvetfvvAhVEJLcAHWizCAYQMygfegUIARCYAg..i&docid=AU-I_cmXpDDlFM&w=2000&h=1487&q=hotel%20images&ved=2ahUKEwjm7rvetfvvAhVEJLcAHWizCAYQMygfegUIARCYAg.jpeg"
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fkuzmadesign%2Fhotel-front-desk%2F&psig=AOvVaw0U8fjNgB4vcYEIERFg1yBR&ust=1618411970639000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMDgj8m8--8CFQAAAAAdAAAAABAD.jpeg"
  ];
  String email = FirebaseAuth.instance.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Application'),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app),
              onPressed: (){
            //signout
            AuthClass().signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
             // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // adding text
            Text(
              'Welcome to travel app',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Pick your destination",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // elevation to text field
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Color(0x55434343),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "search for Hotel, Flight.....",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            //table bar
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Color(0xFFFE8C68),
                      unselectedLabelColor: Color(0xFF555555),
                      labelColor: Color(0xFFFE8C68),
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      tabs: [
                        Tab(
                          text: "Trending",
                        ),
                        Tab(
                          text: "Popular",
                        ),
                        Tab(
                          text: "Favorite",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 350.0,
                      child: TabBarView(
                        children: [
                          //tab page
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var trending  in Trending)
                                  Image.asset('assets/$trending.jpg')
                                // travelcart(
                                //     urls[0], "Luxary Hotels", "Hyderabad", 5),
                                // // travelcart(
                                // //     urls[1], "Luxary Hotels", "Hyderabad", 3),
                                // // travelcart(
                                // //     urls[2], "Plaza Hotels", "Hyderabad", 4),
                              ],
                            ),
                          ),
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [],
                            ),
                          ),
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: mydrawer(),
      );
  }
}


final Trending = ['Hyderabad', 'vijayawada', 'vishakapatnam'];
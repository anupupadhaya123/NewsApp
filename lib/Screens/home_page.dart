import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moru_internship/widgets/body_news.dart';
import 'package:moru_internship/widgets/nav_bar_categories.dart';
import 'package:moru_internship/widgets/search_bar.dart';
import 'package:moru_internship/widgets/slideShow_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Importing Search Bar from Widget Page
            SearchBar(),

            // Importing Nav Bar from Widget Page
            NavBarCat(),

            //Making Scrollable slidshow Box
            SliderBox(),

            //Creating body part with Card Widget to show news
            BodyNews(),
          ],
        ),
      ),
    );
  }
}

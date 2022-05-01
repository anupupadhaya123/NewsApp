import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:moru_internship/Screens/news_view.dart';
import 'package:moru_internship/models/models.dart';

class SliderBox extends StatefulWidget {
  const SliderBox({Key? key}) : super(key: key);

  @override
  State<SliderBox> createState() => _SliderBoxState();
}

class _SliderBoxState extends State<SliderBox> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];

  bool isLoading = true;

  getNewsByQuery(String query) async {
    String url =
        "https://newsapi.org/v2/everything?q=nepal&from=2022-04-01&sortBy=publishedAt&apiKey=fbdac451825747af9dc8edec6e43a05f";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  getNewsByProvider(String provider) async {
    String url =
        "https://newsapi.org/v2/everything?q=nepal&from=2022-04-01&sortBy=publishedAt&apiKey=fbdac451825747af9dc8edec6e43a05f";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelListCarousel.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery("nepal");
    getNewsByProvider("onlinekhabar");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: isLoading
            ? Container(
                height: 200, child: Center(child: CircularProgressIndicator()))
            : CarouselSlider(
                items: newsModelListCarousel.map((instance) {
                  return Builder(builder: (BuildContext context) {
                    try {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsView(instance.newsUrl)));
                          } ,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    instance.newsImg,
                                    fit: BoxFit.fitHeight,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    // right: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12.withOpacity(0),
                                                Colors.black
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter)),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Text(
                                              instance.newsHead,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                      return Container();
                    }
                  });
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ));
  }

  final List items = [
    Colors.blueAccent,
    Colors.orange,
    Colors.black,
    Colors.red
  ];
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moru_internship/models/models.dart';

class CategoriesPage extends StatefulWidget {

  String Query;
  CategoriesPage({required this.Query});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];

  bool isLoading = true;

  getNewsByQuery(String query) async {
    String url ="";
    if(query == "Top News" || query == "Nepal"){
       url = "https://newsapi.org/v2/everything?q=breakingnews&from=2022-04-01&sortBy=publishedAt&apiKey=fbdac451825747af9dc8edec6e43a05f";
    }else {
       url = "https://newsapi.org/v2/everything?q=apple&from=2022-04-29&to=2022-04-29&sortBy=popularity&apiKey=fbdac451825747af9dc8edec6e43a05f";
    }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery(widget.Query);
    // getNewsofIndia();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.Query,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? Container(
                height: MediaQuery.of(context).size.height - 450,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  :
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    try{
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(newsModelList[index].newsImg, fit: BoxFit.fitHeight,width: double.infinity,),
                              // child: Image.asset(
                              //   "assets/images/breakingnews.jpg",
                              // )
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black12.withOpacity(0),
                                        Colors.black
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 15, 10,0 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newsModelList[index].newsHead.length > 30 ? "${newsModelList[index].newsHead.substring(0,30)}...." : newsModelList[index].newsHead,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newsModelList[index].newsDes.length > 50 ? "${newsModelList[index].newsDes.substring(0,55)}...." : newsModelList[index].newsDes,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    }catch(e){print(e); return Container();}
                  }),

            ],
          ),
        ),
      )
    );
  }
}

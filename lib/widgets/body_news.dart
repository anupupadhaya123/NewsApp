import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:moru_internship/Screens/news_view.dart';
import 'package:moru_internship/models/models.dart';
import 'package:moru_internship/widgets/categories.dart';

class BodyNews extends StatefulWidget {
  const BodyNews({Key? key}) : super(key: key);

  @override
  State<BodyNews> createState() => _BodyNewsState();
}

class _BodyNewsState extends State<BodyNews> {
  // ApiService client = ApiService();
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];

  bool isLoading = true;

  getNewsByQuery(String query) async {
    Map element;
    int i =0;
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2022-04-29&to=2022-04-29&sortBy=popularity&apiKey=fbdac451825747af9dc8edec6e43a05f";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          i++;

          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(element);
          newsModelList.add(newsQueryModel);
          setState(() {
            isLoading = false;
          });
          // newsModelList.sublist(0,6);
          if (i == 5) {
            break;
          }
        } catch (e) {
          print(e);
        };
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery("corona");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "LATEST NEWS",
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
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    try{
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsView(newsModelList[index].newsUrl)));
                        } ,
                        child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  newsModelList[index].newsImg,
                                  fit: BoxFit.fitHeight,
                                  width: double.infinity,
                                ),
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
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModelList[index].newsHead.length > 30
                                            ? "${newsModelList[index].newsHead.substring(0, 30)}...."
                                            : newsModelList[index].newsHead,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        newsModelList[index].newsDes.length > 50
                                            ? "${newsModelList[index].newsDes.substring(0, 55)}...."
                                            : newsModelList[index].newsDes,
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
                      ),
                    );
                    } catch(e){print(e); return Container();}
                  }),
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(Query: "Extra News")));
                }, child: Text("SHOW MORE"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

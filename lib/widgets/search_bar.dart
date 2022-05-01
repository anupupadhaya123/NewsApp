import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moru_internship/widgets/categories.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {



  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();

    var news_name = ["Political News","Sports News","Entertainments","International News"];
    final _random = new Random();
    var news = news_name[_random.nextInt(news_name.length)];

    return SafeArea(
        child: Container(
        child: Column(
        children: [
        Container( // Search Container(Making search Bar)
        padding: EdgeInsets.symmetric(horizontal: 12),
    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.black12,

    ),
    child: Row(

    children: [
    GestureDetector(
    onTap: () {
    if((searchController.text).replaceAll(" ", "") == ""){
    print("Blank Screen");
    }else{
    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(Query: searchController.text)));

    }
    },
    child: Container(
    margin: EdgeInsets.fromLTRB(4, 0, 7, 0),
    child: Icon(Icons.search, color: Colors.blueAccent,))

    ),
    Expanded(
    child: TextField(
    controller: searchController,
    textInputAction: TextInputAction.search,
    onSubmitted: (value){
      if(value == ""){
        print("Blank Search");
      }else
      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(Query: value)));

    },
    decoration: InputDecoration(
    border: InputBorder.none,
    hintText: "Search $news"
    ),
    ),
    )
    ],
    ),
    )
    ],
    ),
    ));
  }
}

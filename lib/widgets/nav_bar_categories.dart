import 'package:flutter/material.dart';
import 'package:moru_internship/widgets/categories.dart';

class NavBarCat extends StatefulWidget {
  const NavBarCat({Key? key}) : super(key: key);

  @override
  State<NavBarCat> createState() => _NavBarCatState();
}

class _NavBarCatState extends State<NavBarCat> {
  @override
  Widget build(BuildContext context) {
    List<String> navBarItems = ["Top News", "Nepal", "World", "Economy", "Politics"];

    return Container(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        //Making Horizontally scrollable
        scrollDirection: Axis.horizontal,
        itemCount: navBarItems.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(Query: navBarItems[index])));
            } ,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Text(navBarItems[index], style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
          );
        },
      ),
    );
  }
}

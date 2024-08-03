import 'package:flutter/material.dart';
import 'movies.dart';
class Movie {
  String? movie_title;
  String? movie_poster;
  Movie(this.movie_title,this.movie_poster);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Search_Page());
  }
}

class Search_Page extends StatefulWidget {
  const Search_Page({super.key});

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  static List<Movie> movie_list = [
    Movie("BlackLight", "Images/blacklight.webp"),
    Movie("Lupin", "Images/lupin.jpg"),
    Movie("Maze Runner", "Images/mazerunner.webp"),
    Movie("Oneshot", "Images/oneshotsmall.webp")
  ];
  List<Movie> displaylist = List.from(movie_list);
  void filterList(String val) {
    setState(() {
      displaylist = movie_list
          .where((element) =>
              element.movie_title!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              onChanged: (value) {
                filterList(value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: Icon(Icons.close),
                suffixIconColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.white,
                fillColor: Color.fromARGB(166, 73, 68, 68),
                filled: true,
                label: Text("Search for show,movie",
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
              ),
            ),
            const SizedBox(
              height: 30.0,
              child: Text("Top Searches",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displaylist.length,
                itemBuilder: (context, i) => ListTile(
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.play_circle_outline),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                  title: Text(displaylist[i].movie_title!,
                      style: TextStyle(
                        color: Color.fromARGB(166, 73, 68, 68),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  contentPadding: EdgeInsets.all(9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '/Screens/AllMovies.dart';
import '/Screens/mediadetails.dart';
import 'dart:convert';
import 'dart:math';
import '/Data/jsons.dart';
import '/Screens/widgets/MediaRow.dart';
import '/Screens/widgets/buttomnavig.dart';
import '/models/genre_mapping.dart';
import '/models/media.dart';
import '/models/movie.dart';
import '/models/tvshows.dart';
import 'AllTVShows.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Movie> movies = List<Movie>.from(
    jsonDecode(jsonString)['results']
        .map((json) => Movie.fromJson(json, genreMapping)),
  );

  final List<TVShow> tv = List<TVShow>.from(
    jsonDecode(jsonStringtv)['results']
        .map((json) => TVShow.fromJson(json, genreMapping)),
  );

  final List<TVShow> popular = List<TVShow>.from(
    jsonDecode(jsonStringtvpop)['results']
        .map((json) => TVShow.fromJson(json, genreMapping)),
  );

  final random = Random();
  var randomPoster;
  List<dynamic>? myList = [];

  void addToList(Media x) {
    setState(() {
      myList?.add(x);
    });
  }

  @override
  void initState() {
    super.initState();
    List<dynamic> combinedList = []
      ..addAll(movies)
      ..addAll(tv)
      ..addAll(popular);
    randomPoster = combinedList[random.nextInt(combinedList.length)];
  }

  void addOrRemoveFromList(BuildContext context, Media X) {
    String content;

    if (myList!.contains(X)) {
      myList?.remove(X);
      content = "${X.title} was removed";
    } else {
      myList?.add(X);
      content = "${X.title} was added";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _currentIndex = 0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaDetails(
                            media: randomPoster,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${randomPoster.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              randomPoster.genreNames.join(' • '),
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  addOrRemoveFromList(context, randomPoster);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(width: 1),
                                    Text(
                                      "My List",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Netflixsmall",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Colors.white,
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                    SizedBox(width: 1),
                                    Text(
                                      "Play",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Netflixsmall",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MediaDetails(
                                        media: randomPoster,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(width: 1),
                                    Text(
                                      "Info",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Netflixsmall",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        AppBar(
                          leading: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(height: 55, "images/netflixicon.png")
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          toolbarHeight: 80,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.search_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AllMoviesItems();
                                  },
                                ));
                              },
                              child: Text(
                                "Movies",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AllTvItems();
                                  },
                                ));
                              },
                              child: Text(
                                "Tv Shows",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Categories",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MediaSection(
                  title: "Popular TV Shows",
                  media: popular,
                  addToList: addToList),
              MediaSection(
                  title: "Top TV Shows", media: tv, addToList: addToList),
              MediaSection(
                  title: "Movies", media: movies, addToList: addToList),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        myList: myList ?? [],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '/models/media.dart';
import '/models/movie.dart';
import '/models/tvshows.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<dynamic>? mediaList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the media list from route arguments
    mediaList = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
  }

  void addOrRemoveFromList(BuildContext context, Media media) {
    String content;

    if (mediaList!.contains(media)) {
      mediaList!.remove(media);
      content = "${media.title} was removed";
    } else {
      mediaList!.add(media);
      content = "${media.title} was added";
    }

    setState(() {});

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'My List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: mediaList == null || mediaList!.isEmpty
          ? Center(
              child: Text(
              'Your List is Empty',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ))
          : ListView.builder(
              itemCount: mediaList!.length,
              itemBuilder: (context, index) {
                final media = mediaList![index];
                String title;

                if (media is Movie) {
                  title = media.title;
                } else if (media is TVShow) {
                  title = media.title;
                } else {
                  title = 'Unknown';
                }

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    color: Colors.black,
                    elevation: 4, // Optional, adds shadow for better visual
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${media.posterPath}',
                            fit: BoxFit.cover,
                            width: 100, // Fixed width for image
                            height: 150, // Fixed height for image
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  media.overview,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => addOrRemoveFromList(context, media),
                          icon:
                              Icon(Icons.playlist_remove, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

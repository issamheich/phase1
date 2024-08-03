import 'package:flutter/material.dart';
import '/models/media.dart';
import '/models/movie.dart';
import '/models/tvshows.dart';

class MediaDetails extends StatelessWidget {
  final Media media;

  MediaDetails({required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(''),
              background: media.backdropPath.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${media.backdropPath}',
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey,
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              media.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              media is Movie
                                  ? (media as Movie).releaseDate
                                  : (media as TVShow).firstAirDate,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              media.overview,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.play_arrow),
                          label: Text('Play'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.download, color: Colors.white),
                            onPressed: () {},
                          ),
                          Text("Download",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.slow_motion_video,
                                color: Colors.white),
                            onPressed: () {},
                          ),
                          Text("Preview", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaDetails(media: media),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Details & More',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.info_outline, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

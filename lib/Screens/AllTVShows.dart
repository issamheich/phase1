import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AllTvItems(),
    );
  }
}

class AllTvItems extends StatefulWidget {
  const AllTvItems({super.key});

  @override
  State<AllTvItems> createState() => _AllTvItemsState();
}

class _AllTvItemsState extends State<AllTvItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Popular TV Shows',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<TvItem>>(
        future: loadTvShows(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No TV shows found.'));
          } else {
            final tvShows = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: tvShows.length,
              itemBuilder: (context, index) {
                final tvShow = tvShows[index];
                return GestureDetector(
                  onTap: () => _showTvDetails(context, tvShow),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showTvDetails(BuildContext context, TvItem tvShow) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            color: Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvShow.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            tvShow.firstAirDate ?? 'N/A',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            tvShow.overview ?? 'No overview available.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
                        Text("Download", style: TextStyle(color: Colors.white))
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
                        builder: (context) => TvDetailsPage(tvShow: tvShow),
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
        );
      },
    );
  }
}

class TvDetailsPage extends StatelessWidget {
  final TvItem tvShow;

  const TvDetailsPage({Key? key, required this.tvShow}) : super(key: key);

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
              background: Image.network(
                'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tvShow.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('2024 | HD | 1h 37m | ★ 7.649',
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              size: 30,
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Play',
                              style: TextStyle(
                                fontFamily: 'netflix',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Download',
                              style: TextStyle(
                                fontFamily: 'netflix',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(tvShow.overview ?? 'No overview available.',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildIconButton(Icons.add, 'My List'),
                          SizedBox(
                            width: 10,
                          ),
                          _buildIconButton(Icons.thumb_up_off_alt, 'Rate'),
                          SizedBox(
                            width: 10,
                          ),
                          _buildIconButton(Icons.share, 'Share'),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('MORE LIKE THIS',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

Future<List<TvItem>> loadTvShows() async {
  final jsonString = await rootBundle.loadString('assets/tvshows.json');
  final jsonResponse = json.decode(jsonString) as List<dynamic>;
  return jsonResponse.map((item) => TvItem.fromJson(item)).toList();
}

class TvItem {
  final String name;
  final String? firstAirDate;
  final String? overview;
  final String posterPath;

  TvItem({
    required this.name,
    this.firstAirDate,
    this.overview,
    required this.posterPath,
  });

  factory TvItem.fromJson(Map<String, dynamic> json) {
    return TvItem(
      name: json['name'] ?? 'No name',
      firstAirDate: json['first_air_date'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
    );
  }
}

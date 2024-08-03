import 'package:flutter/material.dart';
import '/Screens/mediadetails.dart';

class MediaSection extends StatelessWidget {
  final String title;
  final List<dynamic> media;
  final Function addToList;

  const MediaSection({
    Key? key,
    required this.title,
    required this.media,
    required this.addToList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 224,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: media.length,
              itemBuilder: (context, index) {
                final item = media[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaDetails(media: item),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    child: Column(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w200${item.posterPath}',
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 5),
                        Text(
                          item.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

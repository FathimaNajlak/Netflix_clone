import 'package:clone_netflix/common/utils.dart';
import 'package:clone_netflix/models/movie_model.dart';
import 'package:clone_netflix/screens/movie_detailed_screen.dart';
import 'package:flutter/material.dart';

class UpcomingMovieCard extends StatelessWidget {
  final Future<MovieModel> future;

  final String headlineText;
  const UpcomingMovieCard({
    super.key,
    required this.future,
    required this.headlineText,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headlineText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // padding: const EdgeInsets.all(3),
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      movieId: data[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.network(
                                  '$imageUrl${data[index].posterPath}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ));
                      },
                    ),
                  )
                ]);
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

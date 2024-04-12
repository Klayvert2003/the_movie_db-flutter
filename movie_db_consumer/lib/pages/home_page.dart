import 'package:flutter/material.dart';
import 'package:movie_db_consumer/pages/movie_detail.dart';
import 'package:movie_db_consumer/repositories/movie_repository_impl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TheMovieDB'),
      ),
      body: FutureBuilder(
          future: context.read<MovieRepositoryImpl>().getUpcoming(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            var data = snapshot.data;

            return GridView.builder(
                itemCount: data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RateMovie(movieObj: data![index])),
                      );
                    },
                    child: FadeInImage(
                      fadeInCurve: Curves.bounceInOut,
                      fadeInDuration: const Duration(milliseconds: 500),
                      image: NetworkImage(data![index].getPostPathUrl()),
                      placeholder:
                          const AssetImage('assets/images/loading.gif'),
                    ),
                  );
                });
          }),
    );
  }
}

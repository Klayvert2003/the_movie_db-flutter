import 'package:flutter/material.dart';
import 'package:movie_db_consumer/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../repositories/movie_repository_impl.dart';

class RateMovie extends StatefulWidget {
  const RateMovie({super.key, required this.movieObj});

  final movieObj;

  @override
  _RateMovieState createState() => _RateMovieState();
}

class _RateMovieState extends State<RateMovie> {
  final TextEditingController _ratingController = TextEditingController();

  @override
  void dispose() {
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movieObj.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeInImage(
                  image: NetworkImage(widget.movieObj.getPostPathUrl()),
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  fit: BoxFit.cover,
                ),
                _buildInfoItem(
                  Icons.star,
                  Colors.yellowAccent,
                  'Avaliações:',
                  widget.movieObj.popularity,
                ),
                _buildInfoItem(
                  Icons.emoji_emotions,
                  Colors.green,
                  'Média de Avaliação:',
                  widget.movieObj.voteAverage,
                ),
                _buildInfoItem(
                  Icons.assessment,
                  Colors.blue,
                  'Contagem de avaliações:',
                  widget.movieObj.voteCount,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _ratingController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Avalie o filme de 0 a 10',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60.0,
                    right: 60.0,
                    top: 0.0,
                    bottom: 12.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_ratingController.text != '') {
                        double rateNumber =
                            double.parse(_ratingController.text);
                        if (rateNumber > 10 || rateNumber < 0) {
                          showSnackBar(context, 'Insira um número de 0 a 10!');
                        } else {
                          context.read<MovieRepositoryImpl>().addRating(
                              widget.movieObj.id.toString(), rateNumber);
                          showSnackBar(
                              context, 'Avaliação enviada com sucesso!');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      } else {
                        showSnackBar(
                            context, 'Insira a avaliação antes de enviar!');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Enviar avaliação',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget _buildInfoItem(
    IconData iconData, Color iconColor, String title, dynamic value) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
        ),
        const SizedBox(width: 8),
        Text(
          '$title $value',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}

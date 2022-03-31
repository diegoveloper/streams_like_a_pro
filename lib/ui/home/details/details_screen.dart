import 'package:flutter/material.dart';
import 'package:streams_like_a_pro/domain/city.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  final City city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Hero(
                tag: city.image,
                child: Image.network(
                  city.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(city.description),
          ],
        ),
      ),
    );
  }
}

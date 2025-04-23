import 'package:flutter/material.dart';
import 'package:news_app_it_sharks/model/news_model.dart';

class NewsWidget extends StatelessWidget {
  final Articles article;
  const NewsWidget({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(article.title ?? "[Removed]"),
            const SizedBox(height: 10.0,),
            Text(article.description ?? "[Removed]"),
            const SizedBox(height: 10.0,),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                article.urlToImage ??"https://www.wifr.com/resizer/r71NV61kB7WocjwEPKuxQ9ykxJM=/arc-photo-gray/arc3-prod/public/GZXYVYBQSBAYNO5QVFA3QVRUOE.jpg",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10.0,),
            Text(article.author ??"[Author]"),
          ],
        ),
      ),
    );
  }
}

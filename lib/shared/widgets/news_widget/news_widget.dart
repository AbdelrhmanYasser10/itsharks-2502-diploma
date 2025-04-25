import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_it_sharks/model/news_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsWidget extends StatelessWidget {
  final Articles article;
  const NewsWidget({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        await launchUrlString(article.url!);
        print("hello");
      },
      child: Card(

        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(article.title ?? "[Removed]",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(article.description ?? "[Removed]",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),),
              const SizedBox(height: 10.0,),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl:article.urlToImage ??"https://www.wifr.com/resizer/r71NV61kB7WocjwEPKuxQ9ykxJM=/arc-photo-gray/arc3-prod/public/GZXYVYBQSBAYNO5QVFA3QVRUOE.jpg",

                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: LoadingAnimationWidget.inkDrop(
                              color: Colors.black,
                              size: 50
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) =>const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(article.author ??"[Author]",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),),
            ],
          ),
        ),
      ),
    );
  }
}

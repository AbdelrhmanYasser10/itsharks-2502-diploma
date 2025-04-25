import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_it_sharks/model/news_model.dart';
import 'package:news_app_it_sharks/screens/results_screen.dart';
import 'package:news_app_it_sharks/shared/cubit/news_cubit/news_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_it_sharks/shared/cubit/sources_cubit/sources_cubit.dart';

import '../shared/widgets/error_widget/error_widget.dart';
import '../shared/widgets/loading_widget/loading_widget.dart';
import '../shared/widgets/news_widget/news_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Breaking News"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          if(state is GetHomeDataLoading){
            return const LoadingWidget();
          }
          else if(state is GetHomeDataWithError){
            return MyErrorWidget(
              animationPath: 'assets/animation/Animation - 1745434638471.json',
              message: state.message,
              reloadMethod: () {
                NewsCubit.get(context).getHomeData();
              },
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: buildSliderItems(
                      articles: cubit.homeNews!.articles!,
                    ),
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {

                      },
                      scrollDirection: Axis.horizontal,
                    )
                ),
                const SizedBox(height: 10.0,),
                BlocConsumer<SourcesCubit,SourcesState>
                  ( listener: (context, state) {

                  },
                  builder: (context, state) {
                    if(state is GetSourcesDataLoading){
                      return const LoadingWidget();
                    }
                    else if(state is GetSourcesDataWithError){
                      return const SizedBox.shrink();
                    }
                    else{
                      var cubit = SourcesCubit.get(context);
                      return SizedBox(
                        height: 45,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  NewsCubit.get(context).getResultsNews(key: cubit.allSources!.sources![index].id!,filter:2);

                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultsScreen(title: cubit.allSources!.sources![index].name!)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 20.0
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.black,
                                  ),
                                  child: Text(
                                      cubit.allSources!.sources![index].name!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
                          itemCount: cubit.allSources!.sources!.length,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10.0,),

                const Text(
                  "Popular Now",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0,),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index){
                          return NewsWidget(article:cubit.homeNews!.articles![index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
                        itemCount: cubit.homeNews!.articles!.length,
                    ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildSliderItems({required List<Articles> articles}){
    List<Widget> allSliderItems = [];

    // forLoop
    if(articles.length <= 5){
      for(var element in articles){
        allSliderItems.add(buildSliderCard(article: element));
      }
    }
    else{
      for(int i = 0 ; i < 5 ; i++){
        allSliderItems.add(buildSliderCard(article: articles[i]));

      }
    }
    return allSliderItems;
  }

  Widget buildSliderCard({required Articles article}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:CachedNetworkImage(
              imageUrl:article.urlToImage ??"https://www.wifr.com/resizer/r71NV61kB7WocjwEPKuxQ9ykxJM=/arc-photo-gray/arc3-prod/public/GZXYVYBQSBAYNO5QVFA3QVRUOE.jpg",
            fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Colors.black,
                      size: 50
                    ),
                  ),
              errorWidget: (context, url, error) =>const Icon(Icons.error),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: const LinearGradient(
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                article.title ?? "[Removed]",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                article.description??"[Removed]",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                article.source?.name??"[Removed]",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}




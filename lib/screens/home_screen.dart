import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_it_sharks/shared/cubit/news_cubit/news_cubit.dart';
import 'package:lottie/lottie.dart';

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
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          else if(state is GetHomeDataWithError){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                      'assets/animation/Animation - 1745434638471.json',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    state.message,
                    style:const TextStyle(
                      fontSize:18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      NewsCubit.get(context).getHomeData();
                    },
                    child: const Text(
                    "Reload",
                    style:const TextStyle(
                      fontSize:18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: [
                      buildSliderCard(),
                    ],
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
                Text(
                  "Popular Now",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

  Widget buildSliderCard() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://www.wifr.com/resizer/r71NV61kB7WocjwEPKuxQ9ykxJM=/arc-photo-gray/arc3-prod/public/GZXYVYBQSBAYNO5QVFA3QVRUOE.jpg",
              fit: BoxFit.cover,
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
                "Title",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Source",
                style: TextStyle(
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


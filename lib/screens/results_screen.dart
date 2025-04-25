import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_it_sharks/shared/cubit/news_cubit/news_cubit.dart';

import '../shared/widgets/error_widget/error_widget.dart';
import '../shared/widgets/loading_widget/loading_widget.dart';
import '../shared/widgets/news_widget/news_widget.dart';


class ResultsScreen extends StatelessWidget {
  final String title;
  const ResultsScreen({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<NewsCubit,NewsState>
        (
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is GetResultsLoading){
            return const LoadingWidget();
          }
          else if(state is GetResultsWithError){
            return MyErrorWidget(
              animationPath: 'assets/animation/Animation - 1745434638471.json',
              message: state.message,
              reloadMethod: () {
                NewsCubit.get(context).getResultsNews(key: title.toLowerCase());
              },
            );
          }
          else{
            var cubit = NewsCubit.get(context);
            if(cubit.resultsNews!.articles!.isEmpty){
              return MyErrorWidget(
                animationPath: 'assets/animation/Animation - 1745570313531.json',
                message: "There's no news today, try again later",
                reloadMethod: () {
                  NewsCubit.get(context).getResultsNews(key: title.toLowerCase());
                },
              );
            }
            else{
              return ListView.separated(
                itemBuilder: (context,index){
                  return NewsWidget(article:cubit.resultsNews!.articles![index]);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
                itemCount: cubit.resultsNews!.articles!.length,
              );
            }
          }
        },
      ),
    );
  }
}

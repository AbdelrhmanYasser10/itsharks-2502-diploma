import 'package:flutter/material.dart';
import 'package:news_app_it_sharks/model/category_item.dart';
import 'package:news_app_it_sharks/screens/results_screen.dart';
import 'package:news_app_it_sharks/shared/cubit/news_cubit/news_cubit.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryItem> items = [
    CategoryItem(icon: Icons.biotech, title: "Technology"),
    CategoryItem(icon: Icons.person_4, title: "Business"),
    CategoryItem(icon: Icons.sports_baseball, title: "Sports"),
    CategoryItem(icon: Icons.health_and_safety, title: "Health"),
    CategoryItem(icon: Icons.science, title: "Science"),
    CategoryItem(icon: Icons.personal_video, title: "Entertainment"),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,

              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    NewsCubit.get(context).getResultsNews(key: items[index].title.toLowerCase());
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultsScreen(title: items[index].title)));
                  },
                  child: buildCategoryCard(
                     title: items[index].title,
                    icon:items[index].icon,

                  ),
                );
              },
              itemCount: 6,
          ),
        ),
      ),
    );
  }

  Card buildCategoryCard({
  required IconData icon,
    required String  title,
}) {
    return Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 72,
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    )
                  ],
                ),
              );
  }
}

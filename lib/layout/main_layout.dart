import 'package:flutter/material.dart';
import 'package:news_app_it_sharks/screens/category_screen.dart';
import 'package:news_app_it_sharks/screens/home_screen.dart';
import 'package:news_app_it_sharks/screens/search_screen.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    CategoryScreen(),
    SearchScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
          elevation: 0,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
              label: "Categories"
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
              label: "Seach"
            ),
          ] ,
      ),
      body: screens[currentIndex],
    );
  }
}

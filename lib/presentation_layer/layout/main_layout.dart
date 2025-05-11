import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../chats_screen/chats_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../shared/styles/colors/app_colors.dart';
import '../shared/styles/text_styles/text_styles.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int activeIdx = 0;

  List<Widget> screens = const [
   ChatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat App",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.signOut,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIdx,
        onTap: (value) {
          setState(() {
            activeIdx = value;
          });
        },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              FontAwesomeIcons.message,
              ),
              label: "Chats"
            ),
            BottomNavigationBarItem(
                icon: Icon(
              FontAwesomeIcons.person,
              ),
              label: "Profile"
            ),
          ],
      ),
      body: screens[activeIdx],
    );
  }
}
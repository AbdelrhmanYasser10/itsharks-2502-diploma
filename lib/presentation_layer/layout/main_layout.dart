import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../generated/l10n.dart';
import '../chats_screen/chats_screen.dart';
import '../profile_screen/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

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
        title:  Text(
          S.of(context).chat_app_txt,
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
          items:  [
            BottomNavigationBarItem(
                icon: const Icon(
              FontAwesomeIcons.message,
              ),
              label: S.of(context).chat_txt
            ),
            BottomNavigationBarItem(
                icon: const Icon(
              FontAwesomeIcons.person,
              ),
              label: S.of(context).profile_txt
            ),
          ],
      ),
      body: screens[activeIdx],
    );
  }
}
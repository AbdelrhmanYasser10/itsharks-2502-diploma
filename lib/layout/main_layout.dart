import 'package:e_commerce_it_sharks/screen/categories_screen.dart';
import 'package:e_commerce_it_sharks/screen/favourites_screen.dart';
import 'package:e_commerce_it_sharks/screen/home_screen.dart';
import 'package:e_commerce_it_sharks/screen/profile_screen.dart';
import 'package:e_commerce_it_sharks/shared/styles/colors.dart';
import 'package:e_commerce_it_sharks/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int activeIdx = 0;

  List<Widget> screens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        title: Text(
          "E-Nile",
          style: AppTextStyles.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.bell,
              ),
          ),
          InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                  "assets/icons/cart-trolley-shop-svgrepo-com.svg",
                width: 40.0,
                height: 40.0,
              ),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        tabMargin:  const EdgeInsets.all(2.0),
        tabBorderRadius: 6,
          textStyle: AppTextStyles.infoTextStyle.copyWith(
            color: AppColors.kPrimaryColor,
          ),
          onTabChange: (value) {
            setState(() {
              activeIdx = value;
            });
          },
          haptic: true, // haptic feedback
          curve: Curves.easeIn, // tab animation curves
          duration:const Duration(milliseconds: 400), // tab animation duration
          gap: 5, // the tab button gap between icon and text
          activeColor: AppColors.kPrimaryColor, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: AppColors.kPrimaryColor.withOpacity(0.1), // selected tab background color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',

            ),
            GButton(
              icon: LineIcons.shoppingBag,
              text: 'Categories',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Favourites',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ]
      ),
      body: screens[activeIdx],
    );
  }
}

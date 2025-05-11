import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_itsharks_25/logic_layer/settings_cubit/settings_cubit.dart';
import 'package:chat_app_itsharks_25/presentation_layer/authentication/login/login_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../logic_layer/app_cubit/app_cubit.dart';
import '../shared/styles/colors/app_colors.dart';
import '../shared/widgets/loading_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  final List<String> items = [
    'English',
    'العربية',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    var isDark = SettingsCubit.get(context).isDark;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if (state is GetUserDataLoading || cubit.user == null) {
          return const LoadingWidget();
        } else if (state is GetUserDataError) {
          return const SizedBox();
        }
        /*if(SharedPreferencesHelper.getData(key: TOKEN) == null){}*/
        return BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundColor: AppColors.kPrimaryColor,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundImage: CachedNetworkImageProvider(
                          cubit.user!.imageUrl,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      cubit.user!.username,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      cubit.user!.email,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Settings",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Card(
                            color: isDark? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.moon,
                                color: isDark? Colors.white : Colors.black,
                              ),
                              title: Text(
                                "Dark theme",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing:
                              Switch(
                                value: isDark,
                                onChanged: (value) {
                                  SettingsCubit.get(context).changeTheme();
                                },
                                inactiveThumbColor: Colors.white,
                                activeColor: AppColors.kPrimaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Card(
                            color: isDark? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading:  Icon(
                                FontAwesomeIcons.language,
                                color: isDark? Colors.white : Colors.black,
                              ),
                              title:  Text(
                                "Language",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  hint: Text(
                                    selectedValue ?? "English",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: isDark? Colors.black : Colors.white,
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Options",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          buildOptionCard(
                            title: "Edit Profile",
                            onPressed: () {},
                            isDark: isDark,
                            icon: FontAwesomeIcons.penToSquare,
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          buildOptionCard(
                            title: "Log Out",
                            onPressed: () async{
                              await FirebaseAuth.instance.signOut();
                              AppCubit.get(context).user = null;
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                            },
                            isDark: isDark,
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GestureDetector buildOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: isDark? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 2,
        child: ListTile(
          leading: Icon(
            icon,
            color: isDark? Colors.white : Colors.black,

          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

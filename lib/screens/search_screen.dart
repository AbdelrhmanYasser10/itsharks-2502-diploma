import 'package:flutter/material.dart';
import 'package:news_app_it_sharks/screens/results_screen.dart';

import '../shared/cubit/news_cubit/news_cubit.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      "News App",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Search for specific topic",
                    ),
                  ],
                ),
                TextFormField(
                  controller: _controller,
                  cursorColor: Colors.black,
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "You must enter a valid title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Type here....",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1
                      )
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        NewsCubit.get(context).getResultsNews(key: _controller.text,filter:1);

                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultsScreen(title: _controller.text)));

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:const  Size(double.infinity,55),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

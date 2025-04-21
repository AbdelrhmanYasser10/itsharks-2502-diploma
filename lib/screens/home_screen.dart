import 'package:api_posts_app_it_sharks/models/posts_model.dart';
import 'package:api_posts_app_it_sharks/shared/cubits/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is PostsLoading){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          else if(state is PostsError){
            return const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 32.0,
                  ),
                   SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Error while getting posts, try again later",
                  )
                ],
              ),
            );
          }
          else {
            var cubit = PostsCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemBuilder: (context, index) => buildPostCard(
                  model: cubit.allPosts!.posts![index]
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                itemCount: cubit.allPosts!.posts!.length,
              ),
            );
          }
        },
      ),
    );
  }

  Card buildPostCard({
    required Posts model,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 26.0,
                  backgroundColor: Colors.purple,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      "https://icons.veryicon.com/png/o/system/ali-mom-icon-library/random-user.png",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                    "User NO.${model.userId}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0,),
                Center(
                  child: Text(
                    "${model.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(
                    "${model.body}",
                  // JUSTIFY
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10.0,),

              ],
            ),
           const  Divider(),
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: 5.0,),
                      itemBuilder: (context, index) => Text(
                        model.tags![index],
                        style:  const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      itemCount: model.tags!.length,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite_outline,
                            ),
                            Text(
                              "${model.reactions!.likes}",
                              style:  const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.disabled_by_default,
                            ),
                            Text(
                              "${model.reactions!.dislikes}",
                              style:  const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

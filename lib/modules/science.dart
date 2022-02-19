import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/news_cubit/news_cubit.dart';
import 'package:news_app_flutter/shared/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
      return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return (() {
                var newsCubit = NewsCubit.get(context);
                if (newsCubit.scienceNews.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return buildArticleItem(
                        imageUrl: newsCubit.scienceNews['articles'][index]
                            ['urlToImage'],
                        date: newsCubit.scienceNews['articles'][index]
                            ['publishedAt'],
                        title: newsCubit.scienceNews['articles'][index]
                            ['title'],
                        context: context,
                        url: newsCubit.scienceNews['articles'][index]['url'],
                      );
                    },
                    itemCount: newsCubit.scienceNews['articles'].length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.grey[400],
                      );
                    },
                  );
                }
              }());
            },
          );
        },
      );
    });
  }
}

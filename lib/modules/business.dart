import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/news_cubit/news_cubit.dart';
import 'package:news_app_flutter/shared/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return (() {
              var newsCubit = NewsCubit.get(context);
              if (newsCubit.businessNews.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return buildArticleItem(
                      imageUrl: newsCubit.businessNews['articles'][index]
                          ['urlToImage'],
                      date: newsCubit.businessNews['articles'][index]
                          ['publishedAt'],
                      title: newsCubit.businessNews['articles'][index]['title'],
                      context: context,
                      url: newsCubit.businessNews['articles'][index]['url'],
                    );
                  },
                  itemCount: newsCubit.businessNews['articles'].length,
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
  }
}

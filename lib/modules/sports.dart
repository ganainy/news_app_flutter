import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/news_cubit/news_cubit.dart';
import 'package:news_app_flutter/shared/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

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
              if (state is SportsSuccessState) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return buildArticleItem(
                        imageUrl: newsCubit.sportsNews['articles'][index]
                            ['urlToImage'],
                        date: newsCubit.sportsNews['articles'][index]
                            ['publishedAt'],
                        title: newsCubit.sportsNews['articles'][index]
                            ['title']);
                  },
                  itemCount: newsCubit.sportsNews['articles'].length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: Colors.grey[400],
                    );
                  },
                );
              } else if (state is SportsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SportsErrorState) {
                return const Center(child: Text('Error loading news'));
              } else {
                //this shouldn't execute
                throw Exception('unknown state');
              } // your code here
            }());
          },
        );
      },
    );
  }
}

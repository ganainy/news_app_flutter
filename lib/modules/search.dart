import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/search_cubit/search_cubit.dart';
import 'package:news_app_flutter/shared/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          print('Searchcubit current state: ${state.toString()}');
        },
        builder: (context, state) {
          var searchCubit = SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('News App'),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultFormField('Search keyword', searchController,
                        prefixIcon: Icon(Icons.search), onFieldChanged: (text) {
                      searchCubit.getNews(q: text);
                    }, validator: (value) {
                      if (value.isNotEmpty) {
                        return null;
                      } else {
                        return 'Search should contain at least 1 character';
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (() {
                    if (searchCubit.state is SearchInitial) {
                      return const Expanded(
                        child: Center(
                            child: Text('Type something to start search')),
                      );
                    } else if (searchCubit.state is SearchSuccessState) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return buildArticleItem(
                              imageUrl: searchCubit.news['articles'][index]
                                  ['urlToImage'],
                              date: searchCubit.news['articles'][index]
                                  ['publishedAt'],
                              title: searchCubit.news['articles'][index]
                                  ['title'],
                              context: context,
                              url: searchCubit.news['articles'][index]['url'],
                            );
                          },
                          itemCount: searchCubit.news['articles'] == null
                              ? 0
                              : searchCubit.news['articles'].length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 1,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.grey[400],
                            );
                          },
                        ),
                      );
                    } else if (searchCubit.state is SearchLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (searchCubit.state is SearchErrorState) {
                      return const Expanded(
                        child: Center(child: Text('Something went wrong')),
                      );
                    } else {
                      throw Exception('unknown search state');
                    }
                  }())
                ],
              ));
        },
      ),
    );
  }
}

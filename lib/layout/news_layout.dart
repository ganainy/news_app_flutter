import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/news_cubit/news_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var newsCubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    //todo
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    newsCubit.switchTheme();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: newsCubit.botNavItems,
            currentIndex: newsCubit.botNavCurrentIndex,
            onTap: (index) => newsCubit.changeBotNavIndex(index),
          ),
          body: newsCubit.botNavScreens[newsCubit.botNavCurrentIndex],
        );
      },
    );
  }
}

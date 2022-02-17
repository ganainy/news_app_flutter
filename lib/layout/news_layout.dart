import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/news_cubit/news_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //create the cubit then call getBusinessNews on the created object
      create: (context) => NewsCubit()..getBusinessNews(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var newsCubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    onPressed: () {
                      newsCubit.getBusinessNews();
                    },
                    icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
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
      ),
    );
  }
}

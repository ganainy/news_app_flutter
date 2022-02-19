import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/modules/business.dart';
import 'package:news_app_flutter/modules/science.dart';
import 'package:news_app_flutter/modules/sports.dart';
import 'package:news_app_flutter/network/cache_helper.dart';
import 'package:news_app_flutter/network/dio_helper.dart';
import 'package:news_app_flutter/shared/constants.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  List<BottomNavigationBarItem> botNavItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> botNavScreens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen()
  ];

  changeBotNavIndex(int index) {
    botNavCurrentIndex = index;
    emit(NewsBotNavState());
    //load the news of category based on the selected bottom nav
    switch (index) {
      case 0:
        {
          getBusinessNews();
          break;
        }

      case 1:
        {
          getSportsNews();
          break;
        }

      case 2:
        {
          getScienceNews();
          break;
        }
    }
  }

  Map<String, dynamic> businessNews = {};
  Map<String, dynamic> sportsNews = {};
  Map<String, dynamic> scienceNews = {};

  void getBusinessNews() {
    //if there is already news don't load again
    if (businessNews.isEmpty) {
      emit(BusinessLoadingState());
      DioHelper.getDataByCategory(queryParams: {
        'country': 'de',
        'category': 'business',
        'apiKey': Constants.API_KEY,
      }).then((value) {
        businessNews = value.data;
        emit(BusinessSuccessState());
      }).catchError((error) {
        emit(BusinessErrorState());
      });
    } else {
      emit(BusinessSuccessState());
    }
  }

  void getSportsNews() {
    //if there is already news don't load again
    if (sportsNews.isEmpty) {
      emit(SportsLoadingState());
      DioHelper.getDataByCategory(queryParams: {
        'country': 'de',
        'category': 'sports',
        'apiKey': Constants.API_KEY,
      }).then((value) {
        sportsNews = value.data;
        emit(SportsSuccessState());
      }).catchError((error) {
        emit(SportsErrorState());
      });
    } else {
      emit(SportsSuccessState());
    }
  }

  void getScienceNews() {
    //if there is already news don't load again
    if (scienceNews.isEmpty) {
      emit(ScienceLoadingState());
      DioHelper.getDataByCategory(queryParams: {
        'country': 'de',
        'category': 'science',
        'apiKey': Constants.API_KEY,
      }).then((value) {
        scienceNews = value.data;
        emit(ScienceSuccessState());
      }).catchError((error) {
        emit(ScienceErrorState());
      });
    } else {
      emit(ScienceSuccessState());
    }
  }

  bool isDarkTheme = false;
  //switch between dark and light app theme
  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    CacheHelper.setBool(key: 'isDark', value: isDarkTheme);
    emit(SwitchAppThemeState());
  }

  getAppTheme() {
    CacheHelper.getBool(key: 'isDark').then((value) {
      isDarkTheme = value ?? isDarkTheme;
      print('getapptheme${isDarkTheme}');
      emit(SwitchAppThemeState());
    });
  }
}

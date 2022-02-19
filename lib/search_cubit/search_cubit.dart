import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_flutter/network/dio_helper.dart';
import 'package:news_app_flutter/shared/constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> news = {};

  void getNews({required String q}) {
    //if there is already news don't load again

    emit(SearchLoadingState());
    DioHelper.getDataBySearch(queryParams: {
      'q': q,
      'apiKey': Constants.API_KEY,
    }).then((value) {
      news = value.data;
      print(news);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}

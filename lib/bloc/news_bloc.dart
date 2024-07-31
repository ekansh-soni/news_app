import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Utils/strings.dart';
import '../ApiUtils/api_service.dart';
import '../model/news_model.dart';


class NewsModelBloc extends Bloc<NewsModelEvent, NewsModelState> {
  NewsModelRepository repository;

  NewsModelBloc({required this.repository}) : super(NewsModelInitialState()) {
    on<FetchNewsModelsEvent>((event, emit) async {
      emit(NewsModelInitialState());
      try {
        NewsViewModel newsModels =
        await repository.getNewsModel();
        if (newsModels.status == "ok") {
            emit(NewsModelLoadedState(NewsModels: newsModels));
        }else {
          emit(NewsModelErrorState(message: AppConstants.noDataError));
        }
      } catch (e) {
        emit(NewsModelErrorState(message: e.toString()));
      }
    });
  }
}

abstract class NewsModelEvent extends Equatable {}

class FetchNewsModelsEvent extends NewsModelEvent {

  FetchNewsModelsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

abstract class NewsModelState extends Equatable {}

class NewsModelInitialState extends NewsModelState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsModelLoadingState extends NewsModelState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsModelLoadedState extends NewsModelState {
  final NewsViewModel NewsModels;

  NewsModelLoadedState({required this.NewsModels});

  @override
  // TODO: implement props
  List<Object> get props => [NewsModels];
}

class NewsModelErrorState extends NewsModelState {
  final String message;

  NewsModelErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class NewsModelCloseState extends NewsModelState {
  final String message;

  NewsModelCloseState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

abstract class NewsModelRepository {
  Future<NewsViewModel> getNewsModel();
}

class NewsModelRepositoryImpl implements NewsModelRepository {
  @override
  Future<NewsViewModel> getNewsModel() async {

    final Response response = await ApiService().get(
      AppConstants.baseUrl,
    );
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      NewsViewModel bean = NewsViewModel.fromJson(data);
      return bean;
    } else {
      throw Exception();
    }
  }
}
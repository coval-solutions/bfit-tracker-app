import 'dart:async';

import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/repositories/article_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _articleRepository;

  ArticleBloc({@required ArticleRepository articleRepository})
      : assert(articleRepository != null),
        _articleRepository = articleRepository;

  @override
  ArticleState get initialState => ArticleLoading();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is LoadArticle) {
      yield* _mapLoadingToState();
    }
  }

  Stream<ArticleState> _mapLoadingToState() async* {
    try {
      final articles = _articleRepository.retrieve();
      yield ArticleLoaded(articles);
    } catch (_) {
      print(_);
      yield ArticleNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

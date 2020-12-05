part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleNotLoaded extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final Stream<List<Article>> _articles;

  const ArticleLoaded(this._articles);

  @override
  List<Object> get props => [this._articles];

  @override
  String toString() => "ArticleLoaded { _articles: ${this._articles} }";
}

class ArticleLoading extends ArticleState {}

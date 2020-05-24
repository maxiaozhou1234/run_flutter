import 'package:flutter/foundation.dart' as foundation;
import 'package:photoflutter/model/article_repository.dart';

import 'article.dart';

class ArticleModel extends foundation.ChangeNotifier {
  List<Article> getArticleList() {
    return ArticleRepository.get;
  }

  Article getArticle(int index) {
    return getArticleList()[index];
  }

  void updateArticle(Article article, int index) {
    if (index == -1) return;
    if (article == null) {
      getArticleList().removeAt(index);
    } else {
      getArticleList()[index] = article;
    }

    notifyListeners();
  }
}

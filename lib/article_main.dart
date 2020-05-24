import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photoflutter/model/article.dart';

import 'model/article_model.dart';

class ArticleMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleMainState();
  }
}

class _ArticleMainState extends State<ArticleMain> {
  ArticleModel _model;
  List<Article> _list;

  @override
  void initState() {
    super.initState();
    _model = ArticleModel();
    _list = _model.getArticleList();
  }

  bool isNullOrEmpty(String s) {
    return s == null || s.isEmpty;
  }

  Future<void> onItemClick(int index) async {
    var article = _model.getArticle(index);
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ArticleDetail(article: article)));
    print('result $result index:$index');
    if ("delete" == result) {
      _model.updateArticle(null, index);
    } else if (result is Article) {
      _model.updateArticle(result, index);
    }
  }

  Widget _noImageItem(Article item) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  color: Colors.black26,
                  spreadRadius: 2,
                  offset: Offset(2, 2))
            ],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 10.0, left: 6, right: 6),
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 16, color: Colors.indigoAccent),
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: 8.0, bottom: 8.0, left: 6, right: 6),
              child: Text(
                item.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.indigo[200]),
              ),
            )
          ],
        ));
  }

  Widget _hasImageItem(Article item) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Colors.black26,
                spreadRadius: 2,
                offset: Offset(2, 2))
          ],
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: Image.network(item.image).image, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 90.0, left: 6, right: 6),
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 16, color: Colors.indigoAccent),
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: 8.0, bottom: 8.0, left: 6, right: 6),
              child: Text(
                item.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.indigo[200]),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文章'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          var item = _list[index];
          return GestureDetector(
              onTap: () => onItemClick(index),
              child: isNullOrEmpty(item.image)
                  ? _noImageItem(item)
                  : _hasImageItem(item));
        },
        separatorBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(top: 6),
//            child: Divider(height: .0, color: Colors.grey)
        ),
      ),
    );
  }
}

class ArticleDetail extends StatefulWidget {
  final Article article;

  ArticleDetail({this.article});

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetail> {
  Article _article;
  double _width;
  bool _edit = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _article = widget.article;
    _width = window.physicalSize.width - 20;
    _controller = TextEditingController(text: _article.content);
  }

  Widget _image() {
    if (_article.image == null || _article.image.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(0),
      );
    } else {
      return Container(
          width: _width,
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ConstrainedBox(
            child: Image.network(
              _article.image,
              fit: BoxFit.fitWidth,
            ),
            constraints: BoxConstraints.expand(),
          ));
    }
  }

  List<Widget> _action() {
    if (_edit) {
      return <Widget>[
        FlatButton(
          child: Text('取消'),
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _edit = false;
            });
          },
        ),
        FlatButton(
          child: Text('保存并返回'),
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _edit = false;
            });
            String newContent = _controller.text;
            _article.content = newContent;
            Navigator.pop(context, _article);
          },
        )
      ];
    } else {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _edit = true;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            Navigator.pop(context, "delete");
          },
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_article.title),
        actions: _action(),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _image(),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                //移除下划线
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                cursorColor: Colors.blueAccent,
                controller: _controller,
                readOnly: !_edit,
                maxLines: 10,//只单行显示，加这个自动换行
              ),
            ),
          ]),
    );
  }
}

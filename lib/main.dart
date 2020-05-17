import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//void main() => runApp(FirstApp());
//void main() => runApp(MaterialApp(
//      title: 'Second App',
//      home: SecondScaffold(),
//    ));
void main() => runApp(MaterialApp(title: 'TutorialHome', home: TutorialHome()));

class FirstApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Welcome to Flutter',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome to Flutter.'),
//        ),
//        body: Center(
//          child: RandomWords(),
//        ),
//      ),
//    );

    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
//    final worldPair = WordPair.random();
//    return Text(worldPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //下划线前缀标识，强制其变成私有
  final _suggestions = <WordPair>[];
  final _biggestFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggestFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final titles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggestFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: titles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

//============================
//自定义 AppBar
//============================
class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0, //56.0,
//      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.fromLTRB(8.0, 24, 8.0, 0),
      decoration: BoxDecoration(color: Colors.blue),
      //水平方向布局
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class SecondScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      //垂直方向
      child: Column(
        children: <Widget>[
//          AppBar(
//            title: Text('default app bar'),
//            backgroundColor: Colors.green,
//          ),
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello World.'),
            ),
          ),
        ],
      ),
    );
  }
}

//====================
//导航 TutorialHome
//====================
class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
          tooltip: 'Navigation Menu',
        ),
        title: Text('TutorialHome'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: Center(
        child: Text('Hello TutorialHome!'),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add', child: Icon(Icons.add), onPressed: null),
    );
  }
}

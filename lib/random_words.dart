import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

//无限滚动的 ListView
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestion = <WordPair>[];
  final Set<WordPair> _save = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (BuildContext _context, int i) {
      if (i.isOdd) {
        return Divider();
      }
      final int index = i ~/ 2;
      if (index >= _suggestion.length) {
        _suggestion.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestion[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    var state = _save.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        state ? Icons.favorite : Icons.favorite_border,
        color: state ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (state) {
            _save.remove(pair);
          } else {
            _save.add(pair);
          }
        });
      },
    );
  }

  Widget _defaultView() {
    final WordPair pair = WordPair.random();
    return Container(
        height: 50,
        color: Colors.amber[300],
        child: Center(child: Text('$pair')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('RandomWords'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _save.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Saved Suggestions'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }
}

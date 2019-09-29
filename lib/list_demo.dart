import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// 用于展示 ListView 使用
class ListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListDemo")),
      body: SingleChildScrollView(
        child: Column(
          //          控制子集对齐方式
          mainAxisAlignment: MainAxisAlignment.start,
//          控制子集各自的对齐方式
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              child: Text("ListView Default"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListViewLessDataWidget();
              })),
            ),
            MaterialButton(
              child: Text("ListViewBuilder"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListViewBuilderWidget();
              })),
            ),
            MaterialButton(
              child: Text("ListViewSeparated"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListViewSeparatedWidget();
              })),
            ),
            MaterialButton(
              child: Text("InfiniteList"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InfiniteListWidget();
              })),
            ),
          ],
        ),
      ),
    );
  }
}

//列表少量数据测试
//这种方式的列表是预加载，只适用少量数据的情况
//如果有大量或无线数据场景，是不能使用该方式
class ListViewLessDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView less data"),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            const Text("A"),
            const Text("B"),
            const Text("C"),
            const Text("D"),
            const Text("E"),
          ],
        ),
      ),
    );
  }
}

//通过ListView.builder 加载列表项比较多或者无限的情况
//使用 sliver 懒加载的方式
class ListViewBuilderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListViewBuilder"),
      ),
      body: ListView.builder(
        itemCount: 50,
        itemExtent: 50.0, //强制高度为50
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        },
      ),
    );
  }
}

//使用 ListView.separated 给列表项之间添加分割线
class ListViewSeparatedWidget extends StatelessWidget {
  Widget divider_1 = Divider(color: Colors.blue);
  Widget divider_2 = Divider(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListViewSeparated")),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          },
          separatorBuilder: (BuildContext context, int index) {
            return index % 2 == 0 ? divider_1 : divider_2;
          },
          itemCount: 100),
    );
  }
}

//无线加载列表
class InfiniteListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteListState();
  }
}

class _InfiniteListState extends State<InfiniteListWidget> {
  static const loadingTag = "##loading##";//表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("InfiniteList"),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (_words[index] == loadingTag) {
                if (_words.length - 1 < 100) {
                  //获取数据
                  _retrieveData();
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  );
                } else {
                  //已经加载了100条数据，不再获取数据
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.green),
                    ),
                  );
                }
              }
              return ListTile(title: Text(_words[index]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: .0, color: Colors.grey),
            itemCount: _words.length));
  }
}

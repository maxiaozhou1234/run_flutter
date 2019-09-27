import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
//      initialRoute: "/",
      //显示调试网格
//      debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      routes: {
//        "my_page": (context) => MyRoute(),
//        "tip_page": (context) {
//          return TipRoute(text: ModalRoute.of(context).settings.arguments);
//        },
//        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
//      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
//      onGenerateRoute: (RouteSettings settings) {
//        return MaterialPageRoute(builder: (context) {
//          String routeName = settings.name;
//          print(routeName);
//        });
//      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new MyRoute();
                }));
//              使用注册表进行跳转
//                Navigator.pushNamed(context, "my_page");
              },
            ),
            FlatButton(
              child: Text("open tip route"),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RouterTestRouter();
                }));
              },
            ),
            RandomWordWidget(),
            ImageWidget(),
            Image2Widget(),
            Row(
              children: <Widget>[
                FlatButton(
                  textColor: Colors.green,
                  child: Text("lifecycler", style: TextStyle(fontSize: 14.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CounterWidget();
                    }));
                  },
                ),
                FlatButton(
                  textColor: Colors.green,
                  child: Text(
                    "Cupertino",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return CupertinoRoute();
                    }));
                  },
                ),
                FlatButton(
                  textColor: Colors.green,
                  child: Text("TapboxA", style: TextStyle(fontSize: 14.0)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return TapboxA();
                  })),
                ),
                FlatButton(
                  textColor: Colors.green,
                  child: Text("TapboxB", style: TextStyle(fontSize: 14.0)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ParentWidget();
                  })),
                ),
              ],
            ),
            MaterialButton(
              child: Text("ParentWidgetC"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ParentWidgetC();
              })),
            ),
            MaterialButton(
              child: Text(
                "SecondPage,see more",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    decoration: TextDecoration.underline),
              ),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondPage();
              })),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//一个简单的路由示例
class MyRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Route"),
        ),
        body: Center(
          child: Text("This is Reoute page."),
        ));
  }
}

//带返回值的路由
class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text, //接收一个参数
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("提示"),
        ),
        body: Padding(
            padding: EdgeInsets.all(18),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(text),
                  RaisedButton(
                    onPressed: () => Navigator.pop(context, "我是返回值."),
                    child: Text("返回"),
                  )
                ],
              ),
            )));
  }
}

class RouterTestRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RouterTestRouter"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return TipRoute(
                text: "我是提示XXX",
              );
            }));
            print("路由返回值：" + result);
//            使用注册表进行跳转
//            var rr = await Navigator.pushNamed(context, "tip_page",
//                arguments: "我是通过注册表传递参数");
//            print("路由返回值：" + rr);
          },
          child: Text("打开提示页"),
        ),
      ),
    );
  }
}

//命名路由参数传递
class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return null;
  }
}

class RandomWordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(wordPair.toString()),
    );
  }
}

//使用 AssetImage 加载图片
class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return DecoratedBox(
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage('graphics/ic_folder.png')
//          )
//      ),
//    );
    return Image(image: AssetImage('graphics/ic_folder.png'));
  }
}

//使用 Image 加载图片
class Image2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('graphics/ic_folder.png');
  }
}

//新增加计数控件，用于显示加载生命周期
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  State<StatefulWidget> createState() {
    return _CounterWidgetState();
  }
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
        appBar: AppBar(title: Text("CounterWidget")),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text("$_counter"),
                onPressed: () {
                  setState(() => ++_counter);
                },
              ),
              Builder(builder: (context) {
                return RaisedButton(
                  onPressed: () {
                    ScaffoldState _state = context
                        .ancestorStateOfType(TypeMatcher<ScaffoldState>());
                    _state.showSnackBar(SnackBar(
                      content: Text("我是 SnackBar."),
                    ));
                  },
                  child: Text("显示 SnackBar"),
                );
              }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.email),
          onPressed: () {},
        ));
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

//测试 cupertino  iOS 风格
class CupertinoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            child: Text("Press"),
            color: CupertinoColors.activeBlue,
            onPressed: () {}),
      ),
    );
  }
}

//测试 state 自身管理
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TapbaoxAState();
  }
}

class _TapbaoxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//测试 state 由父管理
class ParentWidget extends StatefulWidget {
  ParentWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//测试混合状态管理
class ParentWidgetC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TabboxC extends StatefulWidget {
  TabboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _TabboxCState();
  }
}

class _TabboxCState extends State<TabboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleCancel,
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? Border.all(color: Colors.red[700], width: 10.0)
                : null),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More example"),
      ),
      body: SingleChildScrollView(
        child: Column(
//          控制子集对齐方式
          mainAxisAlignment: MainAxisAlignment.start,
//          控制子集各自的对齐方式
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              child: Text("Button Style"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ButtonWidget();
              })),
            ),
            MaterialButton(
              child: Text("Image Demo"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageDemoWidget();
              })),
            ),
            MaterialButton(
              child: Text("MaterialIcons"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MaterialIconsWidget();
              })),
            ),
            MaterialButton(
              child: Text("Switch CheckBox"),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SwitchAndCheckBoxWidget();
              })),
            ),
          ],
        ),
      ),
    );
  }
}

//按钮样式
class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Button Style")),
      body: Container(
          child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          Text(
            "TestStyle",
            style: TextStyle(
                height: 1.2,
                fontSize: 18.0,
                color: Colors.blue,
                fontFamily: "Courier",
                background: Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
              text: "Text Span: ",
            ),
            TextSpan(
              text: "https:flutterchina.club",
              style: TextStyle(color: Colors.blue, fontSize: 24.0),
              //recognizer: _tapRecognizer
            ),
          ])),
          RaisedButton(
            child: Text("RaiseBtn"),
            onPressed: () {},
          ),
          RaisedButton.icon(
            icon: Icon(Icons.send),
            label: Text("发送"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("FlatBtn"),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text("添加"),
            onPressed: () {},
          ),
          OutlineButton(
            child: Text("OutlineBtn"),
            onPressed: () {},
          ),
          OutlineButton.icon(
            icon: Icon(Icons.info),
            label: Text("详情"),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {},
          ),
          //自定义样式
          FlatButton(
            //扁平按钮，没有阴影
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text("Submit"),
            //圆角
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          ),
          RaisedButton(
            //漂浮按钮，有阴影和灰色背景
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text("Submit"),
            //圆角
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          ),
        ],
      )),
    );
  }
}

class ImageDemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Demo")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  "graphics/ic_folder.png",
                  fit: BoxFit.contain,
                  width: 80,
                ),
                Text(" Local: BoxFit.contain")
              ],
            ),
            Row(
              children: <Widget>[
                Image(
                  image: AssetImage("graphics/ic_folder.png"),
                  fit: BoxFit.fill,
                  width: 80,
                ),
                Text(" Local: BoxFit.fill")
              ],
            ),
            Row(
              children: <Widget>[
                Image(
                  image: NetworkImage(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569501730707&di=2e4dbfd2fed284fe4434b215194f1bcc&imgtype=0&src=http%3A%2F%2Fi2.wp.com%2Fsoftwareengineeringdaily.com%2Fwp-content%2Fuploads%2F2018%2F07%2FFlutterDart.png%3Fresize%3D730%2C389%26ssl%3D1"),
                  width: 100,
                  height: 100,
                  fit: BoxFit.scaleDown,
                  filterQuality: FilterQuality.low,
                ),
                Text("Network:BoxFit.scaleDown,low")
              ],
            ),
            Row(
              children: <Widget>[
                Image.network(
                  "http://img.mukewang.com/5c18cf540001ac8206000338.jpg",
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fitWidth,
                ),
                Text("Network:BoxFit.fitWidth")
              ],
            ),
            Row(
              children: <Widget>[
                Image.network(
                  "http://img.mukewang.com/5c18cf540001ac8206000338.jpg",
                  width: 100.0,
                  height: 100.0,
                  color: Colors.blue,
                  colorBlendMode: BlendMode.difference,
                  fit: BoxFit.fitWidth,
                ),
                Text("Network:BoxFit.fitWidth,difference")
              ],
            ),
            Row(
              children: <Widget>[
                Image.network(
                  "http://dingyue.nosdn.127.net/etqmQabSGrqHXhTvzaS91gV006NWCPDnEgLHRoAVony8E1543979039684.png",
                  width: 200.0,
                ),
                Text("Network")
              ],
            ),
            Row(
              children: <Widget>[
                Image.network(
                  "http://pic4.zhimg.com/v2-8ee10332fbf781fa6f7be9aa6b5fc7ed_r.jpg",
                  width: 200.0,
                ),
                Text("Network")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//使用 MaterialIcons 所有图标地址：https://material.io/tools/icons/
class MaterialIconsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MaterialIcons")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.accessibility, color: Colors.green, size: 80.0),
          Icon(Icons.error, color: Colors.green, size: 80.0),
          Icon(Icons.fingerprint, color: Colors.green, size: 80.0),
        ],
      ),
    );
  }
}

//测试单选框和复选框
class SwitchAndCheckBoxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwitchAndCheckBoxWidgetState();
  }
}

class _SwitchAndCheckBoxWidgetState extends State<SwitchAndCheckBoxWidget> {
  bool _switch = true;
  bool _check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SwitchAndCheckBox")),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Switch(
                    value: _switch,
                    onChanged: (value) {
                      setState(() {
                        _switch = value;
                      });
                    }),
                Text(_switch ? '开' : '关'),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _check,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _check = value;
                    });
                  },
                ),
                Text(_check ? '选中' : '未选中')
              ],
            ),
          ],
        ));
  }
}

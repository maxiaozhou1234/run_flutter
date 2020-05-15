import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test", () {
    Future.sync(() {
      print('hello dart.');
      return "hello";
    }).then((result) {
      print(result);
    });

//    Future.wait([
//      Future.delayed(new Duration(seconds: 1), () {
//        print('hello');
//        return "hello";
//      }),
//      Future.delayed(new Duration(seconds: 2), () {
//        return "dart world.";
//      })
//    ]).then((results) {
//      print(results[0] + results[1]);
//    }, onError: (e) {
//      print('error' + e);
//    }).whenComplete(() {
//      print('complete');
//    });

    print('this is dart?');
    sleep(new Duration(seconds: 5));

    int a = 10;
    var b = 10;

    print('中文输出测试： a == b? ${a == b}');

  });

  test("stream", () {
    Stream.fromFutures([
      Future.delayed(new Duration(seconds: 1), () {
        return "hello 1";
      }),
      Future.delayed(new Duration(seconds: 2), () {
        return AssertionError("error");
      }),
      Future.delayed(new Duration(seconds: 3), () {
        return "hello 3";
      })
    ]).listen((data) {
      print(data);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("on done");
    });
  });

  sleep(new Duration(seconds: 5));
}

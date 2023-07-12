import 'package:flutter/material.dart';

// future测试页面
/// 结论1：使用onError，onError优先级大于catchError，因此当catchError和onError同时存在时，会命中onError方法
/// 结论2：只有在 事件队列中发生的异常才会被onError命中，其他情况视为同步代码，直接被try-catch捕获
class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  static const routeName = '/futurePage';

  @override
  State<StatefulWidget> createState() => _FuturePageState();

}

class _FuturePageState extends State<FuturePage>{
  String _data = '';
  String _catchError = '';
  String _tryCatchError = '';
  String _onError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('future测试'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  test1('1');
                },
                child: const Text('测试await在error的情况下data会如何返回:成功'),
              ),
              TextButton(
                onPressed: () {
                  test1('2');
                },
                child: const Text('测试await在error的情况下data会如何返回:失败'),
              ),
              TextButton(
                onPressed: () {
                  test2();
                },
                child: const Text('异步future异步返回错误，捕捉onError与catchError'),
              ),
              TextButton(
                onPressed: () {
                  test3();
                },
                child: const Text('异步future同步返回错误，捕捉onError与catchError'),
              ),
              TextButton(
                onPressed: () {
                  test4();
                },
                child: const Text('同步future异步返回错误，捕捉tryCatchError'),
              ),
              TextButton(
                onPressed: () {
                  test5();
                },
                child: const Text('同步future同步返回错误，捕捉tryCatchError'),
              ),
              Text('data:$_data'),
              Text('catchError:$_catchError'),
              Text('tryCatchError:$_tryCatchError'),
              Text('onError:$_onError'),
            ],
          ),
        ),
      ),
    );
  }

  /// 测试await在error的情况下data会如何返回
  test1(String type) async{
    resetState();
    var data = await getData1(type).catchError((error){
      print(error);
      setState(() {
        _catchError = error.toString();
      });
    });
    // 走catchError的话不会往下走
    print('futureData:$data');
    setState(() {
      _data = data;
    });
  }

  /// 异步future异步返回错误，捕捉onError与catchError
  test2() async{
    resetState();
    try{
      testFutureAsync().then((data) {
        setState(() {
          _data = data;
        });
      }, onError: (onError){
        setState(() {
          _onError = onError.toString();
        });
      }).catchError((catchError){
        setState(() {
          _catchError = catchError.toString();
        });
      });
    }catch(e){
      setState(() {
        _tryCatchError = e.toString();
      });
    }
  }

  /// 异步future同步返回错误，捕捉onError与catchError
  test3() async{
    resetState();
    try{
      testFuture().then((data) {
        setState(() {
          _data = data;
        });
      }, onError: (onError){
        setState(() {
          _onError = onError.toString();
        });
      }).catchError((catchError){
        setState(() {
          _catchError = catchError.toString();
        });
      });
    }catch(e){
      setState(() {
        _tryCatchError = e.toString();
      });
    }
  }

  /// 同步future异步返回错误，捕捉tryCatchError
  test4() async{
    resetState();
    try{
      var data = await testFutureAsync();
      setState(() {
        _data = data;
      });
    }catch(e){
      setState(() {
        _tryCatchError = e.toString();
      });
    }
  }

  /// 同步future同步返回错误，捕捉tryCatchError
  test5() async{
    resetState();
    try{
      var data = await testFuture();
      setState(() {
        _data = data;
      });
    }catch(e){
      setState(() {
        _tryCatchError = e.toString();
      });
    }
  }

  // 模拟请求
  Future<String> getData1(String type) async{
    await Future.delayed(Duration(seconds: 3));
    if('1' == type){
      return 'ok';
    }else{
      throw('fail');
    }
  }

  // 同步返回错误
  Future testFuture() {
    throw AssertionError("assert error");
  }

  // 异步返回错误
  Future testFutureAsync() async {
    throw AssertionError("assert error async");
  }

  resetState(){
    setState(() {
      _data = '';
      _catchError = '';
      _tryCatchError = '';
      _onError = '';
    });
  }
}

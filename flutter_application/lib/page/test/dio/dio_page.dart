import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/login_bean.dart';
import 'package:flutter_application/data/source/app_repository.dart';

// dio测试页面
class DioPage extends StatefulWidget {
  const DioPage({super.key});

  static const routeName = '/dioPage';

  @override
  State<StatefulWidget> createState() => _DioPageState();

}

class _DioPageState extends State<DioPage>{
  String _data = '';

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
                  test();
                },
                child: const Text('请求'),
              ),
              TextButton(
                onPressed: () {
                  testFail();
                },
                child: const Text('请求失败'),
              ),
              Text(_data),
            ],
          ),
        ),
      ),
    );
  }

  // 请求测试
  test(){
    setState(() {
      _data = '';
    });
    AppRepository().test().then((value){
      setState(() {
        _data = LoginBean.fromJson(value.data).accessToken;
      });
    }, onError: (e){
      setState(() {
        _data = e.toString();
      });
    });
  }

  // 请求失败测试
  testFail(){
    setState(() {
      _data = '';
    });
    AppRepository().testFail().then((value){
      setState(() {
        _data = value.toString();
      });
    }, onError: (e){
      setState(() {
        _data = e.toString();
      });
    });
  }
}

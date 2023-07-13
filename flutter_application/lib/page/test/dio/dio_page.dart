import 'package:flutter/material.dart';
import 'package:flutter_application/network/remote_data_source.dart';

// dio测试页面
class DioPage extends StatefulWidget {
  const DioPage({super.key});

  static const routeName = '/dioPage';

  @override
  State<StatefulWidget> createState() => _DioPageState();

}

class _DioPageState extends State<DioPage>{
  // String _data = '';
  // String _catchError = '';
  // String _tryCatchError = '';
  // String _onError = '';

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
              // Text('data:$_data'),
              // Text('catchError:$_catchError'),
              // Text('tryCatchError:$_tryCatchError'),
              // Text('onError:$_onError'),
            ],
          ),
        ),
      ),
    );
  }

  test(){
    RemoteDataSource().test();
  }
}

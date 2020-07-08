import 'package:flutter/material.dart';
import 'package:redux_demo/under_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_demo/states/count_state.dart' as CountStateLib;

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
      ),
      body: Center(
        child:
            StoreConnector<CountStateLib.CountState, CountStateLib.CountState>(
          converter: (store) => store.state,
          // converter: (store) => store.state.count,
          builder: (context, _countState) {
            return Column(
              children: <Widget>[
                Text('第一个页面', style: TextStyle(fontSize: 24)),
                Divider(),
                Text(_countState.count.toString()),
                StoreConnector<CountStateLib.CountState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(CountStateLib.Action.reduce);
                  },
                  builder: (context, callback) {
                    return Row(
                      children: <Widget>[
                        Divider(),
                        Text('使用外面的 store 数据：${_countState.count.toString()} '),
                        RaisedButton(
                          child: Text('-'),
                          onPressed: () {
                            callback();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return UnderScreen();
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}

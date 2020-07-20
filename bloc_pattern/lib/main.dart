import 'package:bloc_pattern/bloc/library_bloc.dart';
import 'package:bloc_pattern/bloc/native_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberBloc _numberBloc;
  ColorBloc _colorBloc;

  @override
  void initState() {
    _numberBloc = NumberBloc();
    _colorBloc = ColorBloc();
    super.initState();
  }

  @override
  void dispose() {
    _numberBloc.dispose();
    _colorBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bloc Lab"),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<int>(
                initialData: 0,
                stream: _numberBloc.stateStream,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Tap increment/decrement button to change number",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error :("),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<ColorBloc, ColorState>(
                bloc: _colorBloc,
                builder: (ctx, state) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: state.color,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      state.title,
                      style: TextStyle(
                        color: state.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue,
                          elevation: 0,
                          shape: CircleBorder(),
                          onPressed: () => _colorBloc.add(
                            ColorEvent(
                              color: Colors.blue,
                              title: "Blue",
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.purple,
                          elevation: 0,
                          shape: CircleBorder(),
                          onPressed: () => _colorBloc.add(
                            ColorEvent(
                              color: Colors.purple,
                              title: "Purple",
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.orange,
                          elevation: 0,
                          shape: CircleBorder(),
                          onPressed: () => _colorBloc.add(
                            ColorEvent(
                              color: Colors.orange,
                              title: "Orange",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _numberBloc.eventSink.add(NumberEvent.increment),
            ),
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () => _numberBloc.eventSink.add(NumberEvent.decrement),
            ),
          ],
        ),
      ),
    );
  }
}

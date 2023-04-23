import 'package:flutter/material.dart';
import 'apirest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial 3',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Parcial 3'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Nombre'),
                Tab(text: 'Apellido'),
                Tab(text: 'API'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('Nestor')),
              Center(child: Text('Mendoza')),
              Parcial3(),
            ],
          ),
        ),
      ),
    );
  }
}

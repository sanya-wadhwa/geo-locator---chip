import 'package:flutter/material.dart';

class Widgets extends StatelessWidget {
  const Widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widgets"),
      ),
      body: Wrap(
        children: [
          ConstrainedBox(constraints: BoxConstraints.expand(height: 100),child: Text("svfehtyadgsuighisuayh"),),
          // height is necessary to be givin otherwise it will show unbounded heights..
          // expand means widget will expand horizontally..
          ConstrainedBox(constraints: BoxConstraints.tight(Size(40, 30)),child: Text("svfehtyadgsuighisuayh"),),
          // tight shows the content of widget in particular size given.. remaining content of the widget will get hidden.
        ],
      ),
    );
  }
}

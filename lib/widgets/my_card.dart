    import 'package:flutter/material.dart';

    Widget myCard( {@required Widget child,@required context, @required double padding,@required double margin}) {
      return Container(
        margin : EdgeInsets.all(margin),
        child: Card(
          color: Colors.grey[200],
          elevation: 2,
          child: Container(
              margin: EdgeInsets.all(padding),
              width: MediaQuery.of(context).size.width * 0.9,
              child: child),
        ),
      );
    }
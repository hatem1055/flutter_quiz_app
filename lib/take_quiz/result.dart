import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  static const route = '/result';
  @override
  Widget build(BuildContext context) {
    final resultData = ModalRoute.of(context).settings.arguments as Map;
    Widget myText(String text) {
      return Card(
        elevation:4,
        child: Container(
          width:MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(10),
          child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w700),
      ),
        ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('${resultData["quiz_name"]}'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText('total questions : ${resultData["total_questons"]}'),
            myText('right questions : ${resultData["right_questions"]}'),
            myText('Percentage : ${resultData["percentege"]} %'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/');
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor)),
                    child: Text('Go to the home page'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

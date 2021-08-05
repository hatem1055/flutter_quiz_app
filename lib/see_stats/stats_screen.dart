import 'package:flutter/material.dart';

const dummyResult = [
  {'name': 'test 1', 'result': 7},
  {'name': 'test 2', 'result': 9},
  {'name': 'test 3', 'result': 3},
  {'name': 'test 4', 'result': 6},
  {'name': 'test 5', 'result': 1},
  {'name': 'test 6', 'result': 8},
];

double foramtPercent(double perc){
  return double.parse(perc.toStringAsFixed(2));
}
class Result {
  String name;
  int result;
  int fullmark;
  Result(this.fullmark, this.name, this.result);
  double get percentage {
    return foramtPercent((this.result / this.fullmark) * 100);
  }
}

class QuizStats {
  String quizName;
  List<Result> results;
  int fullmark;
  QuizStats(this.fullmark, this.quizName, this.results);
  double get successPrecent {
    int totalResluts = results.length;
    int successes = 0;
    double minSucccessResult = this.fullmark / 2;
    for (Result result in this.results) {
      if (result.result > minSucccessResult) {
        successes += 1;
      }
    }
    return foramtPercent((successes / totalResluts) * 100);
  }
}

List<Result> dataToResults(data, fullmark) {
  List<Result> results = [];
  for (Map result in data) {
    results.add(Result(fullmark, result['name'], result['result']));
  }
  return results;
}

class QuizStatsScreen extends StatelessWidget {
  static const route = '/stats';
  getQuizStats(id) {
    if (id != null) {
      return QuizStats(10, 'Test Quiz', dataToResults(dummyResult, 10));
    }
    return false;
  }

  Widget myTableCell(String text) {
    return Container(
      padding: EdgeInsets.all(5),
      child: TableCell(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String quizId = ModalRoute.of(context).settings.arguments as String;
    QuizStats quizStats = getQuizStats(quizId);
    List<TableRow> relsutsRows() {
      return quizStats.results
          .map((e) => TableRow(children: [
                myTableCell(e.name),
                myTableCell('${e.result} / ${e.fullmark}'),
                myTableCell('${e.percentage}')
              ]))
          .toList();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(quizStats.quizName),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(40),
                  1: FlexColumnWidth(40),
                  2: FixedColumnWidth(100),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    myTableCell('name'),
                    myTableCell('result'),
                    myTableCell('percentage')
                  ]),
                  ...relsutsRows(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Table(
                  border: TableBorder(
                      bottom: BorderSide(),
                      left: BorderSide(),
                      horizontalInside:BorderSide() ,
                      verticalInside: BorderSide() ,
                      right: BorderSide()),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(40),
                    1: FixedColumnWidth(140),
                  },
                  children: [
                    TableRow(children: [
                      myTableCell('Seccess Percent'),
                      myTableCell('${quizStats.successPrecent} %')
                    ])
                  ]),
            )
          ],
        ));
  }
}

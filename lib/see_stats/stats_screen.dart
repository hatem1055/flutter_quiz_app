import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/credintials_data.dart';

const dummyResult = [
  {'name': 'test 1', 'result': 7},
  {'name': 'test 2', 'result': 9},
  {'name': 'test 3', 'result': 3},
  {'name': 'test 4', 'result': 6},
  {'name': 'test 5', 'result': 1},
  {'name': 'test 6', 'result': 8},
];
double foramtPercent(double perc) {
  return double.parse(perc.toStringAsFixed(2));
}

class Result {
  String name;
  int result;
  int fullmark;
  double percentage;
  Result(this.fullmark, this.name, this.result, this.percentage);
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

List<Result> dataToResults(data) {
  List<Result> results = [];
  for (Map result in data) {
    final percentage = result['percentage'].toDouble();
    results.add(Result(result['total'], result['name'], result['right'],
        foramtPercent(percentage)));
    print('after');
  }
  return results;
}

class QuizStatsScreen extends StatelessWidget {
  static const route = '/stats';

  Widget myTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(5),
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
    List results = ModalRoute.of(context).settings.arguments as List;
    final credintialsAndData = Provider.of<CredintialsAndData>(context);

    QuizStats quizStats = QuizStats(results[0]['total'],
        credintialsAndData.quizData['quiz_name'], dataToResults(results));
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
        body: quizStats.results.length > 0
            ? Column(
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
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
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
                            horizontalInside: BorderSide(),
                            verticalInside: BorderSide(),
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
              )
            : Text('Sorry nobody have taken this quiz yet'));
  }
}

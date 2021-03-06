import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/providers/credintials_data.dart';

// ignore: must_be_immutable
class GoToWidget extends StatelessWidget {
  final String placeholder;
  final String errorMessage;
  final String goToRoute;
  final String buttonText;
  final Function checkValidity;
  final Function setData;
  GoToWidget(
      {@required this.placeholder,
      @required this.errorMessage,
      @required this.goToRoute,
      @required this.buttonText,
      @required this.checkValidity,
      @required this.setData});
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final credintialsAndData = Provider.of<CredintialsAndData>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            controller: password,
            autofocus: true,
            onChanged: (val){
              credintialsAndData.setGoToTextField(val);
            },
            decoration: InputDecoration(
              labelText: placeholder,
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: 40,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      final checkAvilabilityInfo = await checkValidity();
                      if (checkAvilabilityInfo != false && password.value.text.isNotEmpty) {
                        Navigator.popAndPushNamed(context, goToRoute,
                            arguments: checkAvilabilityInfo);
                        setData();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(errorMessage),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                        ));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor)),
                    child: Text(buttonText)))
          ],
        )
      ],
    );
  }
}

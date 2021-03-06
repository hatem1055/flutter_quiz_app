import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_creator.dart';

// ignore: must_be_immutable
class OptionTile extends StatefulWidget {
  Question question;
  Option option;
  Key key;
  OptionTile(this.question, this.option,this.key);

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    Option option = widget.option;
    String optionText = option.option;
    TextEditingController optionValue = TextEditingController(text: optionText);

    void setOptionValue(id, val) {
      optionText = val;
      widget.question.setOptionValue(option.id, val);
    }

    return RadioListTile(
      title: isEditing && option.id == widget.question.focusedOptionId
          ? TextField(
              controller: optionValue,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
              onChanged: (val) {
                setOptionValue(option.id, val);
              },
              onSubmitted: (val) {
                setState(() {
                  isEditing = false;
                });
              },
            )
          : GestureDetector(
              onTap: () {
                widget.question.changeFocusedOptionId(option.id);
                setState(() {
                  isEditing = true;
                });
              },
              child: Text(optionText),
            ),
      value: option.id,
      groupValue: widget.question.rightOptionId,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (val) {
        widget.question.changeRightAnswere(option.id);
      },
      secondary: IconButton(
          onPressed: () {
            widget.question.deleteOption(option.id);
          },
          icon: Icon(Icons.delete)),
    );
  }
}

class OptionsTileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Question question = Provider.of<Question>(context);
    List<Widget> optionsTiles() {
      return question.options.map((e) => OptionTile(question, e,Key(e.id))).toList();
    }

    return ReorderableListView(
      onReorder: (o,n){
        question.reOrderOptions(o, n);
      },
      children: [
        ...optionsTiles(),
        Column(
          key: Key('add question'),
          children: [
            TextButton(
                onPressed: () {
                  question.addOption(Option('option #${question.optionsLength + 1}',
                      false, DateTime.now().toString()));
                },
                child: Row(
                  children: [
                    Text(
                      'add Option',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.grey,
                    )
                  ],
                )),
          ],
        )
      ],
    );
  }
}

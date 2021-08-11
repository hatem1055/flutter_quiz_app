import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/the_quiz_provider.dart';
import '../widgets/my_card.dart';

// ignore: must_be_immutable
class OptionTile extends StatelessWidget {
  Option option;
  OptionTile(this.option);
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<Question>(context);
    return myCard(
      child:RadioListTile(
        activeColor: Theme.of(context).primaryColor,
        value: option.id, 
        groupValue: question.choosenOptionId, 
        title: Text(option.option),
    onChanged: (val){
      question.changeChoosenOption(val);
    }), 
  context : context,
  margin: 2,
  padding: 2);
  }
}
class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<Question>(context);
    return Column(
      children: [
        ...question.options.map((option) => OptionTile(option))
      ],
    );
  }
}

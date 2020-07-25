import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  // String amountInput;

  static final _titleController = TextEditingController();
  static final _amountController = TextEditingController();

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _selectedDate;
  void _submitData() {
    if (NewTransaction._amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = NewTransaction._titleController.text;
    final enteredAmount = double.parse(NewTransaction._amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop(); //close modal sheet after adding transaction'
    //context us available as we are in a state class
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    10 //get the box size entire input area and add 10 to it,
                //lifts u input area for new transactions
                ), //note that there is a Padding widget if all you need is padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  // onChanged: (value) => {titleInput = value},
                  controller: NewTransaction
                      ._titleController, //alternative to the above line,controllers listen to text inputs and saves the value
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: NewTransaction._amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitData,
                  // onChanged: (val) => amountInput = val,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        //take as much space as it can get
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      AdaptiveButton('Choose Date', _presentDatePicker),
                    ],
                  ),
                ),
                RaisedButton(
                    onPressed: _submitData,
                    // onPressed: () {
                    //   // print(titleController.text);
                    //   // print(amountInput);
                    //   addTransaction(titleController.text,
                    //       double.parse(amountController.text)); //
                    // },
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text('Add Transaction'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransacion extends StatefulWidget {
  final Function add;
  NewTransacion(this.add);

  @override
  _NewTransacionState createState() => _NewTransacionState();
}

class _NewTransacionState extends State<NewTransacion> {
  final titlecontroller = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enterTitle = titlecontroller.text;
    if (amountController.text.isEmpty) return;
    double enterAmount = double.parse(amountController.text);

    if (enterAmount <= 0 || enterTitle.isEmpty || _selectedDate == null) return;

    widget.add(titlecontroller.text.toString(),
        double.parse(amountController.text.toString()), _selectedDate);
    // To Close Tap When Done
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    )..then((pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _selectedDate = pickedDate;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 30,
        margin: EdgeInsets.all(2),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titlecontroller,
              ),
              TextField(
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'NO Date Chosen !'
                            : 'Piced Date ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    RaisedButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date'),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: submitData,
                child: Text(
                  "Add Transaction ",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                color: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}

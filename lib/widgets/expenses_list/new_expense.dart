import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewExpense extends StatefulWidget {
   NewExpense({super.key, required this.onAddExpense});

   final void Function(Expense expense) onAddExpense;
  DateTime? selectedDate;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

 class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  //final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  Category _selectedCategory = Category.travel;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? selectedDate;

  void _peresentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if(_titleController.text.trim().isEmpty || invalidAmount || selectedDate == null) {
    // Add your save logic here
    showDialog(context: context,
    builder: (context) => AlertDialog(
      title: const Text('Invalid Input',
      style: TextStyle(
        color: Colors.red,
      ),
      ),
      content: const Text('please make sure that a valid, title,amount date and category are entered',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16
      ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok',
          style: TextStyle(
            fontSize: 19,
          ),
          ))],
    ),
    );
    return;
  }
  
  widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: selectedDate!, category: _selectedCategory));

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.title),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _titleController.clear();
                  });
                },
                tooltip: 'Clear',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.attach_money),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _amountController.clear();
                        });
                      },
                      tooltip: 'Clear',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'No date selected'
                          : formatter.format(selectedDate!),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    //const SizedBox(width: 2,),
                    IconButton(
                      onPressed: _peresentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                  // Add your save logic here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
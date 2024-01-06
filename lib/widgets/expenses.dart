import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, });
 

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 55.0,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Movie',
        amount: 10.0,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Cake',
        amount: 55.0,
        date: DateTime.now(),
        category: Category.food),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>  NewExpense(onAddExpense: addExpenses,),
    );
  }

  void addExpenses(Expense expense) {
    setState(() {
    _registeredExpenses.add(expense);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Trucker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
            color: Colors.white,
            iconSize: 30,
            tooltip: 'Add Expense',
            highlightColor: Colors.black26,
            padding: const EdgeInsets.all(0),
          )
        ],
      ),
      body: Container(
        color: Colors.blue.shade100,
        child: Column(
          children: [
            const Text('The Chart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Expanded(child: ExpensesList(expenses: _registeredExpenses)),
          ],
        ),
      ),
    );
  }
}

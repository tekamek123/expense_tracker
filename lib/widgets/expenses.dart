import 'package:expense_tracker/widgets/chart/chart.dart';
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
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>  NewExpense(onAddExpense: addExpenses,),
    );
  }

  void addExpenses(Expense expense) {
    setState(() {
    _registeredExpenses.add(expense);
    });
  }

  void removeExpenses(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration: const Duration(
          seconds: 4,
        ),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(
      child: Text('No registered expenses yet!',
      style: TextStyle(fontSize: 24,
      fontWeight: FontWeight.bold,
      ),
      ),
    );
    if(_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpenses,
        );
    }

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
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent)
          ],
        ),
      ),
    );
  }
}

import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('The Chart'),
            Expanded(child: ExpensesList(expenses: _registeredExpenses)),
          ],
        ),
      ),
    );
  }
}
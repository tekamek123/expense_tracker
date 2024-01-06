import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpensesList extends StatelessWidget {
   ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: Key(expenses[index].id),
        child: ExpenseItem(expenses[index],expense: expenses[index],)),
    );
  }
}

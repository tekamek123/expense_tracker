import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(Expense expens, {super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            Text(
              expense.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                   Icon(categoryIcons[expense.category],
                   color: Colors.white,
                   ),
                  const SizedBox(width: 4,),
                  Text(expense.formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  ),
                ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

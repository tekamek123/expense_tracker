
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {travel, leisure, food, work}

const categoryIcons =  {
  Category.travel: Icons.flight_takeoff, //
  Category.leisure: Icons.movie, //
  Category.food: Icons.restaurant, //
  Category.work: Icons.work, // 
};

class Expense {
  
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime  date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(
    List<Expense> allExpenses, this.category
    ) : expenses = allExpenses.where((expense) => expense.category == category).toList();

  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
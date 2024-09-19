import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      title: 'milk',
      amount: 3.99,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
    Expense(
      title: 'cinema',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseCategory.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addExpense,
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(expenses: _expenses),
          ),
        ],
      ),
    );
  }

  void _addExpense() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Text('+'),
    );
  }
}

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

const maxPortraitModeWidth = 600;

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
    final width = MediaQuery.of(context).size.width;

    Widget mainContent =
        const Center(child: Text('No expenses. Add something'));

    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddExpense,
          ),
        ],
      ),
      body: width < maxPortraitModeWidth
          ? Column(
              children: [
                Chart(expenses: _expenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }

  void _showAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() => _expenses.add(expense));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() => _expenses.remove(expense));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }
}

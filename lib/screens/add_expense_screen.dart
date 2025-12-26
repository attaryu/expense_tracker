import 'package:expense_tracker/core/constants/breakpoint.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final TextEditingController datePickerController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Align(
        alignment: BreakPoint.isMobile(width)
            ? Alignment.topCenter
            : Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: BreakPoint.mobile),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Expense',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Enter the details below to help you keep track of your expenses!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(prefixText: 'RP. '),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }

                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }

                          if (value.length < 3) {
                            return 'Description must be at least 3 characters long';
                          }

                          if (value.length > 100) {
                            return 'Description must be less than 100 characters long';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 8),
                      Autocomplete<String>(
                        onSelected: (String selection) {
                          categoryController.text = selection;
                        },
                        fieldViewBuilder:
                            (
                              context,
                              textEditingController,
                              focusNode,
                              onFieldSubmitted,
                            ) {
                              textEditingController.text =
                                  categoryController.text;
                              textEditingController.selection =
                                  TextSelection.fromPosition(
                                    TextPosition(
                                      offset: textEditingController.text.length,
                                    ),
                                  );

                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                onChanged: (value) {
                                  categoryController.text = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a category';
                                  }

                                  return null;
                                },
                              );
                            },
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return expenseProvider.categories.where(
                            (category) => category.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today, size: 20),
                          suffixIconColor: Theme.of(context).primaryColor,
                        ),
                        controller: datePickerController,
                        enableInteractiveSelection: false,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }

                          return null;
                        },
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: formatter.parse(
                              datePickerController.text,
                            ),
                            firstDate: DateTime(DateTime.now().year - 5),
                            lastDate: DateTime(DateTime.now().year + 5),
                          );

                          if (pickedDate != null) {
                            setState(
                              () => datePickerController.text = formatter
                                  .format(pickedDate),
                            );
                          }
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        expenseProvider.add(
                          ExpenseModel(
                            amount: double.parse(amountController.text),
                            description: descriptionController.text,
                            category: categoryController.text,
                            date: formatter.parse(datePickerController.text),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Expense Saved'),
                            duration: Duration(seconds: 3),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

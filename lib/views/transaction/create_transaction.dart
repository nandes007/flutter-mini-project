import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundry_app/model/transaction_model.dart';
import 'package:laundry_app/view_model/transaction_view_model.dart';
import 'package:provider/provider.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();
  final _beginDate = TextEditingController();
  final _customerName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _weight = TextEditingController();
  final _service = TextEditingController();
  final _grandTotal = TextEditingController();
  final _estimateDate = TextEditingController();
  final _endDate = TextEditingController();
  final _status = TextEditingController();
  final _description = TextEditingController();

  Future<void> submit() async {
    final result =
        await Provider.of<TransactionViewModel>(context, listen: false)
            .addTransaction(
      TransactionModel(
        beginDate: _beginDate.text,
        customerName: _customerName.text,
        phoneNumber: _phoneNumber.text,
        weight: _weight.text,
        service: _service.text,
        grandTotal: _grandTotal.text,
        estimateDate: _estimateDate.text,
        endDate: _endDate.text,
        status: _status.text,
        description: _description.text,
      ),
    );

    setState(() {
      if (result) {
        _beginDate.text = '';
        _customerName.text = '';
        _phoneNumber.text = '';
        _weight.text = '';
        _service.text = '';
        _grandTotal.text = '';
        _estimateDate.text = '';
        _endDate.text = '';
        _status.text = '';
        _description.text = '';
      }
    });
  }

  final currentDate = DateTime.now();
  DateTime _dueDate = DateTime.now();
  String dateFormat(stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Transaction'),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Center(
              child: Text(
                'Create New Transaction',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onTap: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                    String tempDate = dateFormat(_dueDate.toString());
                    _beginDate.text = tempDate;
                  }
                });
              },
              controller: _beginDate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.date_range_rounded,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Begin Date',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _customerName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Customer Name',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _weight,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.monitor_weight_rounded,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Weight',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _service,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.local_laundry_service_rounded,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Service',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _grandTotal,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.monetization_on,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Grand Total',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onTap: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                    String tempDate = dateFormat(_dueDate.toString());
                    _estimateDate.text = tempDate;
                  }
                });
              },
              controller: _estimateDate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.date_range_rounded,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Estimate Date',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onTap: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                    String tempDate = dateFormat(_dueDate.toString());
                    _endDate.text = tempDate;
                  }
                });
              },
              controller: _endDate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.date_range_rounded,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'End Date',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _status,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.wifi_protected_setup_sharp,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Status',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.description,
                  color: Color(0xFFA7F0BA),
                ),
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Color(0xFF24A148),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: submit,
              child: const Text('Create'),
            )
          ],
        ),
      ),
    );
  }
}

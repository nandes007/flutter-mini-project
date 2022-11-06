import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundry_app/model/transaction_model.dart';
import 'package:laundry_app/view_model/transaction_view_model.dart';
import 'package:laundry_app/views/transaction/list_transaction.dart';
import 'package:provider/provider.dart';

const List<String> statuses = <String>['Created', 'Completed'];
const List<String> services = <String>['Regular', 'Express'];

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  @override
  void initState() {
    super.initState();
    _service = services.first;
    _status = statuses.first;
    _beginDate.text = '';
    _customerName.text = '';
    _phoneNumber.text = '';
    _weight.text = '';
    _grandTotal.text = '';
    _estimateDate.text = '';
    _endDate.text = '';
    _description.text = '';
  }

  final _formKey = GlobalKey<FormState>();
  final _beginDate = TextEditingController();
  final _customerName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _weight = TextEditingController();
  final _grandTotal = TextEditingController();
  final _estimateDate = TextEditingController();
  final _endDate = TextEditingController();
  final _description = TextEditingController();

  Future<void> submit() async {
    final result =
        await Provider.of<TransactionViewModel>(context, listen: false)
            .addTransaction(
      TransactionModel(
        beginDate: _beginDate.text,
        customerName: _customerName.text,
        phoneNumber: _phoneNumber.text,
        weight: double.parse(_weight.text),
        service: _service,
        grandTotal: double.parse(_grandTotal.text),
        estimateDate: _estimateDate.text,
        endDate: _endDate.text,
        status: _status,
        description: _description.text,
      ),
    );

    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ListTransaction(),
        ),
      );
    }

    setState(() {});
  }

  String _status = statuses.first;
  String _service = services.first;
  final currentDate = DateTime.now();
  DateTime _dueDate = DateTime.now();
  String dateFormat(stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<TransactionViewModel>(context);
    final isLoading = modelView.state == TransactionViewState.loading;
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create Transaction'),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
      );
    }
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
              keyboardType: TextInputType.number,
              onChanged: ((value) {
                var cost = 0.0;
                if (_service == 'Regular') {
                  cost = 7000.0;
                  cost *= double.parse(value);
                } else if (_service == 'Express') {
                  cost = 10000.0;
                  cost *= double.parse(value);
                }
                setState(() {
                  _grandTotal.text = cost.toString();
                });
              }),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Service',
                  style: TextStyle(color: Colors.green),
                ),
                DropdownButton<String>(
                  value: _service,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                  underline: Container(
                    height: 1,
                    color: Colors.green,
                  ),
                  onChanged: (String? value) {
                    double cost = 0.0;
                    if (value == 'Regular') {
                      cost = 7000.0;
                      var weightParse = double.parse(_weight.text);
                      cost *= weightParse;
                    } else if (value == 'Express') {
                      cost = 10000.0;
                      var weightParse = double.parse(_weight.text);
                      cost *= weightParse;
                    }
                    setState(() {
                      _grandTotal.text = cost.toString();
                      _service = value!;
                    });
                  },
                  items: services.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _grandTotal,
              enabled: false,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(color: Colors.green),
                ),
                DropdownButton<String>(
                  value: _status,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                  underline: Container(
                    height: 1,
                    color: Colors.green,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _status = value!;
                    });
                  },
                  items: statuses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
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

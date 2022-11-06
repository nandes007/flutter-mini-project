import 'package:flutter/material.dart';
import 'package:laundry_app/model/transaction_model.dart';
import 'package:laundry_app/view_model/transaction_view_model.dart';
import 'package:laundry_app/views/transaction/list_transaction.dart';
import 'package:provider/provider.dart';

class ShowTransaction extends StatelessWidget {
  const ShowTransaction({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaction'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Detail Transaction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customer Name : ${transactionModel.customerName}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Status : ${transactionModel.status}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bagin Date : ${transactionModel.beginDate}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'End Date : ${transactionModel.endDate}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Description : ${transactionModel.description}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Grand Total : ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${transactionModel.grandTotal}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            transactionModel.status == 'Created'
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      final result = await Provider.of<TransactionViewModel>(
                              context,
                              listen: false)
                          .markAsCompleteTransaction(
                        transactionModel.id,
                        'Completed',
                      );

                      print(result);

                      if (result) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListTransaction(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Mark As Complited',
                    ),
                  )
                : const Text('')
          ],
        ),
      ),
    );
  }
}

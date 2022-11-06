import 'package:flutter/material.dart';
import 'package:laundry_app/view_model/transaction_view_model.dart';
import 'package:laundry_app/views/transaction/show_transaction.dart';
import 'package:provider/provider.dart';

class ListTransaction extends StatefulWidget {
  const ListTransaction({super.key});

  @override
  State<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  Future<void> deleteTransaction(id, index) async {
    await Provider.of<TransactionViewModel>(context, listen: false)
        .deleteTransaction(id, index);
    setState(() {});
  }

  Future<void> getTransactionById(id) async {
    var result = await Provider.of<TransactionViewModel>(context, listen: false)
        .getTransactionById(id);

    if (result != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowTransaction(
            transactionModel: result,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<TransactionViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Transactions'),
        backgroundColor: Colors.green,
      ),
      body: modelView.transactions.isNotEmpty
          ? ListView.builder(
              itemCount: modelView.transactions.length,
              itemBuilder: (context, index) {
                final transaction = modelView.transactions[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1.5, color: Colors.green.shade600),
                    ),
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              transaction.customerName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          transaction.status == 'Created'
                              ? Container(
                                  width: 80,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      transaction.status,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 80,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      transaction.status,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(transaction.beginDate),
                          ),
                          Expanded(
                            child: Text(transaction.estimateDate),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(transaction.grandTotal.toString()),
                          ),
                          Expanded(
                            child: Text(transaction.service),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () async {
                                  await getTransactionById(transaction.id);
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Show'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  await deleteTransaction(
                                    transaction.id,
                                    index,
                                  );
                                },
                                icon: const Icon(Icons.delete_forever),
                                label: const Text('Delete'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.hourglass_disabled_outlined,
                    size: 30,
                  ),
                  Text(
                    'Transaction is empty!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

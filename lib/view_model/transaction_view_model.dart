import 'package:flutter/material.dart';
import 'package:laundry_app/model/api/auth_api.dart';
import 'package:laundry_app/model/api/transaction_api.dart';
import 'package:laundry_app/model/transaction_model.dart';

class TransactionViewModel with ChangeNotifier {
  AuthAPI authAPI = AuthAPI();
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  TransactionAPI transactionAPI = TransactionAPI();

  initTransactionProvider() async {
    await getAllTransactions();
    notifyListeners();
  }

  Future<bool> addTransaction(TransactionModel transactionModel) async {
    try {
      final trf = await transactionAPI.save(transactionModel.toJson());
      _transactions.add(trf);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
      // rethrow;
    }
  }

  getAllTransactions() async {
    try {
      final t = await transactionAPI.getAll();
      _transactions = t;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  deleteTransaction(int id) async {
    try {
      final t = await transactionAPI.destroy(id);
    } catch (e) {
      rethrow;
    }
  }
}

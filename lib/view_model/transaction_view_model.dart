import 'package:flutter/material.dart';
import 'package:laundry_app/model/api/auth_api.dart';
import 'package:laundry_app/model/api/transaction_api.dart';
import 'package:laundry_app/model/transaction_model.dart';

enum TransactionViewState { none, loading, error }

class TransactionViewModel with ChangeNotifier {
  AuthAPI authAPI = AuthAPI();
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  TransactionAPI transactionAPI = TransactionAPI();

  TransactionViewState _state = TransactionViewState.none;
  TransactionViewState get state => _state;
  changeState(TransactionViewState s) {
    _state = s;
    notifyListeners();
  }

  initTransactionProvider() async {
    await getAllTransactions();
    notifyListeners();
  }

  Future<bool> addTransaction(TransactionModel transactionModel) async {
    changeState(TransactionViewState.loading);

    try {
      final trf = await transactionAPI.save(transactionModel.toJson());
      _transactions.add(trf);
      notifyListeners();
      changeState(TransactionViewState.none);
      return true;
    } catch (e) {
      changeState(TransactionViewState.error);
      return false;
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

  Future<TransactionModel> getTransactionById(id) async {
    try {
      final t = await transactionAPI.show(id);
      notifyListeners();
      return t;
    } catch (e) {
      rethrow;
    }
  }

  markAsCompleteTransaction(int? id, String status) async {
    changeState(TransactionViewState.loading);

    try {
      await transactionAPI.update(id, status);
      for (var element in _transactions) {
        if (element.id == id) {
          element.status = status;
          notifyListeners();
        }
      }
      notifyListeners();
      changeState(TransactionViewState.none);
      return true;
    } catch (e) {
      changeState(TransactionViewState.error);
      return false;
    }
  }

  deleteTransaction(int id, int index) async {
    try {
      final result = await transactionAPI.destroy(id);
      if (result) {
        _transactions.removeAt(index);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

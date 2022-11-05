import 'dart:convert';

import 'package:laundry_app/config/api.dart';
import 'package:laundry_app/model/transaction_model.dart';
import 'package:laundry_app/util/exceptions.dart';
import 'package:http/http.dart' as http;

class TransactionAPI {
  void validateResponseStatus(int status, int validStatus) {
    if (status == 401) {
      throw AuthException("401", "Unauthorized");
    }

    if (status != validStatus) {
      throw ApiException(status.toString(), "API Error");
    }
  }

  Future<List<TransactionModel>> getAll() async {
    final response = await http.get(
      Uri.parse(Api.transactions),
      headers: <String, String>{
        'Accept': 'application/json;',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> apiResponse = jsonDecode(response.body);

    List<TransactionModel> transactions = (apiResponse["data"] as List)
        .map(
          (e) => TransactionModel(
            id: e['id'],
            beginDate: e['begin_date'].toString(),
            customerName: e['customer_name'],
            phoneNumber: e['phone_number'],
            weight: e['weight'].toString(),
            service: e['service'],
            grandTotal: e['grand_total'].toString(),
            estimateDate: e['estimate_date'].toString(),
            endDate: e['end_date'].toString(),
            status: e['status'],
            description: e['description'],
          ),
        )
        .toList();
    validateResponseStatus(response.statusCode, 200);
    return transactions;
  }

  Future<TransactionModel> save(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(Api.transactions),
      headers: <String, String>{
        'Accept': 'application/json;',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    Map<String, dynamic> apiResponse = jsonDecode(response.body);
    var result = TransactionModel.fromJson(apiResponse["data"]);

    validateResponseStatus(response.statusCode, 201);
    return result;
  }

  Future<bool> destroy(int id) async {
    final response = await http.delete(
      Uri.parse('${Api.transactions}/$id'),
      headers: <String, String>{
        'Accept': 'application/json;',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> apiResponse = jsonDecode(response.body);
    var result = apiResponse["status"];

    return result;
  }
}

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.id,
    required this.beginDate,
    required this.customerName,
    required this.phoneNumber,
    required this.weight,
    required this.service,
    required this.grandTotal,
    required this.estimateDate,
    this.endDate,
    required this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String beginDate;
  String customerName;
  String phoneNumber;
  double weight;
  String service;
  double grandTotal;
  String estimateDate;
  String? endDate;
  String status;
  String? description;
  String? createdAt;
  String? updatedAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        beginDate: json["begin_date"].toString(),
        customerName: json["customer_name"],
        phoneNumber: json["phone_number"],
        weight: json["weight"].toDouble(),
        service: json["service"],
        grandTotal: json["grand_total"].toDouble(),
        estimateDate: json["estimate_date"].toString(),
        endDate: json["end_date"].toString(),
        status: json["status"],
        description: json["description"],
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "beginDate": beginDate,
        "customerName": customerName,
        "phoneNumber": phoneNumber,
        "weight": weight,
        "service": service,
        "grandTotal": grandTotal,
        "estimateDate": estimateDate,
        "endDate": endDate,
        "status": status,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

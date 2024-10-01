
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/common/common_functions/show_toast.dart';
import 'package:shoe_app/views/add_orders/model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isQuantityValidated = true;
  bool isSellingPriceValidated = true;
  bool isProfitPriceValidated = true;
  bool isNameValidated = true;
  bool isPhoneNoValidated = true;
  bool isPlaceValidated = true;
  bool isDistrictValidated = true;
  bool isStateValidated = true;
  bool isAdressValidated = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime selectedTime = DateTime.now();
  List<OrderModel> allOrderList = [];
  List<OrderModel> filteredList = [];
  List<DateTime> selectedDateRange = [];

  void updateDateRange(DateTime start, DateTime end) {
    selectedDateRange = [start, end];
    filterOrders(start, end);
    notifyListeners();
  }

  void clearDateRange() {
    selectedDateRange = [];
    notifyListeners();
  }

// validations
  void quantityValidation(bool isValidated) {
    isQuantityValidated = isValidated;
    notifyListeners();
  }

  void sellingPriceValidation(bool isValidated) {
    isSellingPriceValidated = isValidated;
    notifyListeners();
  }

  void profitPriceValidation(bool isValidated) {
    isProfitPriceValidated = isValidated;
    notifyListeners();
  }

  void nameValidation(bool isValidated) {
    isNameValidated = isValidated;
    notifyListeners();
  }

  void phoneNoValidation(bool isValidated) {
    isPhoneNoValidated = isValidated;
    notifyListeners();
  }

  void placeValidation(bool isValidated) {
    isPlaceValidated = isValidated;
    notifyListeners();
  }

  void districtValidation(bool isValidated) {
    isDistrictValidated = isValidated;
    notifyListeners();
  }

  void stateValidation(bool isValidated) {
    isStateValidated = isValidated;
    notifyListeners();
  }

  void adressValidation(bool isValidated) {
    isAdressValidated = isValidated;
    notifyListeners();
  }

// to add a new order
  Future<void> addOrders(OrderModel order) async {
    isLoading = true;
    notifyListeners();
    try {
      final orderReference = firestore.collection("orders");
      final orderref = await orderReference.add(order.toMap(order));

      final id = orderref.id;
      await orderReference.doc(id).update({"orderId": id});
      showToast("order added successfully");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getOrders() async {
    try {
      final orderRef = firestore.collection("orders");
      final data = await orderRef.get();
      final docs = data.docs;
      final orderList = docs.map(
        (order) {
          return OrderModel.fromMap(order.data());
        },
      ).toList();
      allOrderList = [];
      allOrderList = orderList;
      print(allOrderList);
      print("orderlist length is ${allOrderList.length}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterOrders(DateTime startDate, DateTime endDate) async {
    isLoading = true;
    notifyListeners();

    try {
      final orderRef = firestore.collection("orders");
      final data = await orderRef.get();
      final docs = data.docs;
      final orderList = docs.map(
        (order) {
          return OrderModel.fromMap(order.data());
        },
      ).toList();
      // Filter orders by date range

      print("the start date is $startDate");
      print("the end date is $endDate");

      List<OrderModel> filteredOrders = orderList.where((order) {
        DateTime? date = DateTime.tryParse(order.orderDate ?? "");
        print("the checking date is $date");
        return date!.isAfter(startDate) && date.isBefore(endDate) ||
            date == startDate ||
            date == endDate;
      }).toList();

      // Sort the filtered orders by date (newest first)
      filteredOrders.sort((a, b) => b.orderDate!.compareTo(a.orderDate ?? ""));
      allOrderList = [];
      allOrderList = filteredOrders;
      print(filteredOrders.length);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeOrder(String orderId) async {
    isLoading = true;
    notifyListeners();
    try {
      await firestore
          .collection("orders")
          .doc(orderId)
          .update({"orderCompleted": true});
      getOrders();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}

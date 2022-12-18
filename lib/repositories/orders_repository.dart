import 'dart:convert';
import 'package:flash/models/order_response.dart';
import 'package:flash/models/orders_count_response.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/login_response.dart';

class OrderRepository {
  Future<OrderResponse> getOrdersTodayResponse(store_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/today/$store_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    return orderResponseFromJson(response.body.toString());
  }
  Future<OrderResponse> getAllOrdersResponse(store_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/all/$store_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    return orderResponseFromJson(response.body.toString());
  }
  Future<OrderResponse> getOrdersByStatusResponse(store_id, status_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/by-status/$store_id/$status_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    return orderResponseFromJson(response.body.toString());
  }
  Future<OrderResponse> getOrdersWeekResponse(store_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/last-week/$store_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    return orderResponseFromJson(response.body.toString());
  }

  Future<OrdersCountResponse> getOrdersCountResponse(store_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/available/count/$store_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    return ordersCountResponseFromJson(response.body.toString());
  }
  Future<OrdersCountResponse> getDeliveredOrdersCountResponse(store_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/delivered/count/$store_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    print(response.body.toString());
    return ordersCountResponseFromJson(response.body.toString());
  }

  Future<OrdersCountResponse> getCanceledOrdersCountResponse(store_id) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/orders/canceled/count/$store_id");
    final response = await http.get(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        });

    return ordersCountResponseFromJson(response.body.toString());
  }


}

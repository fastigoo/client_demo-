import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';

class PlaceOrderScreen extends GetView<CartController> {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Order Placed'),
      ),
    );
  }
}

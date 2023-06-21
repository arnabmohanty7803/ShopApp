import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final double price;

  PriceCard({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.local_offer,
              color: Colors.deepOrangeAccent,
            ),
          ),
          Text(
            'Rs ${price.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

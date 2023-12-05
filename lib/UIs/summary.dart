import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [

            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),

            buildSummaryRow('Total Price', '₹$totalPrice',
                fontSize: 20, isBold: true),

            ElevatedButton(
              onPressed: () {
                print('Order Confirmed');
              },
              child: Text('Confirm Order'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryRow(String title, String value,
      {double fontSize = 18, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

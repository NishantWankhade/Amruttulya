import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final String itemName;
  final String price;
  final String quantity;

  Summary({
    required this.itemName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = double.parse(price) * double.parse(quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        centerTitle: true,
        elevation: 0, // Remove app bar elevation for a modern look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch widgets to fill the width
          children: [
            // Rows for Item Name, Quantity, Price
            buildSummaryRow('Item Name', itemName),
            buildSummaryRow('Quantity', quantity),
            buildSummaryRow('Price', '₹$price'),
            SizedBox(height: 24),

            Divider(
                color: Colors.grey[300],
                thickness: 1), // Use a lighter color for the divider
            SizedBox(height: 24),

            // Row for Total Price
            buildSummaryRow('Total Price', '₹$totalPrice',
                fontSize: 20, isBold: true),
            SizedBox(height: 32),

            // Confirm Order Button
            ElevatedButton(
              onPressed: () {
                // Add your logic for confirming the order
                // This is just a placeholder for demonstration purposes
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

  // Function to build consistent summary rows
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

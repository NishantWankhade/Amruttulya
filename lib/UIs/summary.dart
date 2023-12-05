import 'package:flutter/material.dart';
import 'package:ashwini_amruttulya/classes/itm.dart'
    as custom_item; // alias 'custom_item' for clarity
import 'package:ashwini_amruttulya/Global/variables.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calculate total price based on current order details
    double totalPrice = calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row for Item Name, Quantity, and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Qnt',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),

            // ListView.builder for dynamic rows based on current_transaction
            Expanded(
              child: ListView.builder(
                itemCount: current_transaction.length,
                itemBuilder: (context, index) {
                  String itemName = current_transaction.keys.elementAt(index);
                  custom_item.Item item = current_transaction[itemName]!;
                  return buildSummaryRow(item.itm_name, item.itm_qnt.toString(),
                      '₹${calculatePrice(item)}');
                },
              ),
            ),

            Divider(color: Colors.grey[300], thickness: 1),
            SizedBox(height: 24),

            // Row for Total Price
            buildSummaryRow('Total Price', '', '₹$totalPrice',
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

  // Function to calculate the total price based on current order details
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    current_transaction.forEach((itemName, item) {
      totalPrice += calculatePrice(item);
    });
    return totalPrice;
  }

  // Function to calculate the price based on item details
  double calculatePrice(custom_item.Item item) {
    return double.parse(item.itm_price.toString()) *
        double.parse(item.itm_qnt.toString());
  }

// Inside the buildSummaryRow function
  Widget buildSummaryRow(String title, String quantity, String value,
      {double fontSize = 18, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Use Tooltip for Item Name with a specific region and scrolling
          Container(
            width: 150, // Adjust as needed
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Tooltip(
                message: title,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Text(
            quantity,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
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

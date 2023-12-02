import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({
    super.key,
  });

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: 'Enter the Item',
                    labelText: 'Item',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: NumberInputWithIncrementDecrement(
                controller: TextEditingController(),
                initialValue: 1,
                numberFieldDecoration: InputDecoration(
                  border: InputBorder.none,
                ),
                widgetContainerDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 2,
                  ),
                ),
                incIconDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                separateIcons: true,
                decIconDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                incIconSize: 30,
                decIconSize: 30,
                incIcon: Icons.add,
                decIcon: Icons.remove,
                buttonArrangement: ButtonArrangement.incRightDecLeft,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:ashwini_amruttulya/Global/variables.dart';
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
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _qntController = TextEditingController();

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
                  controller: _itemController,
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
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
                controller: _qntController,
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
        Expanded(
          child: ItemList(itmName: _itemController, price: _priceController),
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  child: Text(
                    "Proceed",
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.itmName,
    this.price,
  });
  final itmName;
  final price;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 5
                  : 3,
        ),
        itemCount: itmList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('${itmList.keys.elementAt(index)}'),
              onPressed: () {
                itmName.text = itmList.keys.elementAt(index).toString();
                price.text = itmList.values.elementAt(index).toString();
              },
            ),
          );
        },
      ),
    );
  }
}

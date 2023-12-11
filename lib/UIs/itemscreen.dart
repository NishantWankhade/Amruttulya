import 'package:ashwini_amruttulya/Global/variables.dart';
import 'package:ashwini_amruttulya/classes/itm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'summary.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({
    super.key,
  });

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

/// Widget contains :-
/// Column Widget
/// 1st Child -- Row
/// 2nd Child -- Gridview
/// 3rd Child -- Row
///
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
            ///Input field for Item name
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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

            ///Input field for Price of item
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
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

            /// Input field for Quantity of item
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NumberInputWithIncrementDecrement(
                  controller: _qntController,
                  initialValue: 1,
                  isInt: true,
                  numberFieldDecoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  widgetContainerDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  incIconDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  separateIcons: true,
                  decIconDecoration: const BoxDecoration(
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
            ),

            /// Refresh Button to clear the current order details
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  current_transaction.clear();
                  setState(() {
                    clearFields();
                  });
                },
                icon: const Icon(Icons.refresh_rounded),
              ),
            )
          ],
        ),

        ///Widget for generating the Gridview of items
        Flexible(
          child: ItemList(
            itmName: _itemController,
            price: _priceController,
            qnt: _qntController,
          ),
        ),

        /// Row with Add and View Btn
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {
                    add_Item(_itemController, _priceController, _qntController);
                    clearFields();
                    setState(() {});
                  },
                  child: Text("Add"),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        child: Text(
                          "View",
                        ),
                        onPressed: () {
                          // Check if an item is selected
                          if (current_transaction.isEmpty) {
                            // Show a dialog if no item is selected
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Please select an item'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFF760000)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFFfefdff)),
                                      ),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            _navigateToSummary(context);
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: const Color(0xFF760000),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${current_transaction.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _navigateToSummary(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => Summary()),
    );

    if (!mounted) return;

    if (result) {
      setState(() {});
    }
  }

  void clearFields() {
    _itemController.clear();
    _priceController.clear();
    _qntController.text = "1";
  }
}

///Function to add the current item in list of current_transactions
void add_Item(
  TextEditingController _itemController,
  TextEditingController _priceController,
  TextEditingController _qntController,
) {
  Item new_itm = Item();
  new_itm.itm_name = _itemController.text;
  new_itm.itm_price = int.parse(_priceController.text);
  new_itm.itm_qnt = int.parse(_qntController.text);

  if (new_itm.itm_name == Null ||
      new_itm.itm_name == "" ||
      new_itm.itm_price == Null ||
      new_itm.itm_qnt == Null) {
    return;
  }

  if (current_transaction.containsKey(new_itm.itm_name)) {
    final prev_itm = current_transaction[new_itm.itm_name];
    int prev_qnt = prev_itm!.itm_qnt + new_itm.itm_qnt;
    prev_itm.itm_qnt = prev_qnt;

    current_transaction[new_itm.itm_name] = prev_itm;
  } else {
    current_transaction[new_itm.itm_name] = new_itm;
  }
}

/// This Class returns a GridView widget on the basis of the list of items {itmList}
class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.itmName,
    this.price,
    this.qnt,
  });
  final itmName;
  final price;
  final qnt;

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
        itemCount: itmAndPrice.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF760000),
                ), // Set background color of button to dark brown 0xFF9c7e63,0xFF5b191a
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFFfefdff),
                ),
              ),
              child: Text('${itmAndPrice.keys.elementAt(index)}'),
              onPressed: () {
                itmName.text = itmAndPrice.keys.elementAt(index).toString();
                price.text = itmAndPrice.values.elementAt(index).toString();
              },
            ),
          );
        },
      ),
    );
  }
}

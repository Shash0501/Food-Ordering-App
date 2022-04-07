import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/pages/add_item_page.dart';

class MenuPage extends StatefulWidget {
  String restaurantId;
  MenuPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final items = ["Appetizers", "Deserts", "Main courses", "Starters"];
  String category = "Main courses";
  bool veg = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: DropdownButton<String>(
                    elevation: 0,
                    value: category,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text((veg) ? "Veg" : "Non-Veg"),
                      Switch(
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red,
                        value: veg,
                        onChanged: (value) {
                          setState(() {
                            veg = !veg;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddItemPage(
                    restaurantId: widget.restaurantId,
                  )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}


// Details of an Item
// Item name
// Item price
// IsNonveg 
// status Available
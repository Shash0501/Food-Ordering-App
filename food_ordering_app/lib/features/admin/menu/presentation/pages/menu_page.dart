import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/pages/add_item_page.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/widgets/menu_item.dart';

import '../bloc/menu_bloc.dart';

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
  void initState() {
    // TODO: implement initState
    BlocProvider.of<MenuBloc>(context)
        .add(LoadMenu(restaurantId: widget.restaurantId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
              ),
            ],
          ),
          BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is MenuLoaded) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.menuItems.length,
                      itemBuilder: (context, index) {
                        var item = state.menuItems[index];
                        return MenuItemCard(
                            category: item.category,
                            price: item.price,
                            itemName: item.itemName,
                            isVeg: item.isVeg,
                            isAvailable: item.isAvailable);
                      }),
                );
              }
              return Container();
            },
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
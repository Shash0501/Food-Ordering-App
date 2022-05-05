import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/bloc/menu_bloc.dart';
import 'package:googleapis/transcoder/v1.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class AddItemPage extends StatefulWidget {
  String restaurantId;
  AddItemPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final items = ["Appetizers", "Deserts", "Main courses", "Starters"];
  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemPrice = TextEditingController();
  bool veg = true;
  bool available = true;
  // final TextEditingController item  = TextEditingController();
  // final TextEditingController itemName  = TextEditingController();
  String? category;
  var uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is ItemAdded) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: const Text("Add Item"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  BlocProvider.of<MenuBloc>(context).add(AddItem(
                    restaurantId: widget.restaurantId,
                    itemName: itemName.text,
                    price: int.parse(itemPrice.text),
                    category: category!,
                    isVeg: veg,
                    isAvailable: available,
                    description: "Khana acha hai",
                    itemId: uuid.v1(),
                  ));
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: itemName,
                      decoration: InputDecoration(
                        labelText: "Item Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: itemPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )),
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
                    value: category,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: Text((veg) ? "Veg" : "Non-Veg")),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child:
                              Text((available) ? "Available" : "Unavailable")),
                      Switch(
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red,
                        value: available,
                        onChanged: (value) {
                          setState(() {
                            available = !available;
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontSize: 20,
        ),
      ));
}

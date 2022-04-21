import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/bloc/menu_bloc.dart';
import 'package:googleapis/transcoder/v1.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class EditItemPage extends StatefulWidget {
  String restaurantId;
  String itemId;
  String itemName;
  int itemPrice;
  String itemCategory;
  bool isVeg;
  bool isAvailable;
  EditItemPage(
      {Key? key,
      required this.restaurantId,
      required this.itemId,
      required this.itemName,
      required this.itemPrice,
      required this.itemCategory,
      required this.isVeg,
      required this.isAvailable})
      : super(key: key);

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final items = ["Appetizers", "Deserts", "Main courses", "Starters"];
  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemPrice = TextEditingController();
  late bool veg = widget.isVeg;
  late bool available = widget.isAvailable;
  late String category = widget.itemCategory;
  late var uuid = widget.itemId;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    BlocProvider.of<MenuBloc>(context)
        .add(LoadMenu(restaurantId: widget.restaurantId));
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
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Edit Item"),
            ),
            actions: [
              InkWell(
                child: const Text("Edit Item"),
                onTap: () {
                  print(itemName.text);
                  print(itemPrice.text);
                  print(category);
                  print(veg);
                  print(available);
                  print(uuid);

                  BlocProvider.of<MenuBloc>(context).add(EditItem(
                    restaurantId: widget.restaurantId,
                    itemName: itemName.text,
                    price: int.parse(itemPrice.text),
                    category: category,
                    isVeg: veg,
                    isAvailable: available,
                    description: "Khana acha hai",
                    itemId: uuid,
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: itemName..text = widget.itemName,
                      decoration: const InputDecoration(labelText: "Item Name"),
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: itemPrice..text = widget.itemPrice.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Price"),
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
                      if (mounted) {
                        setState(() {
                          category = value!;
                        });
                      }
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text((available) ? "Available" : "Unavailable"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
                            inactiveTrackColor: Colors.red,
                            value: available,
                            onChanged: (value) {
                              setState(() {
                                available = !available;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}

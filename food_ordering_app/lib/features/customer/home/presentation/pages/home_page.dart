import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../../../../../cache/ids.dart';
import '../bloc/homepage_bloc.dart';
import '../widgets/counter.dart';
import 'cart_page.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  void initState() {
    var box = Hive.box<Id>("restaurantIds");
    BlocProvider.of<HomepageBloc>(context).add(CacheRestaurantIds());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              final googleSignIn = GoogleSignIn();
              await googleSignIn.disconnect();
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                      child: Text('Restaurant $index'),
                    ),
                  );
                }),
          ),
          BlocBuilder<HomepageBloc, HomepageState>(
            builder: (context, state) {
              if (state is MenuLoaded) {
                print(state.menu.length);
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.menu.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.amber,
                            title: Text(state.menu[index].itemName),
                            subtitle: Text(
                                state.menu[index].restaurantId.substring(0, 4)),
                            trailing: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                              child: CounterWidget(
                                menuItem: state.menu[index],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else if (state is Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DataCachedSuccesfully) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  BlocProvider.of<HomepageBloc>(context).add(Menu());
                });
                return Container();
              } else {
                return Center(child: Text("Some Error Occured"));
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.bakery_dining_rounded),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CartPage()));
          }),
    );
  }
}

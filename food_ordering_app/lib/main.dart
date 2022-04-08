import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/authentication/bloc/sign_in_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/bloc/menu_bloc.dart';

import 'authentication/page/sign_in.dart';
import 'features/admin/admin_page.dart';
import 'features/admin/order/presentation/bloc/order_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(),
        ),
        BlocProvider<MenuBloc>(create: (context) => MenuBloc()),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CPing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (snapshot.hasData) {
                return BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    if (state is AuthenticationSuccess && state.isAdmin) {
                      return MyAdminPage(restaurantId: state.restaurantId!);
                    } else if (state is AuthenticationSuccess) {
                      return MyHomePage(title: "Asd");
                    } else {
                      WidgetsBinding.instance!.addPostFrameCallback((a) {
                        BlocProvider.of<SignInBloc>(context)
                            .add(CheckIsAdmin());
                      });
                      return const LoadingPage();
                    }
                  },
                );
                // return BlocBuilder<SignInBloc, SignInState>(
                //   builder: (context, state) {
                //     if(state is AuthenticationSuccess && state.){

                //     }
                //     return MyHomePage(
                //       title: "hello",
                //     );
                //   },
                // );
              } else {
                return const SignInPage();
              }
            }),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<SignInBloc>(context).add(AuthenticationLogOut());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("admin_list")
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      if (FirebaseAuth.instance.currentUser?.email ==
                          element.id) {
                        print(element.id);
                      }
                    });
                  });

                  // CODE TO CREATE A NEW DOCUMENT WITH THE KEY (email of the user) UNDER THE COLLECTION "CUSTOMERS"
                  // dynamic doc = FirebaseFirestore.instance
                  //     .collection("customer")
                  //     .doc("a123123dasdasdasd");

                  // final json = {
                  //   "name": FirebaseAuth.instance.currentUser?.displayName,
                  //   "email":
                  //       FirebaseAuth.instance.currentUser?.email.toString(),
                  //   "phone": FirebaseAuth.instance.currentUser?.phoneNumber,
                  // };

                  // doc.set(json);

                  // // This will help us create collection order under the document of that particular user

                  // final orderJson = {
                  //   "order": [
                  //     {
                  //       "item_id": "item_id",
                  //       "item": "paneer tikka",
                  //       "quantity": 1,
                  //       "price": 200,
                  //     },
                  //     {
                  //       "item_id": "item_id",
                  //       "item": "chicken tikka",
                  //       "quantity": 1,
                  //       "price": 200,
                  //     },
                  //   ],
                  //   "order_date": DateTime.now(),
                  //   "order_status": "pending",
                  //   "order_total": 400,
                  //   "rating_given": 5,
                  //   "restaurant_id": "1290301923123",
                  // };
                  // doc.collection("orders").doc().set(orderJson);

                  // // This will help us to to create a document of the restaurant under the collection "restaurants"

                  // final restaurantJson = {
                  //   "name": "Pizza Hut",
                  //   "address": "Sector-12, Noida",
                  //   "phone": "1234567890",
                  //   "email": "abc@gmail.com",
                  //   "rating": 4.5,
                  //   "rating_count": 10
                  // };
                  // dynamic restaurant = FirebaseFirestore.instance
                  //     .collection("restaurants")
                  //     .doc();
                  // await FirebaseFirestore.instance
                  //     .collection("mujhe nahi malunn")
                  //     .doc();
                  // await FirebaseFirestore.instance
                  //     .collection("mujhe nahi malunn")
                  //     .doc()
                  //     .set({"name": "hello"});
                  // FirebaseFirestore.instance
                  //     .collection("restaurants")
                  //     .doc()
                  //     .collection("menu")
                  //     .doc("Non-Vegetarian")
                  //     .collection("deserts")
                  //     .doc()
                  //     .set({"name": "Ice Cream", "price": 100});
                  // // restaurant.collection("menu").doc("Vegetarian");
                  // FirebaseFirestore.instance.collection("mujhenahi poaat");
                  // //
                  // DocumentSnapshot a = await FirebaseFirestore.instance
                  //     .collection("customer")
                  //     .doc("TeDvAj211zflK1pF2a65")
                  //     .collection("details")
                  //     .doc("WHL3pkzXDbndI3moeGZF")
                  //     .get();
                  // print(a.data());
                  // FirebaseFirestore.instance.doc();
                },
                child: Text("press")),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

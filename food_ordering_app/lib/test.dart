// CODE TO CREATE A NEW DOCUMENT WITH THE KEY (email of the user) UNDER THE COLLECTION "CUSTOMERS"
//                   dynamic doc = FirebaseFirestore.instance
//                       .collection("customer")
//                       .doc("a123123dasdasdasd");

//                   final json = {
//                     "name": FirebaseAuth.instance.currentUser?.displayName,
//                     "email":
//                         FirebaseAuth.instance.currentUser?.email.toString(),
//                     "phone": FirebaseAuth.instance.currentUser?.phoneNumber,
//                   };

//                   doc.set(json);

                  // This will help us create collection order under the document of that particular user

//                   final orderJson = {
//                     "order": [
//                       {
//                         "item_id": "item_id",
//                         "item": "paneer tikka",
//                         "quantity": 1,
//                         "price": 200,
//                       },
//                       {
//                         "item_id": "item_id",
//                         "item": "chicken tikka",
//                         "quantity": 1,
//                         "price": 200,
//                       },
//                     ],
//                     "order_date": DateTime.now(),
//                     "order_status": "pending",
//                     "order_total": 400,
//                     "rating_given": 5,
//                     "restaurant_id": "1290301923123",
//                   };
//                   doc.collection("orders").doc().set(orderJson);

                  // This will help us to to create a document of the restaurant under the collection "restaurants"

//                   final restaurantJson = {
//                     "name": "Pizza Hut",
//                     "address": "Sector-12, Noida",
//                     "phone": "1234567890",
//                     "email": "abc@gmail.com",
//                     "rating": 4.5,
//                     "rating_count": 10
//                   };
//                   dynamic restaurant = FirebaseFirestore.instance
//                       .collection("restaurants")
//                       .doc();
//                   await FirebaseFirestore.instance
//                       .collection("mujhe nahi malunn")
//                       .doc();
//                   await FirebaseFirestore.instance
//                       .collection("mujhe nahi malunn")
//                       .doc()
//                       .set({"name": "hello"});
//                   FirebaseFirestore.instance
//                       .collection("restaurants")
//                       .doc()
//                       .collection("menu")
//                       .doc("Non-Vegetarian")
//                       .collection("deserts")
//                       .doc()
//                       .set({"name": "Ice Cream", "price": 100});
                  // restaurant.collection("menu").doc("Vegetarian");
//                   FirebaseFirestore.instance.collection("mujhenahi poaat");
//                   //
//                   DocumentSnapshot a = await FirebaseFirestore.instance
//                       .collection("customer")
//                       .doc("TeDvAj211zflK1pF2a65")
//                       .collection("details")
//                       .doc("WHL3pkzXDbndI3moeGZF")
//                       .get();
//                   print(a.data());
//                   FirebaseFirestore.instance.doc();

// orderIds.forEach((orderId) async {
      //   a = await FirebaseFirestore.instance
      //       .collection("orders")
      //       .get()
      //       .then((value) {
      //     value.docs.forEach((doc) {
      //       if (doc.id == orderId) {
      //         print("lknasd");
      //         orders.add(OrderItemModel.fromJson(doc.data()));
      //       }
      //     });
      //     return orders;
      // //   });
      // // });


      // await FirebaseFirestore.instance.collection("orders").get().then((value) {
      //   value.docs.forEach((doc) {
      //     if (orderIds.contains(doc.id)) {
      //       orders.add(OrderItemModel.fromJson(doc.data()));
      //       print(doc.data());
      //     }
      //   });
      // });



      //  await FirebaseFirestore.instance
      //     .collection("restaurants")
      //     .doc(restaurantId)
      //     .collection("menu")
      //     .get()
      //     .then((value) => {
      //           (value.docs.forEach((element) {
      //             print(element.data());
      //           }))
      //         });


              // dynamic doc = FirebaseFirestore.instance
//                       .collection("customer")
//                       .doc("a123123dasdasdasd");




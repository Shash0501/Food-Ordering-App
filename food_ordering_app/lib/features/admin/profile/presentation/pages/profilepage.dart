// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/profile/data/models/profile_model.dart';

import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  String restaurantId;
  ProfilePage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool hasEdited = false;
  Widget textfield({required hintText, required TEC}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: TEC,
        onChanged: (value) {
          setState(() {
            hasEdited = true;
          });
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
          fillColor: Colors.white10,

          // filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context)
        .add(LoadProfile(restaurantId: widget.restaurantId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return Scaffold(
              body: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/profile.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 270, left: 184),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 140, 8.0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 450,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: textfield(
                                      hintText: state.profile.restaurantName,
                                      TEC: name),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: textfield(
                                      hintText: state.profile.address,
                                      TEC: address),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: textfield(
                                      hintText: state.profile.email,
                                      TEC: email),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: textfield(
                                      hintText: state.profile.phone,
                                      TEC: phone),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomSheet: TextButton(
                  onPressed: !hasEdited
                      ? null
                      : () {
                          FirebaseFirestore.instance
                              .collection("restaurants")
                              .doc(widget.restaurantId)
                              .update({
                            "restaurantName": name.text == ""
                                ? state.profile.restaurantName
                                : name.text,
                            "address": address.text == ""
                                ? state.profile.address
                                : address.text,
                            "email": email.text == ""
                                ? state.profile.email
                                : email.text,
                            "phone": phone.text == ""
                                ? state.profile.phone
                                : phone.text,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile Updated"),
                            duration: Duration(seconds: 1),
                          ));
                          setState(() {
                            name.text = "";
                            address.text = "";
                            email.text = "";
                            phone.text = "";
                            hasEdited = false;
                            BlocProvider.of<ProfileBloc>(context)
                                // ignore: invalid_use_of_visible_for_testing_member
                                .emit(Loading());
                            BlocProvider.of<ProfileBloc>(context).add(
                                LoadProfile(restaurantId: widget.restaurantId));
                          });
                        },
                  child: Text("SAVE")));
        }
        return Container();
      },
    ));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Column(
//             children: [

//               Text(state.profile.restaurantName),
//               Text(state.profile.phone),
//               Text(state.profile.email),
//               Text(state.profile.address),
//             ],
//           )

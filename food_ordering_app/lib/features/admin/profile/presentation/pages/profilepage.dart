import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  String restaurantId;
  ProfilePage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        if (state is ProfileLoaded) {
          return Column(
            children: [
              Text(state.profile.restaurantName),
              Text(state.profile.phone),
              Text(state.profile.email),
              Text(state.profile.address),
            ],
          );
        }
        return Container();
      },
    ));
  }
}

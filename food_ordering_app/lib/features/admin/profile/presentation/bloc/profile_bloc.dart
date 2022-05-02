import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/bloc/menu_bloc.dart';
import 'package:food_ordering_app/features/admin/profile/data/datasources/profile_remote_datasource.dart';
import 'package:food_ordering_app/features/admin/profile/data/repositories/profile_repository_impl.dart';

import '../../data/models/profile_model.dart';
import '../../domain/usecases/getprofile.dart' as gp;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is LoadProfile) {
        emit(Loading());
        gp.LoadProfile loadProfile = gp.LoadProfile(ProfileRepositoryImpl(
            remoteDataSource: ProfileRemoteDataSourceImpl()));

        final result =
            await loadProfile(gp.Params(restaurantId: event.restaurantId));
        result.fold(
            (l) => {print("Failure loading the profile")},
            (r) => {
                  print("Success loading the profile"),
                  print(r),
                  emit(ProfileLoaded(profile: r))
                });
      }
    });
  }
}

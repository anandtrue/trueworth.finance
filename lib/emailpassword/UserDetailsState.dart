import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final Map<String, dynamic> userDetails;
  UserDetailsLoaded(this.userDetails);
}

class UserDetailsError extends UserDetailsState {
  final String message;
  UserDetailsError(this.message);
}

class UserDetailsEvent {}

class SaveUserDetails extends UserDetailsEvent {
  final String mobile;
  final String fullName;
  final String pan;
  final String uid;
  SaveUserDetails(this.mobile,this.fullName, this.pan, this.uid);
}

class FetchUserDetails extends UserDetailsEvent {
  final String uid;
  FetchUserDetails(this.uid);
}

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<SaveUserDetails>((event, emit) async {
      emit(UserDetailsLoading());
      try {
        await _firestore.collection('users').doc(event.uid).set({
          'fullName': event.fullName,
          'pan': event.pan,
          'mobile': event.mobile,
        });
        emit(UserDetailsLoaded({'fullName': event.fullName, 'pan': event.pan, 'mobile': event.mobile}));
      } catch (e) {
        emit(UserDetailsError(e.toString()));
      }
    });

    on<FetchUserDetails>((event, emit) async {
      emit(UserDetailsLoading());
      try {
        final doc =
            await _firestore.collection('users').doc(event.uid).get();
        emit(UserDetailsLoaded(doc.data()!));
      } catch (e) {
        emit(UserDetailsError(e.toString()));
      }
    });
  }
}

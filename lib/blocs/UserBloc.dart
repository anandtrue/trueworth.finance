import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trueworthfinance/blocs/UserEvent.dart';
import 'package:trueworthfinance/blocs/UserState.dart';
import 'package:trueworthfinance/data/UserModel.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SaveUserEvent>(_saveUser);
    on<LoadUserEvent>(_loadUser);
  }

  Future<void> _saveUser(SaveUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final doc = FirebaseFirestore.instance.collection('users').doc('userDetails');
      final user = UserModel(name: event.name, email: event.email, panCard: event.panCard);
      await doc.set(user.toMap());
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to save user: $e'));
    }
  }

  Future<void> _loadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc('userDetails').get();
      if (doc.exists) {
        final user = UserModel.fromMap(doc.data()!);
        emit(UserLoaded(user));
      } else {
        emit(UserError('No user data found'));
      }
    } catch (e) {
      emit(UserError('Failed to load user: $e'));
    }
  }
}

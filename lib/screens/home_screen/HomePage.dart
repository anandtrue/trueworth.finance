import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trueworthfinance/blocs/UserBloc.dart';
import 'package:trueworthfinance/blocs/UserState.dart';
import 'package:trueworthfinance/custom/CustomBottomNav.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name: ${state.user.name}"),
                  Text("Email: ${state.user.email}"),
                  Text("PAN: ${state.user.panCard}"),
                ],
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No Data"));
        },
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}

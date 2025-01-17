import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/features/auth/presentation/view/login_view.dart';
import 'package:loot_vault/features/home/presentation/view_model/home_state.dart';



class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index){
    emit(state.copyWith(selectedIndex:index));
  }

  // void logout(BuildContext context){
  //   Future.delayed(const Duration(seconds: 1),()async{
  //     if(context.mounted){
  //       Navigator.pushReplacement(
  //         context, 
  //         MaterialPageRoute(builder: (context)=>BlocProvider.value(value:getIt() ,child:const LoginView(),))
  //       );
  //     }
  //   });
  // }
  
}

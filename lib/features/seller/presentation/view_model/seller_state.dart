import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SellerState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const SellerState({
    required this.selectedIndex,
    required this.views,
  });

  SellerState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return SellerState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object> get props => [selectedIndex, views];
}
import 'package:equatable/equatable.dart';

class ForumState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const ForumState({required this.isLoading, required this.isSuccess});

  const ForumState.initial()
      : isLoading = false,
        isSuccess = false;

  ForumState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ForumState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isSuccess];
}

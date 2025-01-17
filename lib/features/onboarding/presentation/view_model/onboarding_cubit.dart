import 'package:bloc/bloc.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_state.dart';


class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState.initial());

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage(int maxPages) {
    if (state.currentPage < maxPages - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void skipToLastPage(int lastPage) {
    emit(state.copyWith(currentPage: lastPage));
  }
}

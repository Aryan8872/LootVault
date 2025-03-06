import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/app/widget/shadow_inputbox.dart';
import 'package:loot_vault/features/auth/presentation/view/login_view.dart';
import 'package:loot_vault/features/auth/presentation/view/register_view.dart';
import 'package:loot_vault/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends Mock implements LoginBloc {
  @override
  Stream<LoginState> get stream => const Stream<LoginState>.empty();

  @override
  Future<void> close() async {}
}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  Widget createLoginView() {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (context) => mockLoginBloc,
        child: const LoginView(),
      ),
    );
  }

  testWidgets('LoginView renders correctly', (tester) async {
    await tester.pumpWidget(createLoginView());

    // Check if the logo is rendered
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Check if the "LOGIN" text is rendered
    expect(find.text('LOGIN'), findsOneWidget);

    // Check if the email field is rendered
    expect(find.byType(ShadowInputbox).first, findsOneWidget);

    // Check if the password field is rendered
    expect(find.byType(ShadowInputbox).last, findsOneWidget);

    // Check if the "Forgot password?" text is rendered
    expect(find.text('Forgot password ?'), findsOneWidget);

    // Check if the "Sign in" button is rendered
    expect(find.text('Sign in'), findsOneWidget);

    // Check if the "Don\'t have an account?" and "Create one" text are rendered
    expect(find.text('Don\'t have an account?'), findsOneWidget);
    expect(find.text('Create one'), findsOneWidget);
  });

  testWidgets('Email field validation works correctly', (tester) async {
    await tester.pumpWidget(createLoginView());

    // Find the email field
    final emailField = find.byType(ShadowInputbox).first;

    // Enter an invalid email
    await tester.enterText(emailField, 'invalid_email');

    // Find the "Sign in" button and tap it to trigger form submission
    await tester.tap(find.text('Sign in'));
    await tester.pump();

    // Ensure the form is rebuilt to show the validation error
    await tester.pump();

    // Check if the error message is displayed
    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });
  testWidgets('Password field validation works correctly', (tester) async {
    await tester.pumpWidget(createLoginView());

    // Find the password field
    final passwordField = find.byType(ShadowInputbox).last;

    // Enter an invalid password
    await tester.enterText(passwordField, 'short');

    // Find the "Sign in" button and tap it to trigger form submission
    await tester.tap(find.text('Sign in'));
    await tester.pump();

    // Ensure the form is rebuilt to show the validation error
    await tester.pump();

    // Check if the error message is displayed
    expect(find.text('Password must be at least 6 characters long'),
        findsOneWidget);
  });


}

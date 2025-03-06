import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/widget/shadow_inputbox.dart';
import 'package:loot_vault/features/auth/presentation/view/register_view.dart';
import 'package:loot_vault/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    getIt.reset(); // Reset GetIt to clear previous registrations
    getIt.registerSingleton<RegisterBloc>(mockRegisterBloc);
  });

  tearDown(() {
    getIt.reset(); // Reset GetIt after each test
  });

  Widget createRegisterView() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: mockRegisterBloc,
        child: const RegisterView(),
      ),
    );
  }

  testWidgets('RegisterView renders correctly', (tester) async {
    await tester.pumpWidget(createRegisterView());

    // Check if the logo is rendered
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Check if the "REGISTER" text is rendered
    expect(find.text('REGISTER'), findsOneWidget);

    // Check if the form fields are rendered
    expect(find.byType(ShadowInputbox), findsNWidgets(5));

    // Check if the "Sign up" button is rendered
    expect(find.text('Sign up'), findsOneWidget);

    // Check if the "Already have an account?" and "Login" text are rendered
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Sign up button is rendered correctly', (tester) async {
    await tester.pumpWidget(createRegisterView());

    // Check if the "Sign up" button is rendered
    expect(find.text('Sign up'), findsOneWidget);
  });

  testWidgets('Form fields are rendered correctly', (tester) async {
    await tester.pumpWidget(createRegisterView());

    // Check if the form fields are rendered
    expect(find.byType(ShadowInputbox), findsNWidgets(5));

    // Check if the labels of the form fields are correct
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets(
      'Image picker modal bottom sheet is shown when the logo is tapped',
      (tester) async {
    await tester.pumpWidget(createRegisterView());

    // Find the logo and tap it
    final logo = find.byType(CircleAvatar);
    await tester.tap(logo);
    await tester.pumpAndSettle();

    // Check if the modal bottom sheet is shown
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
  });

  testWidgets(
      'Image picker modal bottom sheet is shown when the logo is tapped',
      (tester) async {
    await tester.pumpWidget(createRegisterView());

    // Find the logo and tap it
    final logo = find.byType(CircleAvatar);
    await tester.tap(logo);
    await tester.pumpAndSettle();

    // Check if the modal bottom sheet is shown
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
  });
}

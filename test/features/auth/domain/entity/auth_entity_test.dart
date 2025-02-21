import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

void main() {
  const auth1 = AuthEntity(
    userId: "2343423123124",
    email: "e@gmail.com",
    fullName: "aryanb",
    image: "image",
    phoneNo: "98010119909",
    username: "ab",
    password: "ab123",
  );

  const auth2 = AuthEntity(
    userId: "2343423123124",
    email: "e@gmail.com",
    fullName: "aryanb",
    image: "image",
    phoneNo: "98010119909",
    username: "ab",
    password: "ab123",
  );
  test('Test 2:  Two AuthEntity objects with the same values should be equal',
      () {
    expect(auth1, auth2); // Should be equal to itself
  });
}

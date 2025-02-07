import 'package:flutter_test/flutter_test.dart';
import 'package:loot_vault/features/auth/data/model/auth_api_model.dart';
import 'package:loot_vault/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthApiModel Tests', () {
    final json = {
      '_id': '123',
      'fullName': 'John Doe',
      'userName': 'johndoe',
      'email': 'john@example.com',
      'phoneNo': '1234567890',
      'password': 'password123',
      'image': 'profile.jpg',
    };

    test('should convert from JSON correctly', () {
      final model = AuthApiModel.fromJson(json);

      expect(model.userId, '123');
      expect(model.fullName, 'John Doe');
      expect(model.userName, 'johndoe');
      expect(model.email, 'john@example.com');
      expect(model.phoneNo, '1234567890');
      expect(model.password, 'password123');
      expect(model.image, 'profile.jpg');
    });

    test('should convert to JSON correctly', () {
      final model = AuthApiModel.fromJson(json);
      final convertedJson = model.toJson();

      expect(convertedJson['_id'], '123');
      expect(convertedJson['fullName'], 'John Doe');
      expect(convertedJson['userName'], 'johndoe');
    });

    test('should convert between Entity and Model correctly', () {
      const entity = AuthEntity(
        userId: '123',
        username: 'johndoe',
        fullName: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        phoneNo: '1234567890',
        image: 'profile.jpg',
      );

      final model = AuthApiModel.fromEntity(entity);
      final convertedEntity = model.toEntity();

      expect(convertedEntity, equals(entity));
    });
  });
}

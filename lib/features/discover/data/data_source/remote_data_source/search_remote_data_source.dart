class SearchRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  SearchRemoteDataSource(this._dio);

  @override
  Future<String> uploadProfilePicture(File? file) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          file!.path,
          filename:
              file.path.split('/').last, // Use the filename from the file path
        ),
      });
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return "image uploaded sucessfully";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> createUser(AuthEntity entity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.registerStudent, data: {
        "fullName": entity.fullName,
        "username": entity.username,
        "email": entity.email,
        "phoneNo": entity.phoneNo,
        "password": entity.password,
        "image": entity.image
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<AuthHiveModel>> getalluser() {
    // TODO: implement getalluser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.loginStudent,
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return jsonEncode(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> changePassword(
      String userId, String currentPassword, String newPassword) async {
    final response = await _dio.post(
      ApiEndpoints.changePassword,
      data: {
        'userId': userId,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to change password');
    }
  }

  @override
  Future<AuthApiModel> updateProfile(AuthEntity user) async {
    final userId = user.userId;
    final response = await _dio.put(
      '${ApiEndpoints.updateProfile}$userId',
      data: {
        "fullName":user.fullName,
        "email":user.email,
        "username":user.username,
        "phoneNo":user.phoneNo,
        "password":user.password,
        "image":user.image
      },
    );

    if (response.statusCode == 200) {
      var data =  AuthApiModel.fromJson(jsonDecode(response.data));
      return data;
    } else {
      throw Exception('Failed to update profile');
    }
  }

  @override
  Future<AuthApiModel> getUserData(String userId) async {
    final response = await _dio.get(
      '${ApiEndpoints.getUserbyId}$userId',
    );
    print('user data get vako ${response.data}');

    if (response.statusCode == 200) {
      final apimodel =  AuthApiModel.fromJson(response.data['user']);
      print('after converting to the apimodel ${apimodel}');
      return apimodel;
    } else {
      throw Exception('Failed to update get data');
    }
  }
}
class ApiEndpoints {
  ApiEndpoints._(); // private constructor

  static const Duration ConnectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:3000/api";

// ============================Auth Routes ==================================

  // ============================Course Routes ==================================

  static const String createCourse = "/course/createCourse";
  static const String getAllCourse = "/course/getAllCourse";

// ================================= Batch Routes ============================
  static const String createBatch = "/batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";

  //auth

  static const String registerStudent = "/auth/register";
  static const String loginStudent = "/auth/login";
  static const String uploadImage = "/customer/uploadImage";

  //games

  static const String getAllgames = "/game/";
  static const String addGame = "/game/add";

  //gamecategory
  static const String getallGameCategories = "/category/game/all";

  //skins
  static const String getAllSkins = "/game/";
  static const String addSkins = "/game/add";

  //forum
  static const String getAllPosts = "/forum/posts/";
  static const String createPost = "/forum/posts";
  static const String likePost = "/forum/posts/like/";
  static const String disLikePost = "/forum/posts/dislike/";
  static const String createComment = "/forum/posts/comments/";
  static const String editPost = "/forum/posts/";
  static const String deletePost = "/forum/posts/";
  static const String replyComment =
      "/forum/posts/{postId}/comments/{commentId}/reply";

  static const String getComments = "/forum/posts/comments/get/";
}

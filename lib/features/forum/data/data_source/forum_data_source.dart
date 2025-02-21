abstract interface class IForumDataSource {
  Future<void> getAllPosts();
  Future<String> createPost();
  Future<String> likePost();
  Future<String> disLikePost();
  Future<String> commentPost();
  Future<void> getPostDetails();
}

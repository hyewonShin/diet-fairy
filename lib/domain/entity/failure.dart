abstract class Failure {
  final String message;
  const Failure(this.message);
}

class CommentFailure extends Failure {
  const CommentFailure(String message) : super(message);
}

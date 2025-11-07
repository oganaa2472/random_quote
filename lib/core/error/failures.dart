// Base Failure class (Domain Layer)
abstract class Failure {
  final String message;
  const Failure(this.message);
}

// Concrete Failure implementations (for Data Layer to return)
class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server failure'}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache failure'}) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure({String message = 'Data parsing error'}) : super(message);
}
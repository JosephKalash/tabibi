abstract class ServiceException implements Exception {}

class ServerException implements ServiceException {}

class HttpException implements ServiceException {
  final message;

  HttpException(this.message);
}
import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/userProfile/domain/entities/person.dart';
import 'package:tabibi/features/userProfile/domain/repositories/person_repository.dart';

class GetPersonInfo extends Usecase {
  final PersonRepo _repo;

  GetPersonInfo(this._repo);

  Person? call() {
    return _repo.fetchPersonInfo();
  }
}

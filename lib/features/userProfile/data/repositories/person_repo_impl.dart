import '../../domain/entities/person.dart';
import '../../domain/repositories/person_repository.dart';
import '../data%20source/person_local_DS.dart';

class PersonRepoImpl extends PersonRepo {
  final PersonLocalDS _localDS;

  PersonRepoImpl(this._localDS);

  @override
  Person? fetchPersonInfo()  {
    final person =  _localDS.getPersonInfoFromLocal();
    return person;
  }
}

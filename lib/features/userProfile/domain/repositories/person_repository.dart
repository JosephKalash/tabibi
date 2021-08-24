import '../entities/person.dart';

abstract class PersonRepo {
  Person? fetchPersonInfo();
}

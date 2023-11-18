import '../../common/base/repository/base_repository.dart';
import 'dogs_base_source.dart';
import 'source/dogs_test_source.dart';
import 'source/dogs_v1_source.dart';

class DogsRepository extends BaseRepository {
  late DogsBaseSource datasource;
  static DogsRepository? _instance;

  factory DogsRepository({bool test = false}) {
    return _instance ??= DogsRepository._internal(test);
  }

  DogsRepository._internal(bool test) {
    // test variable can be obtained from environment or flavor
    if (test) {
      datasource = DogsTestSource();
      return;
    }
    datasource = DogsV1Source();
  }
}

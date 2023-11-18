import '../../../data/repository/dogs/dogs_repository.dart';
import 'models/dog_model.dart';

class DogService {
  final DogsRepository _dogsRepository;
  static DogService? _instance;

  factory DogService() {
    return _instance ??= DogService._internal(dogsRepository: DogsRepository());
  }
  DogService._internal({required DogsRepository dogsRepository})
      : _dogsRepository = dogsRepository;

  Future<List<Dog>> getDogs(
      {int page = 1, int limit = 20, String? query}) async {
    final result =
        await _dogsRepository.datasource.getAllBreds(page, limit, query);
    return result?.map((e) => Dog.fromDTO(e)).toList() ?? [];
  }

  Future<String> getRandomImageByBreed(String breed) async {
    final result =
        await _dogsRepository.datasource.getRandomDogImageByBreed(breed);
    return result!;
  }
}

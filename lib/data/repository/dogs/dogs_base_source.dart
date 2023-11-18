import 'dtos/dog_breed_dto.dart';

typedef RandomDogImage = String;

abstract class DogsBaseSource {
  Future<List<BreedDTO>?> getAllBreds(int page, int limit, String? query);
  Future<RandomDogImage?> getRandomDogImageByBreed(String breed);
}

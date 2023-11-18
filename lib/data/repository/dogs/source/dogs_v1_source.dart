import 'package:dio/dio.dart';

import '../../../../core/utils/app_logger.dart';
import '../../../common/base/response/base_response.dart';
import '../../../common/repository_base_settings.dart';
import '../dogs_base_source.dart';
import '../dtos/dog_breed_dto.dart';

class DogsV1Source with RepositoryBaseSettings implements DogsBaseSource {
  late Dio _network;
  // this property contains service name
  final String _serviceName = 'api/';

  DogsV1Source() {
    _network = Dio(baseOptions);
    try {
      _network.interceptors.addAll(interceptors);
    } catch (err) {
      logMessage(err.toString());
    }
  }

  @override
  Future<List<BreedDTO>?> getAllBreds(
      int page, int limit, String? query) async {
    final response = await _network.get('$_serviceName/breeds/list/all');
    BaseResponse envelopeModel = BaseResponse.fromMap(response.data);
    if (envelopeModel.status) {
      List<BreedDTO> result = [];
      envelopeModel.data
          .forEach((key, value) => result.add(BreedDTO.fromMap(key, List.from(value))));
      return result;
    }
    throw Exception('Status : Failure');
  }

  @override
  Future<RandomDogImage?> getRandomDogImageByBreed(String breed) async {
    final response =
        await _network.get('$_serviceName/breed/$breed/images/random');
    BaseResponse envelopeModel = BaseResponse.fromMap(response.data);
    if (envelopeModel.status) {
      return envelopeModel.data;
    }
    throw Exception('Status : Failure');
  }
}

import 'dart:convert';

import 'package:phodog/data/common/base/response/base_response.dart';
import 'package:phodog/data/repository/dogs/dtos/dog_breed_dto.dart';

import '../dogs_base_source.dart';

class DogsTestSource implements DogsBaseSource {
  @override
  Future<List<BreedDTO>> getAllBreds(int page, int limit, String? query) async {
    String json = """{
   "message":{
      "affenpinscher":[
         
      ],
      "african":[
         
      ],
      "airedale":[
         
      ],
      "akita":[
         
      ],
      "appenzeller":[
         
      ],
      "australian":[
         "kelpie",
         "shepherd"
      ],
      "bakharwal":[
         "indian"
      ]
   },
   "status":"success"
}""";
    Map<String, dynamic> result = jsonDecode(json);
    BaseResponse envelopeModel = BaseResponse.fromMap(result);

    List<BreedDTO> values = [];
    envelopeModel.data.forEach(
        (key, value) => values.add(BreedDTO.fromMap(key, List.from(value))));
    return values
        .where((element) =>
            element.type.toLowerCase().contains(query?.toLowerCase() ?? ''))
        .toList();
  }

  @override
  Future<RandomDogImage> getRandomDogImageByBreed(String breed) async {
    return "https://images.dog.ceo/breeds/wolfhound-irish/n02090721_1979.jpg";
  }
}

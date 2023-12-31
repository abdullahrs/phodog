import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:phodog/core/utils/app_logger.dart';

import '../../../../data/repository/dogs/dtos/dog_breed_dto.dart';

@immutable
class Dog {
  final String name;
  final ImageProvider? imageProvider;
  final List<String> subBreeds;

  const Dog({required this.name, required this.subBreeds, this.imageProvider});

  bool contains(String query) {
    bool result = name.toLowerCase().contains(query);
    for (var e in subBreeds) {
      if (e.toLowerCase().contains(query)) {
        result = true;
        break;
      }
    }
    return result;
  }

  factory Dog.fromDTO(BreedDTO dto) {
    return Dog(
      name: dto.type,
      subBreeds: dto.subType,
    );
  }

  Dog copyWith({
    String? name,
    ImageProvider? imageProvider,
    List<String>? subBreeds,
  }) {
    return Dog(
      name: name ?? this.name,
      imageProvider: imageProvider ?? this.imageProvider,
      subBreeds: subBreeds ?? this.subBreeds,
    );
  }
}

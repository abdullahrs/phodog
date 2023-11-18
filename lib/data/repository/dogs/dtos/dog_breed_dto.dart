class BreedDTO {
  final String type;
  final List<String> subType;

  BreedDTO({required this.type, required this.subType});

  factory BreedDTO.fromMap(String key, List<String> value) {
    return BreedDTO(
      type: key,
      subType: value,
    );
  }
}

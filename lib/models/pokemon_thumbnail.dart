class PokemonThumbnail {
  final String path;
  final String fileExtension;

  PokemonThumbnail({required this.path, required this.fileExtension});

  String get rutaCompleta {
    return '$path.$fileExtension';
  }

  factory PokemonThumbnail.fromMap(Map<String, dynamic> data) {
    return PokemonThumbnail(
      path: data['path'],
      fileExtension: data['extension'],
    );
  }
}

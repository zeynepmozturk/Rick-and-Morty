class CharactersModel {
  final List<CharacterModel> characters;
  final CharacterInfo? info; // Nullable yap

  CharactersModel({required this.characters, this.info}); // required kaldırıldı

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final info = json['info'] != null
        ? CharacterInfo.fromJson(json['info'])
        : null;

    final characters = (json['results'] as List)
        .map((characterJson) => CharacterModel.fromJson(characterJson))
        .toList();

    return CharactersModel(characters: characters, info: info);
  }
}

class CharacterInfo {
  // bu dosya ile apı dan bilgileri alıyoruz cart bilgilerini
  final int count;
  final int pages;
  final String? next; //soru işareti ile null değer alabildiğini belirttik
  final String? prev;

  CharacterInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  CharacterInfo.fromJson(Map<String, dynamic> json)
    : count = json['count'],
      pages = json['pages'],
      next = json['next'],
      prev = json['prev'];
}

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Location location;
  final List<String> episode;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.episode,
  });

  CharacterModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      status = json['status'],
      species = json['species'],
      gender = json['gender'],
      image = json['image'],
      location = Location.fromJson(json['location']),
      episode = List<String>.from(json['episode']);
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});
  Location.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      url = json['url'];
}

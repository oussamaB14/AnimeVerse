class User {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse; // You can omit this field for security reasons
  final List<String> favorisMangas;
  final List<String> favorisAnimes;
  final List<String> historique;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    this.motDePasse = '',
    this.favorisMangas = const [],
    this.favorisAnimes = const [],
    this.historique = const [],
  });

  // Convert a Utilisateur object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'favorisMangas': favorisMangas,
      'favorisAnimes': favorisAnimes,
      'historique': historique,
    };
  }

  // Convert a Map into a Utilisateur object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      favorisMangas: List<String>.from(map['favorisMangas'] ?? []),
      favorisAnimes: List<String>.from(map['favorisAnimes'] ?? []),
      historique: List<String>.from(map['historique'] ?? []),
    );
  }
}

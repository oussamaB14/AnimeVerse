class User {
   String id;
   String nom;
   String prenom;
   String email;
   String motDePasse;
   String userAvatar;
   List<String> favorisMangas;
   List<String> favorisAnimes;
   List<String> historique;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.userAvatar,
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
      'userAvatar': userAvatar,
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
      userAvatar: map['userAvatar'],
      favorisMangas: List<String>.from(map['favorisMangas'] ?? []),
      favorisAnimes: List<String>.from(map['favorisAnimes'] ?? []),
      historique: List<String>.from(map['historique'] ?? []),
    );
  }
}

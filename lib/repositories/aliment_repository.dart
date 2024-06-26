import 'dart:convert';
import 'package:compteur_cal/models/aliment.dart';
import 'package:http/http.dart';

class AlimentRepository {
  final int _apiKeyIndex = 8;

  /// Liste des clés API
  static const List<String> _apiKeys = [
    'afee6413f0984ebdb3237a5b9873d511',
    'a798d2cb4ee14472a43a0c8a05f88c26',
    '4833a0b541654e488090a0ec4a354926',
    'f4460b241265456093440452d6fd0fb9',
    'afee6413f0984ebdb3237a5b9873d511',
    '524cdc2fa8534450bba31b75eb1b0aca',
    '4ed36466a131468082e2f835ecb9a421',
    '5ef6776bce3d4436b1237e8b7b5d78fb',
    'fc79de2479a643a18bc86e48bd7e3d0e',
    '67aa3eeb23d74f8db6571ee4ab84eefe',
    'bba0438bb2c04296aeca5fa18b70b680',
  ];

  /// Appel des ingredients correspondants à une recherche
  Future<List<Aliment>> fetchAliments(String query) async {
    final String apiKey = _apiKeys[_apiKeyIndex];
    final Response response = await get(
      Uri.parse(
        'https://api.spoonacular.com/food/ingredients/search?query=$query&apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final List<Aliment> aliments = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> results = json['results'];

      for (Map<String, dynamic> result in results) {
        final Aliment aliment = Aliment(
          id: result['id'],
          name: result['name'],
          quantity: 0,
          calories: 0,
          glucides: 0,
          proteins: 0,
          fats: 0,
        );

        // Récuperer les détails de l'aliment
        final Aliment alimentData = await fetchAlimentData(aliment.id, apiKey);

        aliments.add(alimentData);
      }

      return aliments;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  /// Appel des informations pour un ingredient
  Future<Aliment> fetchAlimentData(int id, String apiKey) async {
    final Response response = await get(
      Uri.parse(
        'https://api.spoonacular.com/food/ingredients/$id/information?amount=100&unit=grams&apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> nutrients = json['nutrition']['nutrients'];

      final protein =
          nutrients.firstWhere((nutrient) => nutrient['name'] == 'Protein');
      final fat = nutrients.firstWhere((nutrient) => nutrient['name'] == 'Fat');
      final carbohydrates = nutrients
          .firstWhere((nutrient) => nutrient['name'] == 'Carbohydrates');
      final calories =
          nutrients.firstWhere((nutrient) => nutrient['name'] == 'Calories');

      final Aliment aliment = Aliment(
        id: json['id'],
        name: json['name'],
        quantity: json['amount'],
        calories: calories['amount'].toDouble(),
        glucides: carbohydrates['amount'].toDouble(),
        proteins: protein['amount'].toDouble(),
        fats: fat['amount'].toDouble(),
      );

      return aliment;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}

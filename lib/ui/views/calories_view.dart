import 'package:compteur_cal/blocs/aliment_cubit.dart';
import 'package:compteur_cal/blocs/user_cubit.dart';
import 'package:compteur_cal/models/aliment.dart';
import 'package:compteur_cal/ui/widget/aliment_card.dart';
import 'package:compteur_cal/ui/widget/button.dart';
import 'package:compteur_cal/ui/widget/nutriments_box.dart';
import 'package:compteur_cal/ui/theme/app_theme.dart';
import 'package:compteur_cal/ui/widget/progress_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalorieView extends StatefulWidget {
  const CalorieView({super.key});

  @override
  State<CalorieView> createState() => _CalorieViewState();
}

class _CalorieViewState extends State<CalorieView> {
  int userNeeds = 124;

  // Déclaration des variables pour stocker les totaux
  int totalCalories = 0;
  double totalGlucides = 0;
  double totalProteins = 0;
  double totalFats = 0;

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final userNeedsCalories = userCubit.calculateCaloriesNeeds().toInt();

    return BlocBuilder<AlimentCubit, List<Aliment>>(
      builder: (context, state) {
        // Mise à jour des totaux
        totalCalories = 0;
        totalGlucides = 0;
        totalProteins = 0;
        totalFats = 0;
        for (Aliment aliment in state) {
          totalCalories += aliment.calories.toInt();
          totalGlucides += aliment.glucides;
          totalProteins += aliment.proteins;
          totalFats += aliment.fats;
        }

        /// Liste des macronutriments
        List<dynamic> nutriments = <dynamic>[
          // [ nutrimentsName, nutrimentsColor, nutrimentsProgress ]
          <Object>[
            "Glucides",
            AppTheme.pinkRose,
            ((100 * totalGlucides) / (userNeeds * 100))
          ],
          <Object>[
            "Protéines",
            AppTheme.skyBlue,
            ((100 * totalProteins) / (userNeeds * 100))
          ],
          <Object>[
            "Lipides",
            AppTheme.mustardYellow,
            ((100 * totalFats) / (userNeeds * 100))
          ],
          <Object>["Autres", AppTheme.blueViolet, 0.0],
        ];
        DateTime now = DateTime.now();
        List<String> monthNames = <String>[
          '',
          'Janvier',
          'Février',
          'Mars',
          'Avril',
          'Mai',
          'Juin',
          'Juillet',
          'Août',
          'Septembre',
          'Octobre',
          'Novembre',
          'Décembre'
        ];
        String monthName = monthNames[now.month];
        String formattedDate = "${now.day} $monthName";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /// Affichage date du jour
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),

            /// Affichage calories
            Center(
              child: ProgressCircle(
                titleText: totalCalories,
                subtitleText: 'calories',
                percentage:
                    (100 * totalCalories.toDouble()) / userNeedsCalories,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            /// Affichage des macronutriments
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nutriments.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5 / 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return NutrimentsBox(
                  nutrimentsName: nutriments[index][0] as String,
                  nutrimentsColor: nutriments[index][1] as Color,
                  nutrimentsProgress: nutriments[index][2] as double,
                );
              },
            ),

            const SizedBox(
              height: 24,
            ),

            /// Liste des aliments
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Liste des aliments',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      /// Button
                      Button(
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/add_aliment');
                        },
                        buttonText: 'Ajouter',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  /// Aliment cards
                  BlocBuilder<AlimentCubit, List<Aliment>>(
                    builder: (context, List<Aliment> state) {
                      return Column(
                        children: state.map<Column>((Aliment aliment) {
                          return Column(
                            children: <Widget>[
                              AlimentCard(
                                alimentName: aliment.name,
                                colorBackground:
                                    Theme.of(context).colorScheme.background,
                                calories: aliment.calories,
                                glucides: aliment.glucides,
                                proteins: aliment.proteins,
                                fats: aliment.fats,
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

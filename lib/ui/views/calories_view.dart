import 'package:compteur_cal/ui/utils/nutriments_box.dart';
import 'package:compteur_cal/ui/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CalorieView extends StatefulWidget {
  const CalorieView({super.key});

  @override
  State<CalorieView> createState() => _CalorieViewState();
}

class _CalorieViewState extends State<CalorieView> {
  /// Liste des macronutriments
  List<dynamic> nutriments = [
    // [ nutrimentsName, nutrimentsColor, nutrimentsProgress ]
    ["Calories", AppTheme.pinkRose, .75],
    ["Protéines", AppTheme.skyBlue, .50],
    ["Lipides", AppTheme.mustardYellow, .10],
    ["Autres", AppTheme.blueViolet, .20],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Affichage date du jour
        Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '30 mars',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),

        /// Affichage calories
        Center(
          child: CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 20.0,
            percent: 0.6,
            animation: true,
            animationDuration: 1000,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1240",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "Total kcal",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            progressColor: Theme.of(context).colorScheme.primary,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        /// Affichage des macronutriments
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: nutriments.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
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
          height: 20,
        ),

        /// Ajout d'un repas
        GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(context, '/add_meal');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/add_meal');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(width: 8),
                      Text(
                        'Ajouter un repas',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:compteur_cal/ui/widget/button.dart';
import 'package:flutter/material.dart';

class RecetteView extends StatefulWidget {
  const RecetteView({super.key});

  @override
  State<RecetteView> createState() => _RecetteViewState();
}

class _RecetteViewState extends State<RecetteView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F7FB),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mes repas',
                style: TextStyle(
                  color: Color(0xFF9C9FAE),
                  fontSize: 32,
                  fontFamily: 'Dela Gothic One',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.64,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              onPressed: () {},
              buttonText: 'Ajouter',
            ),
          ],
        ),
        Column(
          children: [
            const Image(
              image: AssetImage('assets/img/arrow_top.png'),
              height: 80,
            ),
            const SizedBox(
              width: 358,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ou ',
                      style: TextStyle(
                        color: Color(0xFF9C9FAE),
                        fontSize: 22,
                        fontFamily: 'Dela Gothic One',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.44,
                      ),
                    ),
                    TextSpan(
                      text: 'choisir',
                      style: TextStyle(
                        color: Color(0xFF69B6FF),
                        fontSize: 22,
                        fontFamily: 'Dela Gothic One',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.44,
                      ),
                    ),
                    TextSpan(
                      text: ' un repas déjà ',
                      style: TextStyle(
                        color: Color(0xFF9C9FAE),
                        fontSize: 22,
                        fontFamily: 'Dela Gothic One',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.44,
                      ),
                    ),
                    TextSpan(
                      text: 'créé',
                      style: TextStyle(
                        color: Color(0xFFFA78E0),
                        fontSize: 22,
                        fontFamily: 'Dela Gothic One',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.44,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Image(
              image: AssetImage('assets/img/arrow_bottom.png'),
              height: 80,
            ),

            /// Page incomplète
            Center(
              child: Text(
                'Cette page n\'est pas encore fini',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ],
    );
  }
}

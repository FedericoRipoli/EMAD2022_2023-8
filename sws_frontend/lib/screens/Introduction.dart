import 'package:flutter/material.dart';
import 'package:frontend_sws/screens/DraggableHomeScreen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:frontend_sws/theme/theme.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: IntroductionScreen(
          globalBackgroundColor: AppColors.white,
          pages: [
            PageViewModel(
              title: 'Benvenutə👋 in Salerno Amica',
              body:
                  "Salerno Amica è l'applicazione che ti aiuta a cercare e informarti su tutti gli "
                  'eventi e i servizi dei comuni di Salerno e Pellezzano per le politiche Giovanili e Sociali',
              image: buildImage("assets/images/intro_welcome.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "Che cos'è Salerno Amica?",
              body:
                  "A portata di smartphone tutti i servizi che il Comune di Salerno offre ai suoi cittadini. Cerca i servizi"
                  " filtrando le informazioni che ti interessano, apri la mappa interattiva, visualizza gli eventi in programma nel mese corrente...",
              image: buildImage("assets/images/intro_explainer.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "Focus sull'accessibilità",
              body:
                  "L'app pone particolare attenzione sull'accessibilità, rendere l'esperienza d'utilizzo semplice "
                  "e intuitiva per tutte le tipologie di utente è l'obiettivo primario di Salerno Amica",
              image: buildImage("assets/images/intro_access.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Chiedi aiuto al nostro chatbot',
              body:
                  'Hai dubbi o domande sui servizi offerti dal Comune di Salerno o su cosa fare? Interagisci '
                  'con Olivia che ti aiuterà a soddisfare le tue esigenze',
              image: buildImage("assets/images/intro_chatbot.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            Navigator.of(context).push(_createRoute());
          },
          onSkip: () {
            Navigator.of(context).push(_createRoute());
          },
          //ClampingScrollPhysics previene lo scrolling quando si eccede il contenuto.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          skip: const Text("Salta",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.logoBlue)),
          next: const Icon(
            Icons.navigate_next_sharp,
            color: AppColors.logoBlue,
          ),
          done: const Text(
            "Continua",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.logoBlue),
          ),
          dotsDecorator: getDotsDecorator()),
    );
  }

  // crea la route con la relativa animazione
  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const DraggableHomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Widget buildImage(String imagePath) {
    return Center(
      child: Image.asset(
        imagePath,
        width: 650,
        height: 390,
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: AppColors.logoBlue,
      color: AppColors.ice,
      activeSize: Size(14, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}

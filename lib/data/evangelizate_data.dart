import 'package:flutter/material.dart';

class BibleVerse {
  final String reference;
  final String text;
  const BibleVerse(this.reference, this.text);
}

class EvangelizateSection {
  final String title;
  final String explanation;
  final List<BibleVerse> verses;
  final List<String> tips;

  const EvangelizateSection({
    this.title = '',
    this.explanation = '',
    this.verses = const [],
    this.tips = const [],
  });
}

class EvangelizateCategory {
  final String title;
  final String shortTitle;
  final IconData icon;
  final String description;
  final List<EvangelizateSection> sections;

  const EvangelizateCategory({
    required this.title,
    required this.shortTitle,
    required this.icon,
    required this.description,
    required this.sections,
  });
}

final List<EvangelizateCategory> evangelizateCategories = [
  EvangelizateCategory(
    title: 'Creo que iría al cielo porque he sido bueno',
    shortTitle: 'Buenas obras',
    icon: Icons.volunteer_activism_outlined,
    description: 'Confía en sus obras',
    sections: [
      EvangelizateSection(
        title: 'Todos hemos pecado',
        verses: [
          const BibleVerse(
            'Romanos 3:12',
            'Todos se desviaron, a una se hicieron inútiles; no hay quien haga lo bueno, no hay ni siquiera uno.',
          ),
          const BibleVerse(
            'Romanos 3:10',
            'Como está escrito: No hay justo, ni aun uno.',
          ),
        ],
      ),
      EvangelizateSection(
        title: 'Todos merecemos la muerte',
        verses: [
          const BibleVerse(
            'Romanos 6:23',
            'Porque la paga del pecado es muerte, mas la dádiva de Dios es vida eterna en Cristo Jesús Señor nuestro.',
          ),
          const BibleVerse(
            'Santiago 1:15',
            'Entonces la concupiscencia, después que ha concebido, da a luz el pecado; y el pecado, siendo consumado, da a luz la muerte.',
          ),
        ],
      ),
      EvangelizateSection(
        title: 'La justicia de DIOS',
        explanation:
            'DIOS es justo y santo. Como todos hemos pecado —mintiendo, odiando, teniendo pensamientos impuros o haciendo maldad— merecemos juicio. Si DIOS no castigara el pecado, no sería justo. Merecemos el infierno porque DIOS es justo.',
        verses: [
          const BibleVerse(
            'Romanos 2:16',
            'En el día en que Dios juzgará por Jesucristo los secretos de los hombres, conforme a mi evangelio.',
          ),
        ],
      ),
      EvangelizateSection(
        title: 'La gracia de nuestro SEÑOR JESUCRISTO',
        verses: [
          const BibleVerse(
            'Romanos 3:23',
            'Por cuanto todos pecaron, y están destituidos de la gloria de Dios.',
          ),
          const BibleVerse(
            'Juan 3:16',
            'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
          ),
        ],
      ),
      EvangelizateSection(
        title: 'Salvación por gracia',
        explanation:
            'La salvación no se gana siendo "bueno", sino arrepintiéndose y creyendo en JESUCRISTO.',
        verses: [
          const BibleVerse(
            'Efesios 2:8-9',
            'Porque por gracia sois salvos por medio de la fe; y esto no de vosotros, pues es don de Dios; no por obras, para que nadie se gloríe.',
          ),
        ],
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Creo en DIOS pero no sigo ninguna religión',
    shortTitle: 'Sin religión',
    icon: Icons.remove_circle_outline,
    description: 'Creen sin relación',
    sections: [
      EvangelizateSection(
        title: 'Fe sin obras',
        explanation:
            'Creer que DIOS existe no es suficiente. Muchas personas creen en DIOS, pero nunca se arrepienten verdaderamente ni siguen a CRISTO. Necesitan una relación verdadera con JESÚS, no solo una creencia superficial.',
        verses: [
          const BibleVerse(
            'Juan 3:16',
            'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
          ),
          const BibleVerse(
            'Romanos 3:23',
            'Por cuanto todos pecaron, y están destituidos de la gloria de Dios.',
          ),
        ],
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Ateo',
    shortTitle: 'Ateo',
    icon: Icons.block_rounded,
    description: 'No creen en la existencia de DIOS.',
    sections: [
      EvangelizateSection(
        title: 'Habla con amor',
        explanation:
            'Evita discutir agresivamente. Habla con calma y amor. Haz preguntas sobre el sentido de la vida, el bien y el mal, o por qué existe la moralidad. Después comparte el evangelio igualmente, recordando que quien convence es el ESPÍRITU SANTO.',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Agnóstico',
    shortTitle: 'Agnóstico',
    icon: Icons.help_outline_rounded,
    description: 'No están seguros de si DIOS existe.',
    sections: [
      EvangelizateSection(
        title: 'Busca la verdad',
        explanation:
            'Anímale a buscar sinceramente la verdad. Explícale que JESÚS dijo: "Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí." Habla con paciencia y responde con amor.',
        verses: [
          const BibleVerse(
            'Juan 14:6',
            'Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí.',
          ),
        ],
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Consejos importantes',
    shortTitle: 'Consejos',
    icon: Icons.lightbulb_outline,
    description: 'Tips para evangelizar',
    sections: [
      EvangelizateSection(
        tips: [
          'Ora antes de evangelizar.',
          'Depende del ESPÍRITU SANTO.',
          'Habla con amor y paciencia.',
          'No discutas innecesariamente.',
          'Usa la Biblia como autoridad.',
          'Recuerda que quien convence es DIOS.',
        ],
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Recordatorio final',
    shortTitle: 'Recordatorio',
    icon: Icons.flag_outlined,
    description: 'Compartir el evangelio',
    sections: [
      EvangelizateSection(
        explanation:
            'No todos aceptarán el mensaje, pero nuestra tarea es compartir fielmente el evangelio.',
        verses: [
          const BibleVerse(
            'Mateo 28:19-20',
            'Por tanto, id, y haced discípulos a todas las naciones, bautizándolos en el nombre del Padre, y del Hijo, y del Espíritu Santo; enseñándoles que guarden todas las cosas que os he mandado.',
          ),
        ],
      ),
    ],
  ),
];

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
  /// Short attribution shown under the section (pastor, ministry, or method).
  final String source;

  const EvangelizateSection({
    this.title = '',
    this.explanation = '',
    this.verses = const [],
    this.tips = const [],
    this.source = '',
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

class EvangelizateSource {
  final String name;
  final String detail;
  final String url;

  const EvangelizateSource({
    required this.name,
    required this.detail,
    required this.url,
  });
}

/// Public, checkable sources used to shape Evangelízate (not verbatim tracts).
const List<EvangelizateSource> evangelizateSources = [
  EvangelizateSource(
    name: 'Ray Comfort — Living Waters',
    detail:
        'Prueba de la «buena persona», uso de la Ley (Éxodo 20) y luego la cruz. '
        'livingwaters.com',
    url: 'https://livingwaters.com/how-to-effectively-share-the-gospel/',
  ),
  EvangelizateSource(
    name: 'Billy Graham Evangelistic Association',
    detail:
        'Ilustración del puente y los cuatro pasos de paz con Dios '
        '(plan de Dios, problema, remedio, respuesta). billygraham.org / perdona.me',
    url: 'https://billygraham.org/',
  ),
  EvangelizateSource(
    name: 'Greg Laurie — Harvest Ministries',
    detail:
        'Evangelismo conversacional: escuchar primero, ser amable y llevar '
        'claramente a la cruz. harvest.org',
    url: 'https://harvest.org/resources/gregs-blog/post/how-to-evangelize/',
  ),
  EvangelizateSource(
    name: 'Camino de Romanos (tradición evangélica)',
    detail:
        'Secuencia clásica: Ro 3:23 → 6:23 → 5:8 → 10:9-10 (y a menudo 10:13). '
        'Usado ampliamente en iglesias evangélicas.',
    url: 'https://www.coalicionporelevangelio.org/articulo/metodo-dos-caminos-evangelismo/',
  ),
  EvangelizateSource(
    name: 'Cru — Las cuatro leyes espirituales',
    detail:
        'Resumen claro del evangelio en cuatro puntos (amor de Dios, pecado, '
        'Cristo, recibir). cru.org',
    url: 'https://www.cru.org/us/en/train-and-grow/share-the-gospel/ways-to-share/four-spiritual-laws.html',
  ),
];

final List<EvangelizateCategory> evangelizateCategories = [
  EvangelizateCategory(
    title: 'Creo que iría al cielo porque seré bueno',
    shortTitle: 'Buenas obras',
    icon: Icons.volunteer_activism_outlined,
    description: 'Ley, culpa y gracia',
    sections: [
      EvangelizateSection(
        title: 'Pregunta de apertura',
        explanation:
            'Una forma comprobada de iniciar (usada por Ray Comfort / Living Waters) '
            'es: «¿Te consideras una buena persona?» La mayoría responde que sí. '
            'Luego: «Si murieras hoy, ¿crees que irías al cielo?» Eso revela si '
            'confían en sus obras o en Cristo.',
        source: 'Ray Comfort — Living Waters',
      ),
      EvangelizateSection(
        title: 'La Ley muestra el pecado',
        explanation:
            'No empieces con «Dios tiene un plan maravilloso» si la persona se '
            'cree buena. Usa la Ley (Éxodo 20) con gentileza: ¿has mentido? ¿robado? '
            '¿usado el nombre de Dios en vano? ¿odiado a alguien? Jesús enseña que '
            'el odio y la lujuria ya son pecado ante Dios (Mt 5). La Ley «tapa la '
            'boca» de la autojustificación y muestra por qué necesitamos un Salvador '
            '(Ro 3:19-20). Spurgeon y Comfort enfatizan: sin Ley, la cruz parece '
            'opcional; con Ley, la gracia tiene sentido.',
        tips: [
          'Pregunta 3–4 mandamientos, no sermonees los diez de golpe.',
          'Inclúyete: «yo también he mentido…».',
          'No humilles: el objetivo es despertar conciencia, no ganar un debate.',
        ],
        verses: [
          const BibleVerse(
            'Romanos 3:19-20',
            'Mas sabemos que todo lo que la ley dice, a los que están bajo la ley lo dice, para que toda boca se cierre y todo el mundo quede bajo el juicio de Dios; porque por las obras de la ley ningún ser humano será justificado delante de él; porque por medio de la ley es el conocimiento del pecado.',
          ),
          const BibleVerse(
            'Éxodo 20:15-16',
            'No hurtarás. No hablarás contra tu prójimo falso testimonio.',
          ),
        ],
        source: 'Ray Comfort — Living Waters; cf. Spurgeon sobre predicar la Ley',
      ),
      EvangelizateSection(
        title: 'Camino de Romanos (resumen)',
        explanation:
            'Después de la conciencia de pecado, presenta el evangelio con la '
            'secuencia clásica del «Camino de Romanos»:',
        tips: [
          'Todos pecaron (Romanos 3:23).',
          'La paga del pecado es muerte; el don de Dios es vida eterna (6:23).',
          'Cristo murió por nosotros siendo aún pecadores (5:8).',
          'Si confiesas y crees, serás salvo (10:9-10); todo el que invocare será salvo (10:13).',
        ],
        verses: [
          const BibleVerse(
            'Romanos 3:23',
            'Por cuanto todos pecaron, y están destituidos de la gloria de Dios.',
          ),
          const BibleVerse(
            'Romanos 6:23',
            'Porque la paga del pecado es muerte, mas la dádiva de Dios es vida eterna en Cristo Jesús Señor nuestro.',
          ),
          const BibleVerse(
            'Romanos 5:8',
            'Mas Dios muestra su amor para con nosotros, en que siendo aún pecadores, Cristo murió por nosotros.',
          ),
          const BibleVerse(
            'Romanos 10:9-10',
            'Que si confesares con tu boca que Jesús es el Señor, y creyeres en tu corazón que Dios le levantó de los muertos, serás salvo. Porque con el corazón se cree para justicia, pero con la boca se confiesa para salvación.',
          ),
        ],
        source: 'Camino de Romanos — tradición evangélica',
      ),
      EvangelizateSection(
        title: 'Salvación por gracia, no por obras',
        explanation:
            'Deja claro: nadie entra al cielo «por ser bueno». Somos salvos por '
            'gracia mediante la fe; las obras son fruto, no el precio del ticket '
            '(Efesios 2:8-9). Invita al arrepentimiento y a confiar en Jesús.',
        verses: [
          const BibleVerse(
            'Efesios 2:8-9',
            'Porque por gracia sois salvos por medio de la fe; y esto no de vosotros, pues es don de Dios; no por obras, para que nadie se gloríe.',
          ),
        ],
        source: 'Enseñanza apostólica (Pablo); enfatizada por Billy Graham y Comfort',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Creo en Dios pero no sigo a Cristo',
    shortTitle: 'Sin Cristo',
    icon: Icons.remove_circle_outline,
    description: 'Fe sin arrepentimiento',
    sections: [
      EvangelizateSection(
        title: 'Creer que Dios existe no basta',
        explanation:
            'Santiago recuerda que aun los demonios creen… y tiemblan. La fe '
            'salvadora une confianza personal en Jesús, arrepentimiento y '
            'seguimiento. Billy Graham insistía en una decisión clara: recibir a '
            'Cristo como Señor y Salvador, no solo «creer en Dios» en abstracto.',
        verses: [
          const BibleVerse(
            'Santiago 2:19',
            'Tú crees que Dios es uno; bien haces. También los demonios creen, y tiemblan.',
          ),
          const BibleVerse(
            'Juan 1:12',
            'Mas a todos los que le recibieron, a los que creen en su nombre, les dio potestad de ser hechos hijos de Dios.',
          ),
        ],
        source: 'Santiago 2; énfasis de Billy Graham en decisión personal',
      ),
      EvangelizateSection(
        title: 'Solo Jesús',
        explanation:
            'Jesús no se presentó como una opción entre muchas. Dijo ser el '
            'camino, la verdad y la vida. La Asociación Evangelística Billy Graham '
            'resume: Dios ofrece paz y vida; nuestro pecado nos separa; Cristo es '
            'el remedio; nuestra respuesta es arrepentirnos y creer.',
        verses: [
          const BibleVerse(
            'Juan 14:6',
            'Jesús le dijo: Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí.',
          ),
          const BibleVerse(
            'Hechos 4:12',
            'Y en ningún otro hay salvación; porque no hay otro nombre bajo el cielo, dado a los hombres, en que podamos ser salvos.',
          ),
        ],
        source: 'Billy Graham Evangelistic Association — pasos hacia la paz con Dios',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Ateo',
    shortTitle: 'Ateo',
    icon: Icons.block_rounded,
    description: 'Escucha y testifica',
    sections: [
      EvangelizateSection(
        title: 'Primero construye un puente',
        explanation:
            'Greg Laurie (Harvest), siguiendo el ejemplo de Billy Graham, enseña: '
            'si quieres ganar a alguien, sé amable. Pregunta «Cuéntame de ti» y '
            'escucha sin interrumpir. No avergüences ni ataques. El objetivo es '
            'ser piedra de tropiezo cero y peldaño hacia Cristo.',
        tips: [
          'Ora en silencio antes y durante la conversación.',
          'Escucha su historia completa; luego pregunta si puedes compartir la tuya.',
          'No conviertas el café en un tribunal filosófico.',
        ],
        source: 'Greg Laurie — «How to Evangelize Effectively» (Harvest)',
      ),
      EvangelizateSection(
        title: 'Preguntas que abren, no cierran',
        explanation:
            'Laurie describe abrir con la vida después de la muerte («¿Qué crees '
            'que pasa cuando mueres?»), escuchar, y solo entonces compartir lo que '
            'Jesús dijo —no «tu versión». También usa preguntas como: «¿Alguien te '
            'ha dicho que hay un Dios en el cielo que te ama?»',
        tips: [
          '«¿Qué crees que pasa cuando una persona muere?»',
          '«¿De dónde crees que vienen el bien y el mal objetivos?»',
          '«Si el cristianismo fuera verdad, ¿querrías saberlo?»',
        ],
        source: 'Greg Laurie — Harvest Ministries',
      ),
      EvangelizateSection(
        title: 'Lleva siempre a la cruz',
        explanation:
            'Billy Graham dijo a Laurie que predicaría más la cruz y la sangre, '
            'porque ahí está el poder. Con un ateo, tras escuchar, presenta con '
            'claridad: pecado, muerte de Cristo, resurrección e invitación a '
            'creer. El Espíritu Santo convence (Juan 16:8); tú testificas.',
        verses: [
          const BibleVerse(
            '1 Corintios 15:3-4',
            'Porque primeramente os he enseñado lo que asimismo recibí: Que Cristo murió por nuestros pecados, conforme a las Escrituras; y que fue sepultado, y que resucitó al tercer día, conforme a las Escrituras.',
          ),
          const BibleVerse(
            'Romanos 1:16',
            'Porque no me avergüenzo del evangelio, porque es poder de Dios para salvación a todo aquel que cree; al judío primeramente, y también al griego.',
          ),
        ],
        source: 'Billy Graham (citado por Greg Laurie); 1 Corintios 15',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Agnóstico',
    shortTitle: 'Agnóstico',
    icon: Icons.help_outline_rounded,
    description: 'Busca con honestidad',
    sections: [
      EvangelizateSection(
        title: 'Anima a investigar a Jesús',
        explanation:
            'Muchos agnósticos respetan la honestidad intelectual. Invita a '
            'examinar las afirmaciones históricas de Jesús (vida, muerte, '
            'resurrección) más que a «probar a Dios en abstracto». Jesús prometió '
            'que quien quiera hacer la voluntad del Padre conocerá la doctrina '
            '(Juan 7:17).',
        verses: [
          const BibleVerse(
            'Juan 7:17',
            'El que quiera hacer la voluntad de Dios, conocerá si la doctrina es de Dios, o si yo hablo por mi propia cuenta.',
          ),
          const BibleVerse(
            'Jeremías 29:13',
            'Y me buscaréis y me hallaréis, porque me buscaréis de todo vuestro corazón.',
          ),
        ],
        source: 'Enfoque evangélico clásico (búsqueda honesta de la verdad)',
      ),
      EvangelizateSection(
        title: 'La verdad tiene nombre',
        explanation:
            'No ofrezcas solo argumentos: ofrece a una Persona. Juan 14:6 y el '
            'testimonio de los evangelios centran la fe en Cristo. Como Laurie: '
            'diálogo, no monólogo; claridad sobre la cruz.',
        verses: [
          const BibleVerse(
            'Juan 14:6',
            'Jesús le dijo: Yo soy el camino, y la verdad, y la vida; nadie viene al Padre, sino por mí.',
          ),
        ],
        source: 'Greg Laurie — enfoque conversacional; Juan 14:6',
      ),
      EvangelizateSection(
        title: 'Dale un siguiente paso concreto',
        explanation:
            'El agnosticismo a veces es comodidad, no solo duda. Invita a un '
            'paso pequeño y verificable: leer un evangelio (Marcos o Juan), '
            'orar «Dios, si estás ahí, muéstrate», o visitar una iglesia sana. '
            'No exijas una decisión forzada el primer día; acompaña el proceso.',
        tips: [
          'Ofrece leer juntos un capítulo corto.',
          'Pregunta: «¿Qué te detiene de mirar a Jesús con honestidad?»',
          'Respeta el ritmo; no manipules emociones.',
        ],
        verses: [
          const BibleVerse(
            'Hebreos 11:6',
            'Pero sin fe es imposible agradar a Dios; porque es necesario que el que se acerca a Dios crea que le hay, y que es galardonador de los que le buscan.',
          ),
        ],
        source: 'Práctica pastoral común; Hebreos 11:6',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Si Dios es bueno, ¿por qué hay mal?',
    shortTitle: 'Sufrimiento',
    icon: Icons.healing_outlined,
    description: 'Dolor, mal y esperanza',
    sections: [
      EvangelizateSection(
        title: 'Escucha el dolor antes de explicar',
        explanation:
            'Quien pregunta por el mal a menudo carga heridas. No empieces con '
            'filosofía. Di: «Lamento lo que te pasó» y escucha. El evangelio no '
            'es un argumento frío: es un Dios que entró en el sufrimiento en la '
            'cruz.',
        tips: [
          'Valida el dolor; no digas «todo pasa por algo» de inmediato.',
          'Ora con la persona si te lo permiten.',
          'Comparte que tú también has llorado y dudado.',
        ],
        source: 'Pastoreo pastoral; énfasis de Graham en compasión',
      ),
      EvangelizateSection(
        title: 'El mal no niega a Dios: lo hace necesario',
        explanation:
            'Si el mal es real (no solo «opinión»), entonces existen el bien y '
            'la justicia objetiva. Eso apunta a un Legislador moral. El '
            'cristianismo explica el quebranto (Génesis 3; Ro 5) y ofrece '
            'redención: Dios no está ausente; en Cristo carga el mal consigo.',
        verses: [
          const BibleVerse(
            'Romanos 8:18',
            'Pues tengo por cierto que las aflicciones del tiempo presente no son comparables con la gloria venidera que en nosotros ha de ser manifestada.',
          ),
          const BibleVerse(
            'Apocalipsis 21:4',
            'Enjugará Dios toda lágrima de los ojos de ellos; y ya no habrá muerte, ni habrá más llanto, ni clamor, ni dolor; porque las primeras cosas pasaron.',
          ),
        ],
        source: 'Teología bíblica del quebranto y la esperanza',
      ),
      EvangelizateSection(
        title: 'Lleva a la cruz y a la esperanza',
        explanation:
            'Jesús lloró (Juan 11), sufrió injusticia y venció la muerte. No '
            'prometas que la vida será fácil; promete que Él está cerca de los '
            'quebrantados y que un día hará nuevas todas las cosas.',
        verses: [
          const BibleVerse(
            'Salmo 34:18',
            'Cercano está Jehová a los quebrantados de corazón; y salva a los contritos de espíritu.',
          ),
          const BibleVerse(
            '2 Corintios 1:3-4',
            'Bendito sea el Dios y Padre de nuestro Señor Jesucristo, Padre de misericordias y Dios de toda consolación, el cual nos consuela en todas nuestras tribulaciones, para que podamos también nosotros consolar a los que están en cualquier tribulación.',
          ),
        ],
        source: 'Escritura; consuelo pastoral',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Objeciones frecuentes',
    shortTitle: 'Objeciones',
    icon: Icons.forum_outlined,
    description: 'Respuestas con gracia',
    sections: [
      EvangelizateSection(
        title: '«Los cristianos son hipócritas»',
        explanation:
            'Admite lo que sea justo: la iglesia tiene fallas porque está llena '
            'de pecadores perdonados. No defiendas el pecado; apunta a Cristo. '
            'La hipocresía ajena no cancela la verdad de Jesús, igual que un '
            'médico malo no anula la medicina.',
        tips: [
          '«Tienes razón en que muchos fallamos; ¿podemos mirar a Jesús?»',
          'Distingue entre Cristo y quienes lo representan mal.',
          'No ataques a otras iglesias; enfócate en el evangelio.',
        ],
        verses: [
          const BibleVerse(
            'Lucas 5:31-32',
            'Respondiendo Jesús, les dijo: Los que están sanos no tienen necesidad de médico, sino los enfermos. No he venido a llamar a justos, sino a pecadores al arrepentimiento.',
          ),
        ],
        source: 'Apologética conversacional común',
      ),
      EvangelizateSection(
        title: '«La Biblia es antigua / contradictoria»',
        explanation:
            'Invita a leer un evangelio completo antes de descartarlo. Explica '
            'que la Biblia es una biblioteca con géneros distintos, no un '
            'manual moderno. Ofrece estudiar juntos un pasaje difícil en vez de '
            'debatir titulares.',
        tips: [
          'Pregunta: «¿Qué pasaje concreto te incomoda?»',
          'Recomienda Juan o Marcos para empezar.',
          'Sé humilde: «No lo sé todo; busquemos juntos.»',
        ],
        verses: [
          const BibleVerse(
            '2 Timoteo 3:16-17',
            'Toda la Escritura es inspirada por Dios, y útil para enseñar, para redargüir, para corregir, para instruir en justicia, a fin de que el hombre de Dios sea perfecto, enteramente preparado para toda buena obra.',
          ),
          const BibleVerse(
            'Salmo 119:105',
            'Lámpara es a mis pies tu palabra, y lumbrera a mi camino.',
          ),
        ],
        source: 'Enfoque evangélico: Escritura como autoridad',
      ),
      EvangelizateSection(
        title: '«La ciencia ya lo explicó todo»',
        explanation:
            'La ciencia describe mecanismos; no responde por sí sola al sentido, '
            'la moral objetiva ni el amor. Muchos científicos son creyentes. No '
            'enfrentes fe vs. ciencia: muestra que el evangelio responde a quiénes '
            'somos y a quién necesitamos.',
        tips: [
          'Evita pelear sobre cada teoría; vuelve a Jesús.',
          '«Aunque el universo exista, ¿qué haces con tu culpa y tu muerte?»',
        ],
        verses: [
          const BibleVerse(
            'Salmo 19:1',
            'Los cielos cuentan la gloria de Dios, y el firmamento anuncia la obra de sus manos.',
          ),
          const BibleVerse(
            'Colosenses 1:16-17',
            'Porque en él fueron creadas todas las cosas, las que hay en los cielos y las que hay en la tierra, visibles e invisibles; … y él es antes de todas las cosas, y todas las cosas en él subsisten.',
          ),
        ],
        source: 'Apologética cristiana básica',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Amigos y familia',
    shortTitle: 'Cercanos',
    icon: Icons.people_outline_rounded,
    description: 'Testificar en casa',
    sections: [
      EvangelizateSection(
        title: 'Empieza por el amor constante',
        explanation:
            'Con familiares, tu vida habla antes que tu discurso. Sé paciente, '
            'honesto y respetuoso. No uses cada comida como púlpito. Ora por '
            'ellos a diario y busca momentos naturales, no emboscadas.',
        tips: [
          'Pide perdón cuando hayas sido agresivo o orgulloso.',
          'Sirve en lo práctico: presencia > sermones.',
          'Comparte cambios reales que Cristo hizo en ti.',
        ],
        verses: [
          const BibleVerse(
            '1 Pedro 3:15-16',
            'Estad siempre preparados para presentar defensa con mansedumbre y reverence ante todo el que os demande razón de la esperanza que hay en vosotros; teniendo buena conciencia…',
          ),
          const BibleVerse(
            'Colosenses 4:5-6',
            'Andad sabiamente para con los de afuera, redimiendo el tiempo. Sea vuestra palabra siempre con gracia, sazonada con sal, para que sepáis cómo debéis responder a cada uno.',
          ),
        ],
        source: '1 Pedro 3; Colosenses 4 — testificar con mansedumbre',
      ),
      EvangelizateSection(
        title: 'Cuando rechazan el mensaje',
        explanation:
            'No fuerces. Jesús envió a sus discípulos a sacudir el polvo cuando '
            'no eran recibidos (Mt 10). Sigue amando. A veces el mejor '
            'evangelismo es fidelidad silenciosa y puertas abiertas.',
        tips: [
          'Deja de discutir el mismo punto una y otra vez.',
          'Mantén la relación; no hagas del evangelio un ultimátum.',
          'Confía el proceso a Dios.',
        ],
        verses: [
          const BibleVerse(
            'Gálatas 6:9',
            'No nos cansemos, pues, de hacer bien; porque a su tiempo segaremos, si no desmayamos.',
          ),
        ],
        source: 'Mateo 10; perseverancia pastoral',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Soy religioso / de otra tradición',
    shortTitle: 'Religioso',
    icon: Icons.public_rounded,
    description: 'Religión vs. relación',
    sections: [
      EvangelizateSection(
        title: 'Respeta, no ridiculices',
        explanation:
            'Honra lo bueno que encuentres (sinceridad, oración, ética). Luego '
            'pregunta con suavidad: «¿En qué confías para estar bien con Dios: '
            'tus rituales, tu moral, o a Cristo?» La diferencia del evangelio es '
            'gracia recibida, no mérito ganado.',
        tips: [
          'Nunca insultes a su comunidad o líderes.',
          'Usa preguntas, no ataques a doctrinas ajenas.',
          'Comparte tu testimonio personal.',
        ],
        verses: [
          const BibleVerse(
            'Hechos 17:22-23',
            'Pablo… dijo: Varones atenienses, en todo observo que sois muy religiosos; porque pasando y mirando vuestros santuarios, hallé también un altar en el cual estaba esta inscripción: AL DIOS NO CONOCIDO. Al que vosotros adoráis, pues, sin conocerle, es a quien yo os anuncio.',
          ),
        ],
        source: 'Hechos 17 — modelo de Pablo en Atenas',
      ),
      EvangelizateSection(
        title: 'Cristo es suficiente',
        explanation:
            'Muchas religiones añaden obras, mediadores o méritos. El evangelio '
            'anuncia que la obra de Jesús en la cruz es completa. Invita a '
            'descansar en Él, no a «sumar» a Jesús a un sistema anterior.',
        verses: [
          const BibleVerse(
            'Juan 19:30',
            'Cuando Jesús hubo tomado el vinagre, dijo: Consumado es. Y habiendo inclinado la cabeza, entregó el espíritu.',
          ),
          const BibleVerse(
            'Hebreos 10:14',
            'Porque con una sola ofrenda hizo perfectos para siempre a los santificados.',
          ),
        ],
        source: 'Hebreos; énfasis evangélico en la suficiencia de Cristo',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Métodos claros',
    shortTitle: 'Métodos',
    icon: Icons.account_tree_outlined,
    description: 'Puente, Romanos y 4 leyes',
    sections: [
      EvangelizateSection(
        title: 'Ilustración del puente',
        explanation:
            'Usada por la Asociación Evangelística Billy Graham (p. ej. materiales '
            '«Vivir en Cristo» / pasos hacia la paz): dibuja dos orillas —Dios y '
            'nosotros— separadas por un abismo (el pecado). La cruz de Cristo es '
            'el único puente. Explica: (1) plan de Dios: paz y vida; (2) nuestro '
            'problema: pecado y separación; (3) el remedio: Cristo; (4) nuestra '
            'respuesta: arrepentirnos y recibirlo por fe.',
        tips: [
          'Dibuja mientras hablas; una servilleta basta.',
          'Lee un versículo por cada orilla / paso.',
          'Pregunta: «¿De qué lado del abismo crees que estás?»',
        ],
        verses: [
          const BibleVerse(
            'Isaías 59:2',
            'Pero vuestras iniquidades han hecho división entre vosotros y vuestro Dios, y vuestros pecados han hecho ocultar de vosotros su rostro para no oír.',
          ),
          const BibleVerse(
            '1 Timoteo 2:5',
            'Porque hay un solo Dios, y un solo mediador entre Dios y los hombres, Jesucristo hombre.',
          ),
          const BibleVerse(
            'Juan 3:16',
            'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
          ),
        ],
        source: 'Billy Graham Evangelistic Association — ilustración del puente',
      ),
      EvangelizateSection(
        title: 'Camino de Romanos (pasos)',
        explanation:
            'Método verificado por generaciones de iglesias: recorre Romanos con '
            'la persona, dejando que la Escritura hable.',
        tips: [
          'Ro 3:23 — necesidad universal.',
          'Ro 6:23 — consecuencia y don.',
          'Ro 5:8 — amor demostrado en la cruz.',
          'Ro 10:9-10 y 10:13 — respuesta de fe.',
        ],
        verses: [
          const BibleVerse(
            'Romanos 10:13',
            'Porque todo aquel que invocare el nombre del Señor, será salvo.',
          ),
        ],
        source: 'Camino de Romanos — tradición evangélica',
      ),
      EvangelizateSection(
        title: 'Cuatro leyes espirituales (Cru)',
        explanation:
            'Un resumen breve y memorizable usado por Cru (antes Campus Crusade): '
            '(1) Dios te ama y tiene un plan; (2) el hombre está separado por el '
            'pecado; (3) Jesucristo es la única provisión de Dios; (4) debemos '
            'recibir a Jesús por fe. Úsalo como guía, no como guion rígido.',
        tips: [
          'Puedes dibujar las dos orillas como en el puente.',
          'Termina ofreciendo orar para recibir a Cristo.',
          'Deja un folleto o un versículo escrito para que lo relea.',
        ],
        verses: [
          const BibleVerse(
            'Juan 3:16',
            'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
          ),
          const BibleVerse(
            'Juan 1:12',
            'Mas a todos los que le recibieron, a los que creen en su nombre, les dio potestad de ser hechos hijos de Dios.',
          ),
          const BibleVerse(
            'Apocalipsis 3:20',
            'He aquí, yo estoy a la puerta y llamo; si alguno oye mi voz y abre la puerta, entraré a él, y cenaré con él, y él conmigo.',
          ),
        ],
        source: 'Cru — Four Spiritual Laws',
      ),
    ],
  ),
  EvangelizateCategory(
    title: 'Consejos prácticos',
    shortTitle: 'Consejos',
    icon: Icons.lightbulb_outline,
    description: 'Hábitos de testigos',
    sections: [
      EvangelizateSection(
        title: 'Principios de Laurie y Graham',
        tips: [
          'Ora antes: pide que el Espíritu abra la puerta.',
          'Sé amable: gana personas, no discusiones.',
          'Escucha más de lo que hablas (diálogo, no monólogo).',
          'No avergüences a nadie en público.',
          'Sé claro: pecado, cruz, resurrección, respuesta.',
          'Predica la cruz: ahí está el poder del evangelio.',
          'Usa la Biblia como autoridad, no tu opinión.',
          'Recuerda: tú siembras; Dios da el crecimiento (1 Co 3:6-7).',
        ],
        source: 'Greg Laurie (Harvest) y Billy Graham',
      ),
      EvangelizateSection(
        title: 'La comisión no cambia',
        explanation:
            'No todos aceptarán el mensaje. Nuestra tarea es compartir fielmente. '
            'Todo creyente está llamado a hacer la obra de un evangelista '
            '(2 Timoteo 4:5), aunque no todos tengan el don público de evangelista.',
        verses: [
          const BibleVerse(
            'Mateo 28:19-20',
            'Por tanto, id, y haced discípulos a todas las naciones, bautizándolos en el nombre del Padre, y del Hijo, y del Espíritu Santo; enseñándoles que guarden todas las cosas que os he mandado; y he aquí yo estoy con vosotros todos los días, hasta el fin del mundo. Amén.',
          ),
          const BibleVerse(
            '2 Timoteo 4:5',
            'Pero tú sé sobrio en todo, soporta las aflicciones, haz obra de evangelista, cumple tu ministerio.',
          ),
        ],
        source: 'Mateo 28; énfasis de Greg Laurie sobre 2 Timoteo 4:5',
      ),
      EvangelizateSection(
        title: 'Después de que alguien cree',
        explanation:
            'La conversión es el comienzo. Ayuda al nuevo creyente a orar, leer '
            'la Biblia, unirse a una iglesia fiel y bautizarse. No lo dejes solo '
            'con un «oración de salvación» y adiós.',
        tips: [
          'Conéctalo con una congregación sana esta misma semana.',
          'Lee juntos el evangelio de Juan o un plan de 7 días.',
          'Enséñale a orar con sencillez (adoración, confesión, petición).',
          'Celebra el bautismo cuando esté listo (Mt 28:19).',
        ],
        verses: [
          const BibleVerse(
            'Hechos 2:41-42',
            'Así que, los que recibieron su palabra fueron bautizados… Y perseveraban en la doctrina de los apóstoles, en la comunión unos con otros, en el partimiento del pan y en las oraciones.',
          ),
          const BibleVerse(
            'Mateo 28:19-20',
            'Por tanto, id, y haced discípulos a todas las naciones, bautizándolos… enseñándoles que guarden todas las cosas que os he mandado.',
          ),
        ],
        source: 'Hechos 2; discipulado inicial',
      ),
      EvangelizateSection(
        title: 'Errores comunes a evitar',
        tips: [
          'No pelear por ganar: si ganas el debate y pierdes a la persona, perdiste.',
          'No inventar versículos ni sacar frases de contexto.',
          'No prometer riquezas o una vida sin problemas.',
          'No avergonzar en redes ni exponer conversaciones privadas.',
          'No depender solo de argumentos: ora y ama.',
        ],
        source: 'Buenas prácticas de evangelismo personal',
      ),
    ],
  ),
];

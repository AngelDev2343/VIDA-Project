/// Tagged verse pool for the VIDA personalization algorithm (RVR1909 sense).
class VidaBankVerse {
  final String id;
  final String reference;
  final String text;
  final List<String> tags;

  const VidaBankVerse({
    required this.id,
    required this.reference,
    required this.text,
    required this.tags,
  });
}

/// Themes used by signals + matching.
abstract final class VidaTags {
  static const miedo = 'miedo';
  static const ansiedad = 'ansiedad';
  static const paz = 'paz';
  static const esperanza = 'esperanza';
  static const amor = 'amor';
  static const fe = 'fe';
  static const fortaleza = 'fortaleza';
  static const perdon = 'perdon';
  static const tristeza = 'tristeza';
  static const soledad = 'soledad';
  static const proposito = 'proposito';
  static const gratitud = 'gratitud';
  static const tentacion = 'tentacion';
  static const sabiduria = 'sabiduria';
  static const gozo = 'gozo';
  static const paciencia = 'paciencia';
  static const confianza = 'confianza';
  static const descanso = 'descanso';
  static const salvacion = 'salvacion';
  static const oracion = 'oracion';
}

const List<VidaBankVerse> vidaVerseBank = [
  VidaBankVerse(
    id: 'jos1_9',
    reference: 'Josué 1:9',
    text:
        'Mira que te mando que te esfuerces y seas valiente; no temas ni desmayes, porque Jehová tu Dios estará contigo dondequiera que vayas.',
    tags: [VidaTags.miedo, VidaTags.fortaleza, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: 'sal23_1',
    reference: 'Salmos 23:1',
    text: 'Jehová es mi pastor; nada me faltará.',
    tags: [VidaTags.confianza, VidaTags.paz, VidaTags.esperanza],
  ),
  VidaBankVerse(
    id: 'sal27_1',
    reference: 'Salmos 27:1',
    text: 'Jehová es mi luz y mi salvación; ¿de quién temeré?',
    tags: [VidaTags.miedo, VidaTags.confianza, VidaTags.fortaleza],
  ),
  VidaBankVerse(
    id: 'sal34_18',
    reference: 'Salmos 34:18',
    text: 'Cercano está Jehová a los quebrantados de corazón.',
    tags: [VidaTags.tristeza, VidaTags.soledad, VidaTags.esperanza],
  ),
  VidaBankVerse(
    id: 'sal46_1',
    reference: 'Salmos 46:1',
    text:
        'Dios es nuestro amparo y fortaleza, nuestro pronto auxilio en las tribulaciones.',
    tags: [VidaTags.ansiedad, VidaTags.fortaleza, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'sal51_10',
    reference: 'Salmos 51:10',
    text: 'Crea en mí, oh Dios, un corazón limpio, y renueva un espíritu recto dentro de mí.',
    tags: [VidaTags.perdon, VidaTags.oracion, VidaTags.proposito],
  ),
  VidaBankVerse(
    id: 'sal55_22',
    reference: 'Salmos 55:22',
    text: 'Echa sobre Jehová tu carga, y él te sustentará.',
    tags: [VidaTags.ansiedad, VidaTags.descanso, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: 'sal91_1',
    reference: 'Salmos 91:1',
    text: 'El que habita al abrigo del Altísimo morará bajo la sombra del Omnipotente.',
    tags: [VidaTags.miedo, VidaTags.paz, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: 'sal119_105',
    reference: 'Salmos 119:105',
    text: 'Lámpara es a mis pies tu palabra, y lumbrera a mi camino.',
    tags: [VidaTags.sabiduria, VidaTags.proposito, VidaTags.fe],
  ),
  VidaBankVerse(
    id: 'prov3_5',
    reference: 'Proverbios 3:5-6',
    text:
        'Fíate de Jehová de todo tu corazón, y no te apoyes en tu propia prudencia. Reconócelo en todos tus caminos, y él enderezará tus veredas.',
    tags: [VidaTags.confianza, VidaTags.sabiduria, VidaTags.proposito],
  ),
  VidaBankVerse(
    id: 'isa40_31',
    reference: 'Isaías 40:31',
    text:
        'Pero los que esperan a Jehová tendrán nuevas fuerzas; levantarán alas como las águilas.',
    tags: [VidaTags.esperanza, VidaTags.fortaleza, VidaTags.paciencia],
  ),
  VidaBankVerse(
    id: 'isa41_10',
    reference: 'Isaías 41:10',
    text: 'No temas, porque yo estoy contigo; no desmayes, porque yo soy tu Dios.',
    tags: [VidaTags.miedo, VidaTags.fortaleza, VidaTags.soledad],
  ),
  VidaBankVerse(
    id: 'jer29_11',
    reference: 'Jeremías 29:11',
    text:
        'Porque yo sé los pensamientos que tengo acerca de vosotros, dice Jehová, pensamientos de paz, y no de mal, para daros el fin que esperáis.',
    tags: [VidaTags.esperanza, VidaTags.proposito, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'lam3_22',
    reference: 'Lamentaciones 3:22-23',
    text:
        'Por la misericordia de Jehová no hemos sido consumidos, porque nunca decayeron sus misericordias. Nuevas son cada mañana.',
    tags: [VidaTags.esperanza, VidaTags.tristeza, VidaTags.gratitud],
  ),
  VidaBankVerse(
    id: 'mat5_14',
    reference: 'Mateo 5:14',
    text: 'Vosotros sois la luz del mundo; una ciudad asentada sobre un monte no se puede esconder.',
    tags: [VidaTags.proposito, VidaTags.fe, VidaTags.fortaleza],
  ),
  VidaBankVerse(
    id: 'mat6_33',
    reference: 'Mateo 6:33',
    text:
        'Mas buscad primeramente el reino de Dios y su justicia, y todas estas cosas os serán añadidas.',
    tags: [VidaTags.ansiedad, VidaTags.proposito, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: 'mat11_28',
    reference: 'Mateo 11:28',
    text:
        'Venid a mí todos los que estáis trabajados y cargados, y yo os haré descansar.',
    tags: [VidaTags.descanso, VidaTags.ansiedad, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'mat19_26',
    reference: 'Mateo 19:26',
    text: 'Para los hombres esto es imposible; mas para Dios todo es posible.',
    tags: [VidaTags.fe, VidaTags.esperanza, VidaTags.fortaleza],
  ),
  VidaBankVerse(
    id: 'jn3_16',
    reference: 'Juan 3:16',
    text:
        'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
    tags: [VidaTags.amor, VidaTags.salvacion, VidaTags.fe],
  ),
  VidaBankVerse(
    id: 'jn14_27',
    reference: 'Juan 14:27',
    text:
        'La paz os dejo, mi paz os doy; yo no os la doy como el mundo la da. No se turbe vuestro corazón, ni tenga miedo.',
    tags: [VidaTags.paz, VidaTags.miedo, VidaTags.ansiedad],
  ),
  VidaBankVerse(
    id: 'jn16_33',
    reference: 'Juan 16:33',
    text:
        'En el mundo tendréis aflicción; pero confiad, yo he vencido al mundo.',
    tags: [VidaTags.esperanza, VidaTags.fortaleza, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'rom5_8',
    reference: 'Romanos 5:8',
    text:
        'Mas Dios muestra su amor para con nosotros, en que siendo aún pecadores, Cristo murió por nosotros.',
    tags: [VidaTags.amor, VidaTags.salvacion, VidaTags.perdon],
  ),
  VidaBankVerse(
    id: 'rom8_28',
    reference: 'Romanos 8:28',
    text:
        'Y sabemos que a los que aman a Dios, todas las cosas les ayudan a bien.',
    tags: [VidaTags.proposito, VidaTags.esperanza, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: 'rom8_38',
    reference: 'Romanos 8:38-39',
    text:
        'Por lo cual estoy seguro de que ni la muerte, ni la vida… podrá apartarnos del amor de Dios.',
    tags: [VidaTags.amor, VidaTags.confianza, VidaTags.soledad],
  ),
  VidaBankVerse(
    id: 'rom12_2',
    reference: 'Romanos 12:2',
    text:
        'No os conforméis a este siglo, sino transformaos por medio de la renovación de vuestro entendimiento.',
    tags: [VidaTags.proposito, VidaTags.sabiduria, VidaTags.fe],
  ),
  VidaBankVerse(
    id: '1cor10_13',
    reference: '1 Corintios 10:13',
    text:
        'No os ha sobrevenido ninguna tentación que no sea humana; fiel es Dios, que no os dejará ser tentados más de lo que podéis resistir.',
    tags: [VidaTags.tentacion, VidaTags.fortaleza, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: '1cor13_4',
    reference: '1 Corintios 13:4',
    text: 'El amor es sufrido, es benigno; el amor no tiene envidia.',
    tags: [VidaTags.amor, VidaTags.paciencia, VidaTags.gozo],
  ),
  VidaBankVerse(
    id: '2cor5_17',
    reference: '2 Corintios 5:17',
    text:
        'De modo que si alguno está en Cristo, nueva criatura es; las cosas viejas pasaron; he aquí todas son hechas nuevas.',
    tags: [VidaTags.perdon, VidaTags.proposito, VidaTags.esperanza],
  ),
  VidaBankVerse(
    id: '2cor12_9',
    reference: '2 Corintios 12:9',
    text: 'Bástate mi gracia; porque mi poder se perfecciona en la debilidad.',
    tags: [VidaTags.fortaleza, VidaTags.confianza, VidaTags.fe],
  ),
  VidaBankVerse(
    id: 'gal5_22',
    reference: 'Gálatas 5:22-23',
    text:
        'Mas el fruto del Espíritu es amor, gozo, paz, paciencia, benignidad, bondad, fe, mansedumbre, templanza.',
    tags: [VidaTags.gozo, VidaTags.paz, VidaTags.paciencia, VidaTags.amor],
  ),
  VidaBankVerse(
    id: 'ef2_8',
    reference: 'Efesios 2:8',
    text:
        'Porque por gracia sois salvos por medio de la fe; y esto no de vosotros, pues es don de Dios.',
    tags: [VidaTags.salvacion, VidaTags.fe, VidaTags.amor],
  ),
  VidaBankVerse(
    id: 'ef3_20',
    reference: 'Efesios 3:20',
    text:
        'Y a Aquel que es poderoso para hacer todas las cosas mucho más abundantemente de lo que pedimos o entendemos.',
    tags: [VidaTags.fe, VidaTags.oracion, VidaTags.esperanza],
  ),
  VidaBankVerse(
    id: 'fil4_6',
    reference: 'Filipenses 4:6-7',
    text:
        'Por nada estéis afanosos, sino sean conocidas vuestras peticiones delante de Dios… Y la paz de Dios… guardará vuestros corazones.',
    tags: [VidaTags.ansiedad, VidaTags.paz, VidaTags.oracion],
  ),
  VidaBankVerse(
    id: 'fil4_13',
    reference: 'Filipenses 4:13',
    text: 'Todo lo puedo en Cristo que me fortalece.',
    tags: [VidaTags.fortaleza, VidaTags.fe, VidaTags.proposito],
  ),
  VidaBankVerse(
    id: 'col3_15',
    reference: 'Colosenses 3:15',
    text: 'Y la paz de Dios gobierne en vuestros corazones.',
    tags: [VidaTags.paz, VidaTags.gozo, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: '1tes5_16',
    reference: '1 Tesalonicenses 5:16-18',
    text: 'Estad siempre gozosos. Orad sin cesar. Dad gracias en todo.',
    tags: [VidaTags.gozo, VidaTags.gratitud, VidaTags.oracion],
  ),
  VidaBankVerse(
    id: '2tim1_7',
    reference: '2 Timoteo 1:7',
    text:
        'Porque no nos ha dado Dios espíritu de cobardía, sino de poder, de amor y de dominio propio.',
    tags: [VidaTags.miedo, VidaTags.fortaleza, VidaTags.amor],
  ),
  VidaBankVerse(
    id: 'heb11_1',
    reference: 'Hebreos 11:1',
    text:
        'Es, pues, la fe la certeza de lo que se espera, la convicción de lo que no se ve.',
    tags: [VidaTags.fe, VidaTags.esperanza, VidaTags.confianza],
  ),
  VidaBankVerse(
    id: 'heb13_5',
    reference: 'Hebreos 13:5',
    text: 'No te desampararé, ni te dejaré.',
    tags: [VidaTags.soledad, VidaTags.confianza, VidaTags.esperanza],
  ),
  VidaBankVerse(
    id: 'stg1_5',
    reference: 'Santiago 1:5',
    text:
        'Y si alguno de vosotros tiene falta de sabiduría, pídala a Dios, el cual da a todos abundantemente.',
    tags: [VidaTags.sabiduria, VidaTags.oracion, VidaTags.fe],
  ),
  VidaBankVerse(
    id: 'stg1_12',
    reference: 'Santiago 1:12',
    text:
        'Bienaventurado el varón que soporta la tentación; porque cuando haya resistido la prueba, recibirá la corona de vida.',
    tags: [VidaTags.tentacion, VidaTags.paciencia, VidaTags.fortaleza],
  ),
  VidaBankVerse(
    id: '1pe5_7',
    reference: '1 Pedro 5:7',
    text: 'Echando toda vuestra ansiedad sobre él, porque él tiene cuidado de vosotros.',
    tags: [VidaTags.ansiedad, VidaTags.confianza, VidaTags.paz],
  ),
  VidaBankVerse(
    id: '1jn1_9',
    reference: '1 Juan 1:9',
    text:
        'Si confesamos nuestros pecados, él es fiel y justo para perdonar nuestros pecados.',
    tags: [VidaTags.perdon, VidaTags.salvacion, VidaTags.oracion],
  ),
  VidaBankVerse(
    id: '1jn4_18',
    reference: '1 Juan 4:18',
    text: 'En el amor no hay temor, sino que el perfecto amor echa fuera el temor.',
    tags: [VidaTags.miedo, VidaTags.amor, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'ap21_4',
    reference: 'Apocalipsis 21:4',
    text:
        'Enjugará Dios toda lágrima de los ojos de ellos; y ya no habrá muerte, ni más llanto.',
    tags: [VidaTags.tristeza, VidaTags.esperanza, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'sal16_11',
    reference: 'Salmos 16:11',
    text: 'Me mostrarás la senda de la vida; en tu presencia hay plenitud de gozo.',
    tags: [VidaTags.gozo, VidaTags.proposito, VidaTags.paz],
  ),
  VidaBankVerse(
    id: 'sal37_5',
    reference: 'Salmos 37:5',
    text: 'Encomienda a Jehová tu camino, y confía en él; y él hará.',
    tags: [VidaTags.confianza, VidaTags.proposito, VidaTags.paciencia],
  ),
  VidaBankVerse(
    id: 'sal139_14',
    reference: 'Salmos 139:14',
    text: 'Te alabaré; porque formidable y maravillosa es tu obra.',
    tags: [VidaTags.gratitud, VidaTags.proposito, VidaTags.amor],
  ),
];

class DailyPhrase {
  final String text;
  final String imageAsset;

  const DailyPhrase({required this.text, this.imageAsset = ''});
}

const _phrases = [
  DailyPhrase(text: 'Dios sigue trabajando en ti', imageAsset: 'contra_img/1.png'),
  DailyPhrase(text: 'La gracia es más grande que tu pecado', imageAsset: 'contra_img/2.png'),
  DailyPhrase(text: 'Respira, ora y sigue', imageAsset: 'contra_img/3.png'),
  DailyPhrase(text: 'Mantente firme en tu posición', imageAsset: 'contra_img/4.png'),
  DailyPhrase(text: 'Tu identidad está en Cristo', imageAsset: 'contra_img/5.png'),
  DailyPhrase(text: 'Lo eterno, antes que el placer', imageAsset: 'contra_img/6.png'),
  DailyPhrase(text: 'Tu lucha tiene un propósito', imageAsset: 'contra_img/7.png'),
];

DailyPhrase getTodaysPhrase() {
  final weekday = DateTime.now().weekday; // 1=Mon … 7=Sun
  return _phrases[weekday - 1];
}

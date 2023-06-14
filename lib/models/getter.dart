import './money.dart';

List<Money> geter() {
  Money upwork = Money();
  upwork.name = 'Upwork';
  upwork.fee = '650';
  upwork.time = 'today';
  upwork.image =
      'https://cdn2.iconfinder.com/data/icons/picons-social/57/79-upwork-2-512.png';
  upwork.buy = false;

  Money hotel = Money();
  hotel.name = 'The Lalits';
  hotel.fee = '1500';
  hotel.time = 'today';
  hotel.image =
      'https://www.thelalit.com/wp-content/themes/lalit/images/the-lalit-og-image.jpeg';
  upwork.buy = true;
  return [upwork, hotel];
}

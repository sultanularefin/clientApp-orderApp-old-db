
class Offer {
  DateTime  offerExpiredTime;
  DateTime  offerSetTime;
  String    imageURL;
  String    offerHeaderText;
  String    offerFooterText;
  String    offerTitle;
  double    offerPrice;
  int       sl;
  String    offerItemName;

  Offer(
      {
        this.offerExpiredTime,
        this.imageURL,
        this.offerHeaderText,
        this.offerFooterText,
        this.offerTitle,
        this.offerPrice,
        this.sl,
        this.offerItemName,
        this.offerSetTime,
      }
      );

}






//class Dummy {
//  int id;
//  String title;
//  int price;
//  int counter;
//  String url;
//  String amountPerUnit;
//  String content;
//  String level;
//  double indicatorValue;
//
//  Dummy(
//      {this.id, this.title, this.price, this.counter, this.url, this.content, this.amountPerUnit, this.level, this.indicatorValue, });
//}
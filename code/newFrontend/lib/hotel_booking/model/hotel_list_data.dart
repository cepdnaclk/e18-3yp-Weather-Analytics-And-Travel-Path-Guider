class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/hotel/Hanthana1.jpg',
      titleTxt: 'Hanthana Mountain Range',
      subTxt: 'Kandy District',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/hotel/Ella1.png',
      titleTxt: 'Badulla District',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel/Knuckles1.jpg',
      titleTxt: 'Knuckles Mountain Range',
      subTxt: 'Kandy District',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/hotel/Sinharaja1.jpg',
      titleTxt: 'Sinharaja Rain Forest',
      subTxt: 'Rathnapura | Galle | Matara',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/hotel/Riverstone1.jpg',
      titleTxt: 'Riverstone Mountain (Gap)',
      subTxt: 'Matale District',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
     HotelListData(
      imagePath: 'assets/hotel/efac.jfif',
      titleTxt: 'Faculty of Engineering',
      subTxt: 'Kandy District',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
}

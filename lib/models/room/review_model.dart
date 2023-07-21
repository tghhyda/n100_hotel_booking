import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/user_model.dart';

class ReviewModel {
  final String idReview;
  final String user;
  final String room;
  final String timeReview;
  final String detailReview;
  final int rate;

  ReviewModel(this.idReview, this.user, this.room, this.timeReview,
      this.detailReview, this.rate);

}

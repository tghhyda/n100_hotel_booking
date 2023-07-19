import 'package:n100_hotel_booking/models/room/room_model.dart';
import 'package:n100_hotel_booking/models/user_model.dart';

class ReviewModel {
  final String idReview;
  final UserModel user;
  final RoomModel room;
  final DateTime timeReview;
  final String detailReview;
  final int rate;

  ReviewModel(this.idReview, this.user, this.room, this.timeReview,
      this.detailReview, this.rate);

}

class Activity {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String imgUrl;
   final dynamic  price;
   final dynamic noShowFee;
  bool userHasSignedUp;
  final bool hasSignUp;
  final bool canSignUp;
  final bool canSignUpBackUp;
  final bool canSignOut;
  int userSingUpId;
  var organizingCommittee;
  final bool isOrganizing;
  final bool isHelping;
  final int availablePlaces;
  final bool isFull;
  final int totalPlaces;
  bool userHasSignedUpBackUp;
  final DateTime startSignup;
  final DateTime endSignup;
  final DateTime endSignout;
  final List<dynamic> participants;
  final List<dynamic> participantsBackUpList;

  Activity({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.imgUrl,
    this.price,
    this.noShowFee,
    this.userHasSignedUp,
    this.hasSignUp,
    this.canSignUp,
    this.canSignUpBackUp,
    this.canSignOut,
    this.userSingUpId,
    this.organizingCommittee,
    this.isOrganizing,
    this.isHelping,
    this.availablePlaces,
    this.isFull,
    this.totalPlaces,
    this.userHasSignedUpBackUp,
    this.startSignup,
    this.endSignout,
    this.endSignup,
    this.participants,
    this.participantsBackUpList,
  });
}

class Participant{
  String name;
  String photo;

  Participant(this.name, this.photo);
}

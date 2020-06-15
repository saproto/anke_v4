class Activity {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String imgUrl;
  final int price;
  final int noShowFee;
  bool userHasSignedUp;
  final bool hasSignUp;
  final bool canSignUp;
  final bool canSignUpBackUp;
  final bool canSignOut;
   int userSingUpId;
  var organizingCommittee;
  final bool isOrganizing;
  final bool isHelping;

  Activity(
      {this.id,
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
      this.isHelping});
}

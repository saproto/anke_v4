class Committee {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String description;
  List<Member> members = [];

  Committee({
    this.id,
    this.name,
    this.email,
    this.photo,
    this.description,
    this.members,
  });
}

class Member {
  final String name;
  final String photo;
  final String edition;
  final String role;
  final DateTime memberSince;

  Member({this.name, this.photo, this.edition, this.role, this.memberSince});
}

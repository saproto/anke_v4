import 'package:ankev928/models/comittee.dart';
import 'package:ankev928/shared/helpers/api_call.dart';

Future<List<Committee>> getCommittees(String url,
    {noAuthPresentOk = false}) async {
  List<dynamic> committeeInfo =
      await doApiGetRequestAuthenticate(url, noAuthPresentOk: noAuthPresentOk);
  List<Committee> committees = [];
  for (var i in committeeInfo) {
    List<Member> members = [];
    if (!noAuthPresentOk) {
      for (var j in i['current_members']) {
        members.add(Member(
          name: j['name'],
          photo: j['photo'],
          edition: j['edition'],
          role: j['role'],
          memberSince: DateTime.parse(j['since']),
        ));
      }
    }
    Committee committee = Committee(
      id: i['id'],
      name: i['name'],
      email: i['email'],
      photo: i['photo'],
      description:
          "this is a placeholder for when the api does give a descripton",
      members: members,
    );
    committees.add(committee);
  }

  return committees;
}

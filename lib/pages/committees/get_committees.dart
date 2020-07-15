


import 'package:ankev928/models/comittee.dart';
import 'package:ankev928/shared/helpers/api_call.dart';

Future<List<Committee>> getCommittees() async {
  List<dynamic> committeInfo =
  await doApiGetRequest('committees');
  List<Committee> committees = [];
  for (var i in committeInfo) {
    List<Member> members = [];
    for(var j in i['current_members']){
//      DateTime memberSince;
//      if(j['since'] != null){
//        memberSince = DateTime.fromMillisecondsSinceEpoch(j['since'] * 1000);
//      }
      members.add( Member (
        name: j['name'],
        photo: j['photo'],
        edition: j['edition'],
        role: j['role'],
        memberSince: DateTime.parse(j['since']),

      ));

    }
    Committee committee = Committee(
      id: i['id'],
      name: i['name'],
      email: i['email'],
      photo: i['photo'],
      description: "this is a placeholder for when the api does give a descripton",
      members: members,
    );
    committees.add(committee);
  }

  return committees;
}

import 'dart:convert';

import 'package:ankev928/models/activity.dart';
import 'package:ankev928/shared/api_call.dart';

Future<List<Activity>> getActivities() async {
  List<dynamic> calenderInfo =
      await requestApiCallResult('events/upcoming/for_user');
  List<Activity> activities = [];
  for (var i in calenderInfo) {
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(i["start"] * 1000);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(i["end"] * 1000);
    DateTime startSignup = DateTime.fromMillisecondsSinceEpoch(i["registration_start"] * 1000);
    DateTime endSignup = DateTime.fromMillisecondsSinceEpoch(i["registration_end"] * 1000);
    DateTime endSignout = DateTime.fromMillisecondsSinceEpoch(i["deregistration_end"] * 1000);


    Activity activity = Activity(
      id: i["id"],
      title: i["title"],
      description: i["description"],
      startDate: startDate,
      endDate: endDate,
      location: i["location"],
      imgUrl: i["image"],
      price: i["price"],
      noShowFee: i["no_show_fee"],
      userHasSignedUp: i["user_signedup"],
      hasSignUp: i["has_signup"],
      canSignUp: i["can_signup"],
      canSignUpBackUp: i["can_signup_backup"],
      canSignOut: i["can_signout"],
      userSingUpId: i["user_signedup_id"],
      organizingCommittee: i["organizing_committee"],
      isOrganizing: i["is_organizing"],
      isHelping: i["is_helping"],
      availablePlaces: i["available_places"],
      isFull: i["is_full"],
      totalPlaces: i["total_places"],
      userHasSignedUpBackUp: i["user_signedup_backup"],
      startSignup: startSignup,
      endSignout:  endSignout,
      endSignup: endSignup,
      participants: i["participants"],
      participantsBackUpList: i["backupParticipants"]

    );
    activities.add(activity);
  }

  return activities;
}

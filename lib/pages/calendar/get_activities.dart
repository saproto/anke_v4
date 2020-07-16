import 'package:ankev928/models/activity.dart';
import 'package:ankev928/shared/helpers/api_call.dart';

Future<List<Activity>> getActivities(String url, bool authPresent) async {
  List<dynamic> calenderInfo =
  await doApiGetRequestAuthenticate(url, noAuthPresentOk: authPresent);
  List<Activity> activities = [];
  for (var i in calenderInfo) {  
    DateTime startSignUp; 
    DateTime endSignUp; 
    DateTime endSignOut;
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(i["start"] * 1000);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(i["end"] * 1000);
    if (i["registration_start"] != null) {
      startSignUp =
          DateTime.fromMillisecondsSinceEpoch(i["registration_start"] * 1000);
    }
    if (i["registration_end"] != null) {
      endSignUp =
          DateTime.fromMillisecondsSinceEpoch(i["registration_end"] * 1000);
    }

    if (i["deregistration_end"] != null) {
      endSignOut =
          DateTime.fromMillisecondsSinceEpoch(i["deregistration_end"] * 1000);
    }



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
        startSignup: startSignUp,
        endSignout: endSignOut,
        endSignup: endSignUp,
        participants: i["participants"],
        participantsBackUpList: i["backupParticipants"]

    );
    activities.add(activity);
  }

  return activities;
}

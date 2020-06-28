import 'package:ankev928/models/activity.dart';
import 'package:ankev928/models/user_info.dart';

import 'package:rxdart/rxdart.dart';

class ActivityListService {
  BehaviorSubject _activityList = BehaviorSubject.seeded(new List<Activity>());

  Stream get stream$ => _activityList.stream;

  List<Activity> get current => _activityList.value;

  update(List<Activity> _updateActivityList) {
    _activityList.add(_updateActivityList);
  }

  static Activity getActivityById(
    List<Activity> _currentActivityList,
    int activityID,
  ) {
      for (Activity activity in _currentActivityList) {
        if (activity.id == activityID) {
          return activity;
        }
      }
    return null;
  }

  void toggleParticipation(
      {int activityID,
      bool isBackUpParticipation = false,
      bool isSignUp = true,
      int signUpId,
      UserInfo userInfo}) {
    List<Activity> _currentActivityList = current;

    for (Activity activity in _currentActivityList) {
      if (activity.id == activityID) {
        Map<String, dynamic> userParticpant = {'name': userInfo.fullName, 'photo': userInfo.photoUrl};

        if (isBackUpParticipation) {
          activity.userHasSignedUpBackUp = !activity.userHasSignedUpBackUp;
          if(isSignUp){
            activity.userSingUpId = signUpId;
            activity.participantsBackUpList.add(userParticpant);
          }  else{
            activity.participantsBackUpList.removeWhere((participant) =>
            participant['name'] == userParticpant['name'] && participant['photo'] == userParticpant['photo']
            );
            }
        } else {
          activity.userHasSignedUp = !activity.userHasSignedUp;
          if(isSignUp){
            activity.userSingUpId = signUpId;
            activity.participants.add(userParticpant);
          } else{
            activity.participants.removeWhere((participant) =>
            participant['name'] == userParticpant['name'] && participant['photo'] == userParticpant['photo']
            );
          }
        }
        break;
      }
    }

    update(_currentActivityList);
  }
}

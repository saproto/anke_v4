import 'dart:convert';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:ankev928/services/user_info_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ankev928/config/oauth.dart';
import 'package:ankev928/shared/helpers/proto_api.dart';

import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/oauth2_response.dart';

GetIt getIt = GetIt.instance;


Future<bool> checkForCredentials() async {
  OAuth2Helper oAuthHelper = _getHelper();
  dynamic availableToken =
      await oAuthHelper.tokenStorage.storage.read(oAuthHelper.client.tokenUrl);
  return availableToken != null;
}

Future<dynamic> doApiGetRequestAuthenticate(String urlExtension,
    {bool noAuthPresentOk = false}) async {
  try{
    http.Response resp;
    if(!noAuthPresentOk) {
      Map<String, String> headers = {'Accept': 'application/json'};
      resp = await _getHelper()
          .get(oauthCredentials['baseurl'] + urlExtension, headers: headers);
    } else {
      resp = await http.get(oauthCredentials['baseurl'] + urlExtension);
    }


    dynamic info = jsonDecode(resp.body);
    return info;
  }catch (e ) {
    if(e.error == "invalid_request"){
      logOutUser();
    }
  }



}

Future<dynamic> doApiPostRequest(String urlExtension, Map<String, String> data,
    {bool noAuthPresentOk = false}) async {
  String encodedData = getEncodeData(data);
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  http.Response resp = await _getHelper().post(
      oauthCredentials['baseurl'] + urlExtension,
      headers: headers,
      body: encodedData);
  dynamic info = jsonDecode(resp.body);
  return info;
}

String getEncodeData(Map<String, String> data) {
  List<String> stringData = [];
  data.forEach((key, value) {
    stringData.add('$key=$value');
  });
  return stringData.join('&');
}

Future<dynamic> revokeTokens() async {
  OAuth2Helper oAuth2Helper = _getHelper();
  Future<OAuth2Response> resp = oAuth2Helper.disconnect();
  return resp;
}

OAuth2Helper _getHelper() {
  ProtoOAuth2Client protoApi = ProtoOAuth2Client();
  return OAuth2Helper(protoApi,
      grantType: OAuth2Helper.AUTHORIZATION_CODE,
      clientId: oauthCredentials['id'],
      clientSecret: oauthCredentials['secret'],
      scopes: ['*']);
}

void logOutUser() async{
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
  final ActivityListService _activityListService =
  getIt.get<ActivityListService>();

  revokeTokens();
  await _userInfoService.resetAndWriteToSharedPrefs();
  _activityListService.doUnAuthorizedActivityCall();
}
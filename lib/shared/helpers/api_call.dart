import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ankev928/config/oauth.dart';
import 'package:ankev928/shared/helpers/proto_api.dart';

import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/oauth2_response.dart';

Future<bool> checkForCredentials() async {
  OAuth2Helper oAuthHelper = _getHelper();
  dynamic availableToken =
      await oAuthHelper.tokenStorage.storage.read(oAuthHelper.client.tokenUrl);
  return availableToken != null;
}

Future<dynamic> requestApiCallResult(String urlExtension,
    {bool noAuthPresentOk = false}) async {
  Map<String, String> headers = {'Accept': 'application/json'};
  http.Response resp = await _getHelper()
      .get(oauthCredentials['baseurl'] + urlExtension, headers: headers);
//  print(resp);
  dynamic info = jsonDecode(resp.body);
  return info;
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

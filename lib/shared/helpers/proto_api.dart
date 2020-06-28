import 'package:oauth2_client/oauth2_client.dart';

class ProtoOAuth2Client extends OAuth2Client {
  ProtoOAuth2Client(): super(
      authorizeUrl: 'https://www.proto.utwente.nl/oauth/authorize',
      tokenUrl: 'https://www.proto.utwente.nl/oauth/token',
      redirectUri: 'nl.saproto.anke://redirect',
      customUriScheme: 'nl.saproto.anke'
  );
}
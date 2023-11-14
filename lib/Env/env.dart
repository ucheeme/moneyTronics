
import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASEURL')
  static const String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'API_GATEWAY')
  static const String apiGateway = _Env.apiGateway;
  @EnviedField(varName: 'API_KEY')
  static const String apiKey = _Env.apiKey;
}
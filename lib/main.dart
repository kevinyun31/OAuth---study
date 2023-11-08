import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
      nativeAppKey: '308d36ccda57c7def6b881f5ddbe6b6e',
      javaScriptAppKey: '02380637c3a516043316602b58bd919f');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("카카오 로그인 서비스", style: TextStyle(fontSize: 30)),
          ElevatedButton(
              onPressed: () async {
                if (await isKakaoTalkInstalled()) {
                  print("카카오톡이 설치되어 있습니다");
                  await UserApi.instance.loginWithKakaoTalk();
                } else {
                  print("카카오톡이 설치되어 있지 않습니다");
                  OAuthToken oauthToken =
                      await UserApi.instance.loginWithKakaoAccount();
                  print(oauthToken.accessToken);
                  print(oauthToken.expiresAt);
                  print(oauthToken.scopes![0]);
                }
              },
              child: Text("카카오로그인")),
        ],
      ),
    );
  }
}

# 해야 할 것
  - 안되는 기종 잡기
  - 플레임 버전 올리기 (바로 안 된다.. 할게 많은거 보니 아예 새로 만드는게 좋을 듯.)




# 키스토어
  - https://flutter-ko.dev/docs/deployment/android

  - 등록
    - keytool -genkey -v -keystore squid-release-key.jks -alias key -keyalg RSA -keysize 2048 -validity 10000

  - 키스토어 정보
    - 키 저장소 비밀번호 입력: ganer1324.
    - 이름과 성을 입력하십시오: ganer
    - 조직 단위 이름을 입력하십시오.: ganer
    - 조직 이름을 입력하십시오.: ganer
    - 구/군/시 이름을 입력하십시오?: seoul
    - 시/도 이름을 입력하십시오.: seoul
    - 이 조직의 두 자리 국가 코드를 입력하십시오.: KR
    - <key>에 대한 키 비밀번호를 입력하십시오.
        - ga1324
    - Warning:
      JKS 키 저장소는 고유 형식을 사용합니다. "keytool -importkeystore -srckeystore lotto-release-key.jks -destkeystore lotto-release-key.jks -deststoretype pkcs12"를 사용하는 산업 표준 형식인 PKCS12로 이전하는 것이 좋습니다.


    - app bundle 키 만들기
      java -jar pepk.jar --keystore=squid-release-key.jks --alias=key --output=squid-release-key.private_key --encryptionkey=eb10fe8f7c7c9df715022017b00c6471f8ba8170b13049a11e6c09ffe3056a104a3bbe4ac5a955f4ba4fe93fc8cef27558a3eb9d2a529a2092761fb833b656cd48b9de6a


keytool -keystore squid-release-key.jks -list -v
인증서 지문:
         MD5:  D4:9B:22:33:16:DE:C5:6D:B4:AF:90:36:07:03:47:92
         SHA1: 14:F9:92:DC:6F:88:C5:40:39:14:CB:1F:93:C8:E3:F4:EA:EC:EF:E9
         SHA256: A1:04:60:EB:7A:7B:B9:CD:AA:A1:32:F2:C8:9E:A5:89:1D:70:12:9E:14:06:B7:2E:52:88:2D:45:43:10:D2:C6


# 배포
  - 배포용
  - flutter build appbundle --release --no-sound-null-safety
  - mv ./build/app/outputs/bundle/release/app-release.aab ~/Downloads/squid.aab

  - 확인용
  - flutter build apk --release --no-sound-null-safety
  - mv ./build/app/outputs/apk/release/app-release.apk ~/Downloads/squid.apk
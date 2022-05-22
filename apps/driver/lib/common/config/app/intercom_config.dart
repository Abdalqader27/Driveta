// // Created By Abd Alqader Alnajjar  2021 / 12 / 20

class IntercomConfig {
  final String appId;
  final String iosApiKey;
  final String androidApiKey;

  const IntercomConfig({
    required this.appId,
    required this.iosApiKey,
    required this.androidApiKey,
  });
}

const kIntercom = IntercomConfig(
  appId: 'wfcn573j',
  androidApiKey: 'android_sdk-82101752359ff2c63de750089818fc4ded8b8646',
  iosApiKey: 'ios_sdk-f82cc73cab28b6a312b8b5a8df7e9c6bdce0ae3a',
);

enum DevicePlatform {
  android('ANDROID'),
  ios('IOS'),
  web('WEB');

  const DevicePlatform(this.apiValue);

  final String apiValue;
}

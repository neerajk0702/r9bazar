enum Flavor { DEV, PROD, QA, LOCAl }

class Config {
  static Flavor appFlavor;

  static String get oauthUrl {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'https://oauth.kidschaupal.com/';
      case Flavor.QA:
        return 'https://dlpdemoapi.bluelup.in/';
      case Flavor.LOCAl:
        return 'https://oauthkcdev.bluelup.in';
      default:
        return 'https://oauthkcdev.bluelup.in';
    }
  }
}

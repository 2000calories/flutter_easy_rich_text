library patterns;

class EasyRegexPattern {
  static const emailPattern =
      '\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}\\b';
  static const webPattern =
      //(?!(\/EMAILPATTERN\/))
      //ignore domain from email
      '(http(s)?:\\/\\/.)?(www\\.)?[-a-zA-Z0-9:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)';
  static const telPattern = "[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[ -/0-9]{5,11}";
  static const boldPattern = '(\\*)(.*?)(\\*)';
  static const italicPattern = '(_)(.*?)(_)';
}

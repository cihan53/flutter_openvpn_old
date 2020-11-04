import 'dart:convert';

String decodeBase64(String str) {
  //'-', '+' 62nd char of encoding,  '_', '/' 63rd char of encoding
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    // Pad with trailing '='
    case 0: // No pad chars in this case
      break;
    case 2: // Two pad chars
      output += '==';
      break;
    case 3: // One pad char
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

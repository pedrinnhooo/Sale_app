// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A library for broadly-useful functions and regular expressions for scanning
/// HTTP entities.
///
/// Many of the regular expressions come from [section 2.2 of the HTTP
/// spec][spec].
///
/// [spec]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec2.html
import '../../../string_scanner-1.0.5/lib/string_scanner.dart';

/// HTTP entities.
///
/// Many of the regular expressions come from [section 2.2 of the HTTP
/// spec][spec].
///
/// [spec]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec2.html

/// An HTTP token.
final token = new RegExp(r'[^()<>@,;:"\\/[\]?={} \t\x00-\x1F\x7F]+');

/// Linear whitespace.
final _lws = new RegExp(r"(?:\r\n)?[ \t]+");

/// A quoted string.
final _quotedString = new RegExp(r'"(?:[^"\x00-\x1F\x7F]|\\.)*"');

/// A quoted pair.
final _quotedPair = new RegExp(r'\\(.)');

/// A character that is *not* a valid HTTP token.
final nonToken = new RegExp(r'[()<>@,;:"\\/\[\]?={} \t\x00-\x1F\x7F]');

/// A regular expression matching any number of [_lws] productions in a row.
final whitespace = new RegExp("(?:${_lws.pattern})*");

/// Parses a list of elements, as in `1#element` in the HTTP spec.
///
/// [scanner] is used to parse the elements, and [parseElement] is used to parse
/// each one individually. The values returned by [parseElement] are collected
/// in a list and returned.
///
/// Once this is finished, [scanner] will be at the next non-LWS character in
/// the string, or the end of the string.
List<T> parseList<T>(StringScanner scanner, T parseElement()) {
  var result = <T>[];

  // Consume initial empty values.
  while (scanner.scan(",")) {
    scanner.scan(whitespace);
  }

  result.add(parseElement());
  scanner.scan(whitespace);

  while (scanner.scan(",")) {
    scanner.scan(whitespace);

    // Empty elements are allowed, but excluded from the results.
    if (scanner.matches(",") || scanner.isDone) continue;

    result.add(parseElement());
    scanner.scan(whitespace);
  }

  return result;
}

/// Parses a single quoted string, and returns its contents.
///
/// If [name] is passed, it's used to describe the expected value if it's not
/// found.
String expectQuotedString(StringScanner scanner, {String name}) {
  if (name == null) name = "quoted string";
  scanner.expect(_quotedString, name: name);
  var string = scanner.lastMatch[0];
  return string
      .substring(1, string.length - 1)
      .replaceAllMapped(_quotedPair, (match) => match[1]);
}

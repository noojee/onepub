// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:onepub/src/pub/command/add.dart';

import '../exceptions.dart';
import '../onepub_settings.dart';
import '../util/one_pub_token_store.dart';

/// Handles the `add` pub command. Adds a dependency to `pubspec.yaml` and gets
/// the package. The user may pass in a git constraint, host url, or path as
/// requirements. If no such options are passed in, this command will do a
/// resolution to find the latest version of the package that is compatible with
/// the other dependencies in `pubspec.yaml`, and then enter that as the lower
/// bound in a ^x.y.z constraint.
///
/// Currently supports only adding one dependency at a time.
class AddPrivateCommand extends AddCommand {
  @override
  String get name => 'add';
  @override
  String get description => 'Add private dependencies to pubspec.yaml.';
  @override
  String get argumentsDescription =>
      '<package>[:<constraint>] [<package2>[:<constraint2>]...] [options]';
  @override
  String get docUrl => 'https://dart.dev/tools/pub/cmd/pub-add';

  String? get hostUrl {
    final url = OnePubSettings().onepubHostedUrl().toString();
    print(url);
    return url;
  }

  @override
  bool get isOffline => false;

  String? get gitUrl => null;
  String? get gitPath => null;
  String? get gitRef => null;
  String? get path => null;

  bool get hasHostOptions => hostUrl != null;

  AddPrivateCommand() : super(includeSourceOptions: false) {
    OnePubSettings.load();

    if (!OnePubTokenStore().isLoggedIn) {
      throw ExitException(
          exitCode: 1, message: "You must run 'onepub login' first.");
    }
  }
}

import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/features/presentation/pages/about_app/pub_spec.dart';

import '../../../../generated/assets.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutPage(
      values: {
        'version': Pubspec.version,
        'buildNumber': Pubspec.versionBuild.toString(),
        'year': DateTime.now().year.toString(),
        'author': Pubspec.authorsName.join(', '),
        'authors': Pubspec.authors.join(''),
      },
      title: const Text('حول التطبيق'),
      applicationName: Pubspec.name,
      applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationDescription: const Text(
        Pubspec.description,
        textAlign: TextAlign.justify,
      ),
      applicationIcon: Lottie.asset(Assets.lottieCarAnim, height: 350),
      applicationLegalese: 'Copyright © {{ authors }} {{ year }}',
      // children: const <Widget>[
      //   MarkdownPageListTile(
      //     filename: 'README.md',
      //     title: Text('View Readme'),
      //     icon: Icon(Icons.all_inclusive),
      //   ),
      //   MarkdownPageListTile(
      //     filename: 'CHANGELOG.md',
      //     title: Text('View Changelog'),
      //     icon: Icon(Icons.view_list),
      //   ),
      //   MarkdownPageListTile(
      //     filename: 'LICENSE.md',
      //     title: Text('View License'),
      //     icon: Icon(Icons.description),
      //   ),
      //   MarkdownPageListTile(
      //     filename: 'CONTRIBUTING.md',
      //     title: Text('Contributing'),
      //     icon: Icon(Icons.share),
      //   ),
      //   MarkdownPageListTile(
      //     filename: 'CODE_OF_CONDUCT.md',
      //     title: Text('Code of conduct'),
      //     icon: Icon(Icons.sentiment_satisfied),
      //   ),
      //   LicensesPageListTile(
      //     title: Text('Open source Licenses'),
      //     icon: Icon(Icons.favorite),
      //   ),
      // ],
    );
  }
}

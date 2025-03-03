import 'package:application_cheatsheets/app/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppLogoImageSmall extends StatelessWidget {
  final String url;
  const AppLogoImageSmall({required this.url, super.key});

  @override
  Widget build(BuildContext context) => Card(
        elevation: 8,
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedImage(
              imageUrl: url,
              width: 30, // Size of the circular image
              height: 30,
            )),
      );
}

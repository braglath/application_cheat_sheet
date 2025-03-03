import 'package:application_cheatsheets/app/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';

class GlossyCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final Function()? onTap;

  const GlossyCard({
    super.key,
    this.imageUrl,
    this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8, // Increase elevation for a more pronounced 3D effect
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16), // Round corners for a smooth look
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Match the rounded corners
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Display image with full width and height if available
              imageUrl == null || imageUrl!.isEmpty
                  ? const SizedBox.shrink()
                  : CachedImage(
                      imageUrl: imageUrl ?? '',
                      fit: BoxFit.cover, // Ensure image fills the Card
                      width: double.infinity, // Full width
                      height: double.infinity, // Full height
                    ),
              // Glossy overlay with gradient effect
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(
                          0.5), // Semi-transparent bottom for gloss
                    ],
                  ),
                ),
              ),
              // Text overlay
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.white
                    .withOpacity(0.7), // Light opacity for glossy effect
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

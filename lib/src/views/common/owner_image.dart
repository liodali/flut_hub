import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../common/flut_hub_icons_icons.dart';

class OwnerImage extends StatelessWidget {
  final String url;
  final Size? size;
  final BoxFit? fit;
  final Widget? errorWidget;

  const OwnerImage({
    Key? key,
    required this.url,
    this.size,
    this.fit,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      maxHeightDiskCache: 100,
      maxWidthDiskCache: 100,
      height: size?.height,
      width: size?.width,
      filterQuality: FilterQuality.high,
      imageBuilder: (ctx, providerImg) {
        return CircleAvatar(
          foregroundImage: providerImg,
        );
      },
      fit: fit,
      errorWidget: (ctx, x, p) {
        return Center(
          child: errorWidget ??
              Icon(
                FlutHubIcons.githubLogoFace,
                color: Colors.grey[300],
                size: 24,
              ),
        );
      },
    );
  }
}

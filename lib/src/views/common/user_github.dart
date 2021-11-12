import 'package:auto_size_text/auto_size_text.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';

import 'owner_image.dart';

class UserGithub extends StatelessWidget {
  final Owner owner;

  const UserGithub({Key? key, required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OwnerImage(
          url: owner.avatar,
          size: const Size.square(32),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: AutoSizeText(
            owner.login,
          ),
        ),
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flut_hub/src/views/common/badge_filter.dart';
import 'package:flut_hub/src/views/common/list_badges.dart';
import 'package:flut_hub/src/views/common/search_text_item_repo.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';

import '../common/user_github.dart';

class ItemRepo extends StatelessWidget {
  final GithubRepo repo;

  const ItemRepo({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Colors.grey[800]!,
          width: 0.6,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextItemRepo(
              repoFullName: repo.fullName,
            ),
            const SizedBox(
              height: 3.0,
            ),
            UserGithub(
              owner: repo.owner,
            ),
            if (repo.description != null) ...[
              const SizedBox(
                height: 5.0,
              ),
              AutoSizeText(
                repo.description!,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.grey,
                    ),
                maxLines: 2,
                maxFontSize: 17,
                minFontSize: 15,
              ),
            ],
            const SizedBox(
              height: 2.0,
            ),
            ListBadges(
              badges: [
                if (repo.stars != null) ...[
                  BadgeFilter(
                    title: Text("${repo.stars!}"),
                    icon: const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.yellow,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ],
                if (repo.language != null) ...[
                  BadgeFilter(
                    title: Text(repo.language!),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ]
              ],
              isScrollable: false,
            ),
          ],
        ),
      ),
    );
  }
}

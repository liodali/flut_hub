import 'package:auto_size_text/auto_size_text.dart';
import 'package:flut_hub/src/views/common/badge_filter.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';

class ItemIssueRepo extends StatelessWidget {
  final String repoName;
  final GithubIssue issue;

  const ItemIssueRepo({
    Key? key,
    required this.repoName,
    required this.issue,
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: AutoSizeText.rich(
                    TextSpan(
                      text: "$repoName ",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                      children: [
                        TextSpan(
                          text: "#${issue.number}",
                          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.grey),
                    minFontSize: 17,
                    maxFontSize: 18,
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Align(
                    widthFactor: 0.9,
                    alignment: Alignment.centerRight,
                    child: Text(
                      differenceDaysFromNow(issue.createdAt),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: AutoSizeText(
                issue.title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                minFontSize: 15,
                maxFontSize: 17,
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            AutoSizeText.rich(
              TextSpan(
                text: "Opened By ",
                children: [
                  TextSpan(
                      text: issue.user.login,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondaryVariant)),
                ],
              ),
            ),
            BadgeFilter(
              title: Text("\t${issue.commentsCount}\t"),
              icon: const Icon(
                Icons.chat_bubble_outlined,
                size: 16,
              ),
            ),
            // if (issue.description != null) ...[
            //   const SizedBox(
            //     height: 8.0,
            //   ),
            //   AutoSizeText(
            //     repo.description!,
            //     style: Theme.of(context).textTheme.bodyText1?.copyWith(
            //       color: Colors.grey,
            //     ),
            //     maxLines: 2,
            //     maxFontSize: 15,
            //     minFontSize: 11,
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}

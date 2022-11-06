import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantngo_frontend/models/quest_progress.dart';

class QuestSection extends StatelessWidget {
  Future<List<QuestProgress>> questProgress;

  QuestSection({
    super.key,
    required this.questProgress,
  });

  @override
  Widget build(BuildContext context) {
    String processTitle(String type, int countToComplete) {
      String title = "";
      if (type == "order") {
        title += "Make a total of $countToComplete order(s)";
      } else if (type == "login") {
        title += "Login to the app today";
      }
      return title;
    }

    return FutureBuilder<List<QuestProgress>>(
      future: questProgress,
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final result = snapshot.data![index];

                DateTime questEnd = DateTime.parse(result.endDateTime!);
                final daysTillQuestEnd =
                    questEnd.difference(DateTime.now()).inDays;
                return Card(
                  surfaceTintColor: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 150,
                      width: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            processTitle(result.type!, result.countToComplete!),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LinearProgressIndicator(
                            value: (result.countCompleted!.toDouble()) /
                                result.countToComplete!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$daysTillQuestEnd days left",
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                "${result.countCompleted!}/${result.countToComplete!}",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 80,
                    child: SvgPicture.asset(
                        "assets/graphics/calendar_completed.svg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "That's all for today. \nCome back again tomorrow for more quests!",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        }

        return SizedBox(
          height: 150,
          child: Center(
            child: const CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}

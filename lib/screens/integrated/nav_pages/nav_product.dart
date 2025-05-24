import 'package:flutter/material.dart';



class NavProductPage extends StatelessWidget {
  const NavProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Made for you",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none_rounded),
                  ),
                  // SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.replay_rounded),
                  ),
                  // SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings_rounded),
                  ),
                ],
              ),

              // SizedBox(
              //   height: 200,

              //   child: ListView.builder(
              //     //itemCount: musicList.length,
              //     scrollDirection: Axis.horizontal,
              //     shrinkWrap: true,
              //     itemBuilder:
              //         ((context, index) =>NouveauteWidget(musicModel: musicList[index])),
              //   ),
              // ),

              // SizedBox(
              //   height: 200,

              //   child: ListView.builder(
              //     //itemCount: trendingList.length,
              //     scrollDirection: Axis.horizontal,
              //     shrinkWrap: true,
              //     itemBuilder:
              //         ((context, index) =>NouveauteWidget(musicModel: trendingList[index])),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
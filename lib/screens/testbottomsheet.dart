import 'package:flutter/material.dart';

class TestBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test des BottomSheet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Affiche le BottomSheet en fonction du thème actuel
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Ceci est un BottomSheet',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  );
                },
                // backgroundColor:
                //     Theme.of(context).bottomSheetTheme.backgroundColor,
                // shape: Theme.of(context).bottomSheetTheme.shape,
                // showDragHandle:
                //     Theme.of(context).bottomSheetTheme.showDragHandle,
                // constraints: Theme.of(context).bottomSheetTheme.constraints,
              );
            },
            child: Text('Afficher BottomSheet'),
          ),
        ),
      ),
    );
  }
}
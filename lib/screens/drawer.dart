import 'package:flutter/material.dart';
//import './home.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.onSelectScreenFromDrawer});

  final void Function(String identifier) onSelectScreenFromDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Row(
                  children: [
                    Text(
                      'Expense Tracker',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    )
                  ],
                )),
          ),
          ListTile(
            leading: const Icon(
              Icons.poll_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Statistics',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('Statistics');
            },
          )
        ],
      ),
    );
  }
}

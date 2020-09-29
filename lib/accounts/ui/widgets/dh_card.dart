import 'package:flutter/material.dart';

class DhCard extends StatelessWidget {
  final String title;
  final bool isActive;
  final int dropsNumber;
  const DhCard({this.title, this.isActive, this.dropsNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(isActive ? 'Active' : 'Blocked'), Text(dropsNumber.toString() + 'drops')],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (_) {},
            itemBuilder: (BuildContext context) {
              return {'Unblock', 'Edit'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

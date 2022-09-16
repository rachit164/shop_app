import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(this.title, this.imageUrl, {Key? key})
      : super(key: key);

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
          ),
        ],
      ),
    );
  }
}

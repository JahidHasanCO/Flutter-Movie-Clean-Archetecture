import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    title: const Text('Movies'),
    actions: const [
      IconButton(
        icon: Icon(CupertinoIcons.search),
        onPressed: null,
      ),
    ],
  );
}

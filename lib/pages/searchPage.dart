// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_7/ui_helper/stylesHelper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),),
        actions: [
          IconButton(onPressed: (){}, icon:const Icon(
            Icons.close,
            color: Colors.grey,
          ))
        ],
        title: TextField(
          decoration:const InputDecoration(
              hintText: "Görev Arayın", border: InputBorder.none),
          style: stylesHelper.searchAppbarTextStyle,    
        ),
      ),
    );
  }
}

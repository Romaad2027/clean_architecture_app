import 'package:clear_architecture_practise/feature/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_searh_delegat.dart';
import '../widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: PersonsList(),
    );
  }
}


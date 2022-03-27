import 'package:clear_architecture_practise/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:clear_architecture_practise/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:clear_architecture_practise/feature/presentation/widgets/searc_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/person_entity.dart';
import '../bloc/search_bloc/search_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          return close(context, null);
        },
        tooltip: 'Back',
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (state is PersonSearchLoaded) {
          final person = state.persons;

          if (person.isEmpty) {
            return _showErrorText('No characters found');
          }
          return ListView.builder(
              itemCount: person.isNotEmpty ? person.length : 0,
              itemBuilder: (context, index) {
                PersonEntity result = person[index];
                return SearchResult(personResult: result);
              });
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) => Text(
        _suggestions[index],
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _suggestions.length,
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

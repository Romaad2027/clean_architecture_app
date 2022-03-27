import 'dart:async';

import 'package:clear_architecture_practise/feature/domain/entities/person_entity.dart';
import 'package:clear_architecture_practise/feature/presentation/bloc/peson_list_cubit/person_list_cubit.dart';
import 'package:clear_architecture_practise/feature/presentation/widgets/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/peson_list_cubit/person_list_state.dart';

class PersonsList extends StatelessWidget {
  PersonsList({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  final int page = -1;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          //BlocProvider.of<PersonListCubit>(context).loadPerson();
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;

    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      } else if (state is PersonError) {
        return Text(state.message);
      } else if (state is PersonLoading) {
        persons = state.oldPersonsList;
        isLoading = !isLoading;
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if(index < persons.length){
              return PersonCard(person: persons[index]);
            }else{
              Timer(const Duration(seconds: 3), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemCount: persons.length + (isLoading ? 1 : 0));
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

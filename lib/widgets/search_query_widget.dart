import 'package:file_finder/widgets/search_form_widget.dart';
import 'package:file_finder/widgets/search_results_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/file_search_bloc.dart';

class SearchQueryWidget extends StatefulWidget {
  final FileSearchBloc bloc;

  const SearchQueryWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  State<SearchQueryWidget> createState() => _SearchQueryState(bloc: bloc);
}

class _SearchQueryState extends State<SearchQueryWidget> {
  final TextEditingController _pathFormFieldController = TextEditingController(text: '');
  final FileSearchBloc bloc;

  _SearchQueryState({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: bloc.isLoading,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return Column(
              children: [
                SearchFormWidget(bloc: bloc),
                SearchResultsWidget(bloc: bloc)
              ],
            );
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pathFormFieldController.dispose();
    bloc.dispose();
  }

}

import 'package:file_finder/models/file_search_request.dart';
import 'package:file_finder/widgets/search_form_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../bloc/file_search_bloc.dart';
import '../models/file_search_result.dart';

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
    return SearchFormWidget(bloc: bloc);
  }

  @override
  void dispose() {
    super.dispose();
    _pathFormFieldController.dispose();
  }
}

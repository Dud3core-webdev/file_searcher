import 'package:file_finder/mappers/common_files_mapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../bloc/file_search_bloc.dart';
import '../models/file_search_request.dart';
import '../models/file_search_result.dart';

class SearchFormWidget extends StatefulWidget {
  final FileSearchBloc bloc;
  const SearchFormWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  State<SearchFormWidget> createState() => _SearchFormWidgetState(bloc: bloc);
}

class _SearchFormWidgetState extends State<SearchFormWidget> {

  final FileSearchRequest _request = FileSearchRequest();
  final FileSearchBloc bloc;
  final List<DropdownMenuItem<String>> dropdownItems = CommonFileMapper.getDropdownMenuItems();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pathFormFieldController = TextEditingController(text: '');
  final TextEditingController _searchQueryFormFieldController = TextEditingController(text: '');

  late String fileExtensionsToSearchAgainst = "";
  late String fileSearchQuery = "";

  _SearchFormWidgetState({ required this.bloc });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: StreamBuilder(
        stream: bloc.all,
        builder: (context, AsyncSnapshot<List<FileSearchResult>> snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('File Search', textScaleFactor: 3.00),
                          const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Flexible(
                            child: TextFormField(
                              validator: (value) => _validateFormField(value, 'Please enter a search query'),
                              controller: _searchQueryFormFieldController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your search query (either a file name or string)',
                                labelText: 'Query'
                              ),
                              onChanged: (String? value) {
                                _request.searchTerm = value!;
                              },
                            )
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ElevatedButton(onPressed: () => selectDirectoryToSearch(), child: const Text('Select Path')),
                              const Padding(padding: EdgeInsets.only(right: 16.0)),
                              Flexible(
                                child: TextFormField(
                                  controller: _pathFormFieldController,
                                  validator: (value) => _validateFormField(value, 'Please enter a path to search in'),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter the path you want to query (e.g. C:\\User\\Documents)',
                                    labelText: 'Path'
                                  ),
                                  onChanged: (String? value) {
                                    _request.basePath = value!;
                                  },
                                )
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                children: [
                                  const Text("Select a File Type to add to the search query (You can select multiple)"),
                                  DropdownButton(
                                    items: dropdownItems,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    onChanged: (String? value) => onFileTypeSelected(value!)
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(right: 16.0)),
                              Column(
                                children: [
                                  const Text("Files you have searched so far"),
                                  const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                  Text(fileExtensionsToSearchAgainst)
                                ],
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed: () => submitForm(), child: const Text('Search')),
                              ElevatedButton(onPressed: () => onResetSearchParameters(), child: const Text('Reset All Search Parameters')),
                              ElevatedButton(onPressed: () => onResetForm(), child: const Text('Remove all file extensions'))
                            ],
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }

  void submitForm() {
    bloc.request = _request;
    bloc.update();
  }

  void selectDirectoryToSearch() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      return;
    }

    _request.basePath = selectedDirectory;
    _pathFormFieldController.text = selectedDirectory;
  }

  void onFileTypeSelected(String fileExtension) {
    _request.addFileExtension(fileExtension);
    _setFileExtensionsToSearchAgainst();
  }

  void onResetForm() {
    _request.resetFileExtensions();
    _setFileExtensionsToSearchAgainst();
  }

  void onResetSearchParameters() {
    _request.resetAllSearchParameters();
    _pathFormFieldController.text = "";
    _searchQueryFormFieldController.text = "";
    _setFileExtensionsToSearchAgainst();
  }

  String? _validateFormField(value, String errorMessage) {
    if (value.isEmpty) {
      return errorMessage;
    }

    return null;
  }

  void _setFileExtensionsToSearchAgainst() {
    setState(() => {
      fileExtensionsToSearchAgainst = _request.fileExtensions.toString(),
    });
  }

}
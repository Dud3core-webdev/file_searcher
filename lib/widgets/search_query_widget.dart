import 'package:file_finder/models/file_search_request.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../services/file_search_service.dart';

class SearchQueryWidget extends StatefulWidget {
  const SearchQueryWidget({Key? key}) : super(key: key);

  @override
  State<SearchQueryWidget> createState() => _SearchQueryState();
}

class _SearchQueryState extends State<SearchQueryWidget> {

  final FileSearchRequest _request = FileSearchRequest();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pathFormFieldController = TextEditingController(text: '');
  final FileSearchService _fileSearchService = FileSearchService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('File Search', textScaleFactor: 3.00),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Flexible(
                        child: TextFormField(
                          validator: (value) => _validateFormField(value, 'Please enter a search query'),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your search query (either a file name or string)',
                            labelText: 'Query'
                          ),
                          onSaved: (String? value) {
                            _request.searchTerm = value!;
                          },
                        )
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                              onPressed: () => selectDirectoryToSearch(),
                              child: const Text('Select Path')
                          ),
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
                              onSaved: (String? value) {
                                _request.basePath = value!;
                              },
                            )
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      ElevatedButton(
                        onPressed: () => submitForm(),
                        child: const Text('Search')
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pathFormFieldController.dispose();
  }

  void submitForm() {
    _fileSearchService.searchFiles(_request);
  }

  void selectDirectoryToSearch() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if(selectedDirectory == null) {
      return;
    }

    _request.basePath = selectedDirectory;
    _pathFormFieldController.text = selectedDirectory;
  }

  String? _validateFormField(value, String errorMessage) {
    if (value.isEmpty) {
      return errorMessage;
    }

    return null;
  }
}

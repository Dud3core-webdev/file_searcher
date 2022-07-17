import 'package:flutter/material.dart';

import '../bloc/file_search_bloc.dart';
import '../models/file_search_result.dart';

class SearchResultsWidget extends StatefulWidget {
  final FileSearchBloc bloc;

  const SearchResultsWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultsWidget(bloc: bloc);
}

class _SearchResultsWidget extends State<SearchResultsWidget> {
  final FileSearchBloc bloc;

  _SearchResultsWidget({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.all,
      builder: (context, AsyncSnapshot<List<FileSearchResult>> snapshot) {
        return Flexible(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 12,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (!snapshot.hasData || snapshot.data!.isEmpty)
                  const Text("There are no search results, try a search?"),
                if (snapshot.hasData)
                  DataTable(
                      columns: const [
                        DataColumn(label: Text('File Name', style: TextStyle(fontStyle: FontStyle.italic))),
                        DataColumn(label: Text('File Path', style: TextStyle(fontStyle: FontStyle.italic))),
                      ],
                      rows: List<DataRow>.generate(
                          snapshot.data!.length,
                          growable: true,
                          (index) => DataRow(cells: [
                                DataCell(Text(snapshot.data![index].fileName)),
                                DataCell(Text(snapshot.data![index].filePath)),
                              ]
                          )
                      )
                  )
              ],
            ),
          ),
        ));
      }
    );
  }
}

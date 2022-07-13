import 'package:file_finder/models/bloc.dart';
import 'package:file_finder/services/file_search_service.dart';
import 'package:rxdart/rxdart.dart';

import '../models/file_search_request.dart';
import '../models/file_search_result.dart';

class FileSearchBloc implements Bloc<List<FileSearchResult>> {

  final FileSearchService _fileSearchService;
  final PublishSubject<List<FileSearchResult>> _subject = PublishSubject<List<FileSearchResult>>();

  late FileSearchRequest _request = FileSearchRequest();

  FileSearchBloc(this._fileSearchService);

  @override
  Stream<List<FileSearchResult>> get all => _subject.stream;

  set request(FileSearchRequest request) {
    _request = request;
  }

  @override
  void dispose() {
    _subject.close();
  }

  @override
  void update() async {
    List<FileSearchResult> fileSearchResults = await _fileSearchService.searchFiles(_request);
    _subject.sink.add(fileSearchResults);
  }
}
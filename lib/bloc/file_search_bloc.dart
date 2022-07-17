import 'package:file_finder/models/bloc.dart';
import 'package:file_finder/services/file_search_service.dart';
import 'package:rxdart/rxdart.dart';

import '../models/file_search_request.dart';
import '../models/file_search_result.dart';

class FileSearchBloc implements Bloc<List<FileSearchResult>> {

  final FileSearchService _fileSearchService;
  final PublishSubject<List<FileSearchResult>> _subject = PublishSubject<List<FileSearchResult>>();
  final PublishSubject<bool> _isSearchingSubject = PublishSubject<bool>();

  late FileSearchRequest _request = FileSearchRequest();

  FileSearchBloc(this._fileSearchService);

  @override
  Stream<List<FileSearchResult>> get all => _subject.stream;
  Stream<bool> get isLoading => _isSearchingSubject.stream;

  set request(FileSearchRequest request) {
    _request = request;
  }

  @override
  void dispose() {
    _subject.close();
  }

  @override
  void update() async {
    _isSearchingSubject.sink.add(true);

    await _fileSearchService.searchFiles(_request)
      .then((fileSearchResults) => {
        _subject.sink.add(fileSearchResults),
        _isSearchingSubject.sink.add(false)
      })
      .catchError((error) => {
        _isSearchingSubject.sink.add(false)
      });
  }
}
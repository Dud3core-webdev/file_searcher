import 'dart:io';

import 'package:file_finder/models/file_search_request.dart';
import 'package:file_finder/models/file_search_result.dart';

class FileSearchService {

  Future<List<FileSearchResult>> searchFiles(FileSearchRequest fileSearchRequest) async {
    final Directory directory = Directory(fileSearchRequest.basePath);
    final List<FileSearchResult> result = [];

    if(await directory.exists()) {

      List<String> testData = ['.ts'];
      final allFiles = directory.listSync(recursive: true, followLinks: true);

      for (var file in allFiles) {
        try {
          var fileExtension = file.path.substring(file.path.lastIndexOf('.'));
          var fileShouldBeIncluded = testData.contains(fileExtension);

          if(fileShouldBeIncluded) {
            var parsedFileName = file.path.substring(file.path.lastIndexOf('\\'));
            var searchFoundInFileName = parsedFileName.contains(fileSearchRequest.searchTerm);

            if (searchFoundInFileName) {
              var searchResult = FileSearchResult();
              searchResult.filePath = file.path;
              searchResult.matchType = 'File Name';
              searchResult.fileName = file.path.substring(file.path.lastIndexOf('\\'));

              result.add(searchResult);
            }

            if(await _fileContainsSearchQuery(fileSearchRequest.searchTerm, file)) {
              var searchResult = FileSearchResult();
              searchResult.filePath = file.path;
              searchResult.matchType = 'File';
              searchResult.fileName = file.path.substring(file.path.lastIndexOf('\\'));

              result.add(searchResult);
            }
          }
        } on RangeError catch (_, rangeError) {
          continue;
        }
      }
    }

    for (var value in result) {
      print(value.fileName);
      print(value.matchType);
    }

    return result;
  }

  Future<bool> _fileContainsSearchQuery(String searchQuery, FileSystemEntity file) async {
    String parsedFile = await File(file.path).readAsString();

    if(searchQuery == '') {
      return false;
    }

    return parsedFile.contains(searchQuery);
  }

}
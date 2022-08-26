import 'dart:io';

import 'package:file_finder/models/file_search_request.dart';
import 'package:file_finder/models/file_search_result.dart';

class FileSearchService {

  Future<List<FileSearchResult>> searchFiles(FileSearchRequest fileSearchRequest) async {
    Stopwatch stopwatch = Stopwatch()..start();

    final Directory directory = Directory(fileSearchRequest.basePath);
    final List<FileSearchResult> result = [];

    if(await directory.exists()) {

      final allFiles = await directory
        .list(recursive: true, followLinks: true)
        .toList();

      for (var file in allFiles) {
        try {
          var fileExtension = file.path.substring(file.path.lastIndexOf('.'));
          var fileShouldBeIncluded = fileSearchRequest.fileExtensions.contains(fileExtension);
          var directoryShouldBeIncluded = _shouldDirectoryBeIncluded(file.path, fileSearchRequest.subDirectoriesToIgnore);

          if(!directoryShouldBeIncluded) {
            continue;
          }

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

    stopwatch.stop();
    print('Search took ${stopwatch.elapsed}');

    return result;
  }

  Future<bool> _fileContainsSearchQuery(String searchQuery, FileSystemEntity file) async {
    String parsedFile = await File(file.path).readAsString();

    if(searchQuery == '') {
      return false;
    }

    return parsedFile.contains(searchQuery);
  }

  bool _shouldDirectoryBeIncluded(String path, List<String> excludedSubDirectories) {
    bool result = true;

    for (var directory in excludedSubDirectories) {
      if(path.contains(directory)) {
        result = false;
      }
    }

    return result;
  }
}
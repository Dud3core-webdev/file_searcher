import 'dart:io';

import 'package:file_finder/models/file_search_request.dart';
import 'package:file_finder/models/file_search_result.dart';

class FileSearchService {

  Future<List<FileSearchResult>> searchFiles(FileSearchRequest fileSearchRequest) async {
    final Directory directory = Directory(fileSearchRequest.basePath);
    final List<FileSearchResult> result = [];

    if(await directory.exists()) {

      List<String> testData = ['.cs'];
      final allFiles = directory.listSync(recursive: true, followLinks: true);

      for (var file in allFiles) {
        try {
          var fileExtension = file.path.substring(file.path.lastIndexOf('.'));
          var fileShouldBeIncluded = testData.contains(fileExtension);

          if(fileShouldBeIncluded) {
            var flattenedFileName = file.path.substring(file.path.lastIndexOf('\\'));
            var searchFoundInFileName = flattenedFileName.contains(fileSearchRequest.searchTerm);

            if (searchFoundInFileName) {
              var searchResult = FileSearchResult();
              searchResult.filePath = file.path;
              searchResult.matchType = 'File Name';

              result.add(searchResult);
            }


          }
        } on RangeError catch (_, rangeError) {
          continue;
        }
      }
    }
    
    result.forEach((element) {print(element.filePath); });
    
    return result;
  }



}
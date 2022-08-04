class FileSearchRequest {

  String basePath = '';
  String searchTerm = '';
  List<String> _fileExtensions = [];

  List<String> get fileExtensions {
    return _fileExtensions;
  }

  void addFileExtension(String fileExtension) {
    if(fileExistsInRequest(fileExtension)) {
      return;
    }

    _fileExtensions.add(fileExtension);
  }

  void removeFileExtension(String fileExtension) {
    _fileExtensions.remove(fileExtension);
  }

  bool fileExistsInRequest(String fileExtension) {
    return _fileExtensions.contains(fileExtension);
  }

  void resetFileExtensions() {
    _fileExtensions = [];
  }

  void resetSearchTerm() {
    searchTerm = "";
  }

  void resetBasePath() {
    basePath = "";
  }

  void resetAllSearchParameters() {
    resetFileExtensions();
    resetBasePath();
    resetSearchTerm();
  }
}
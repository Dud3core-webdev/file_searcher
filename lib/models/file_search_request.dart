class FileSearchRequest {

  String basePath = '';
  String searchTerm = '';
  final List<String> _fileExtensions = [];

  List<String> get fileExtensions {
    return _fileExtensions;
  }

  void addFileExtension(String fileExtension) {
    _fileExtensions.add(fileExtension);
  }

  void removeFileExtension(String fileExtension) {
    _fileExtensions.remove(fileExtension);
  }
}
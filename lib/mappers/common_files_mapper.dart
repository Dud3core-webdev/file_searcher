import 'package:flutter/material.dart';

import '../constants/common_file_types.dart';

class CommonFileMapper {

  static List<DropdownMenuItem<String>> getDropdownMenuItems() {
    final List<DropdownMenuItem<String>> mappedList = <DropdownMenuItem<String>>[];

    for (var file in commonFileTypes) {
      mappedList.add(DropdownMenuItem(
        value: file.extension,
        enabled: true,
        child: Text(file.type)
      ));
    }

    return mappedList;
  }
}
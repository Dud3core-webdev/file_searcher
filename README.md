# Flutter File Finder

#### Windows (More OS Support to be added)

### What is? 

As a developer, I spend so much time looking through files using an IDE's search feature. These are great
but what if I need to search through different projects for something? These projects can often be in different languages and 
frameworks that often require different IDEs... That's a nope from me. 

### Flutter File Finder Solves this issue. 

So far, it only allows you to look through the following files: 
- C# (C Sharp) .cs
- TypeScript .ts
- SASS .scss

Simply because these are the file types I look through the most, feel free to add whatever file type you want though. 

I will eventually be replacing this with a drop-down list that will incrementally add the file types you want to search against, but this is fine for now. 

### How does it work? 

- It uses [file_picker: ^4.6.1](https://pub.dev/packages/file_picker) to select a path (unless you manually enter the path you want to search against)
- It iterates through the file system recursively, 
  - if the file extension matches, check against the query
    - parse the file for the search query


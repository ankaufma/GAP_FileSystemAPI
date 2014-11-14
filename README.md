GAP_FileSystemAPI
=================

An API to use Cordova's File-Plugin with native Dart Code
```
import 'dart:html';
import 'lib/src/gap_fs.dart' as fsApi;

void main() {
  
  final TEMP = "Temp";
  final DOC = "HelloWorld.txt";
  final DOCCONTENT = "Hello World,\n";
  final DOCCONTENT2 = "I'm doing fine so far...";
  
  // Asynchronous calls, first create in Temp folder, then write, 
  // then append, then read and print it in HTML View, then remove the hole directory
  fsApi.GapFileSystemAPI.createFileIn(TEMP, DOC).then((myBoolean) =>
      fsApi.GapFileSystemAPI.writeFileTo(TEMP, DOC, DOCCONTENT)).then((myBoolean) =>
          fsApi.GapFileSystemAPI.appendToFileIn(TEMP, DOC, DOCCONTENT2).then((myBoolean) =>
              fsApi.GapFileSystemAPI.readFileFrom(TEMP, DOC).then((myContent) { 
                querySelector("#sample_text_id1").text = myContent;
                // !!! WARNING !!! THE DIRECTORY WITH ALL ITS CONTENTS WILL BE REMOVED !!!
                fsApi.GapFileSystemAPI.removeDirectoryRecursively(TEMP);
  })));

  // Asynchronous calls, first create in Root directory, then write,
  // then append, then read and print it in HTML View, then remove it  
  fsApi.GapFileSystemAPI.createFile(DOC).then((myBoolean) =>
      fsApi.GapFileSystemAPI.writeFile(DOC, DOCCONTENT2)).then((myBoolean) =>
          fsApi.GapFileSystemAPI.appendToFile(DOC, DOCCONTENT).then((myBoolean) =>
              fsApi.GapFileSystemAPI.readFile(DOC).then((myContent) {
                querySelector("#sample_text_id2").text = myContent;
                fsApi.GapFileSystemAPI.removeFileIn("", DOC); // "" is Root
  })));
  
}
```

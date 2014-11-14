part of gap_fs;

class GapFileSystemAPI {
  static final _CNNE = new JsObject.jsify({'create': true, 'exclusive': false});
  static final _CNE = new JsObject.jsify({'create': true, 'exclusive': true});
  static final _NCREATE = new JsObject.jsify({'create': false});
  static final _PERSISTENT = context['PERSISTENT'];
  static final _ROOT = "";
  
  _GapFileSystemAPI() {}
  
  static Future<bool> createDirectory(String _dirName) {
    Completer cmpl = new Completer();
    bool done=false;
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
        ((JsObject fs) {
          fs['root'].callMethod('getDirectory', [_ROOT,_CNNE,_fail]);
          cmpl.complete(done=true); 
        }),_fail]))
    .catchError((err,st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> createFile(String _fileName) {
    Completer cmpl = new Completer();
    bool done=false;
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
        ((JsObject fs) =>
          fs['root'].callMethod('getDirectory', [_ROOT,_CNNE,
        ((JsObject dir) {
          dir.callMethod('getFile', [_fileName,_CNNE]);
          cmpl.complete(done=true);              
    }),_fail])),_fail])).catchError((err,st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> createFileIn(String _dirName, String _fileName) {
    Completer cmpl = new Completer();
    bool done;
    Device.init().then((device) {
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
        ((JsObject fs) {
          fs['root'].callMethod('getDirectory', [_dirName,_CNNE,
        ((JsObject dir) { 
          dir.callMethod('getFile', [_fileName,_CNNE]);
          cmpl.complete(done=true);              
    }),_fail]);}),_fail]);}).catchError((err, st) =>  _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<String> readFile(String _fileName) {
    String myString = "";
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_ROOT,_NCREATE,
          ((JsObject dir) =>
            dir.callMethod('getFile', [_fileName,_NCREATE,
          ((JsObject fileEntry) =>
            fileEntry.callMethod('file', [
          ((JsObject file) {
            var fileReader = new JsObject(context['FileReader']);
            fileReader['onloadend'] = ((JsObject evt) => cmpl.complete(myString+=fileReader['result']));
            fileReader.callMethod('readAsText',[file]);
          }),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<String> readFileFrom(String _dirName, String _fileName) {
    String myString = "";
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_dirName,_NCREATE,
          ((JsObject dir) => 
            dir.callMethod('getFile', [_fileName,_NCREATE,
          ((JsObject fileEntry) => 
            fileEntry.callMethod('file', [
          ((JsObject file) {
            var fileReader = new JsObject(context['FileReader']);
            fileReader['onloadend'] = ((JsObject evt) { cmpl.complete(myString+=fileReader['result']); });
            fileReader.callMethod('readAsText',[file]);
          }),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }

  static Future<bool> writeFile(String _fileName, String _content) {
    bool done = false;
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_ROOT,_CNNE,
          ((JsObject dir) => 
            dir.callMethod('getFile', [_fileName,_CNNE,
          ((JsObject fileEntry) => 
            fileEntry.callMethod('createWriter', [
          ((JsObject writer) {
            writer['onwriteend'] = ((JsObject evt) => cmpl.complete(done=true));
            writer.callMethod('write',[_content]);
          }),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> writeFileTo(String _dirName, String _fileName, String _content) {
    bool done = false;
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_dirName,_CNNE,
          ((JsObject dir) => 
            dir.callMethod('getFile', [_fileName,_CNNE,
          ((JsObject fileEntry) => 
            fileEntry.callMethod('createWriter', [
          ((JsObject writer) {
            writer['onwriteend'] = ((JsObject evt) => cmpl.complete(done=true));
            writer.callMethod('write',[_content]);
          }),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> appendToFile(String _fileName, String _content) {
    bool done = false;
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_ROOT,_CNNE,
          ((JsObject dir) => 
            dir.callMethod('getFile', [_fileName,_CNNE,
          ((JsObject fileEntry) => 
            fileEntry.callMethod('createWriter', [
          ((JsObject writer) {
            writer['onwriteend'] = ((JsObject evt) => cmpl.complete(done=true));
            writer.callMethod('seek',[writer['length']]);
            writer.callMethod('write',[_content]);
          }),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> appendToFileIn(String _dirName, String _fileName, String _content) {
    bool done = false;
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_dirName,_CNNE,
          ((JsObject dir) => 
            dir.callMethod('getFile', [_fileName,_CNNE,
          ((JsObject fileEntry) => 
            fileEntry.callMethod('createWriter', [
          ((JsObject writer) {
            writer['onwriteend'] = ((JsObject evt) => cmpl.complete(done=true));
            writer.callMethod('seek',[writer['length']]);
            writer.callMethod('write',[_content]);
          }),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> removeFileIn(String _dirName, String _fileName) {
    bool done = false;
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_dirName,_CNNE,
          ((JsObject dir) => 
            dir.callMethod('getFile', [_fileName,_CNNE,
          ((JsObject fileEntry) => 
            fileEntry.callMethod('remove',[
          ((JsObject file) =>
             cmpl.complete(done=true)
          ),_fail])),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static Future<bool> removeDirectoryRecursively(String _dirName) {
    bool done = false;
    Completer cmpl = new Completer();
    Device.init().then((device) => 
        context.callMethod('requestFileSystem',[_PERSISTENT,0,
          ((JsObject fs) =>
            fs['root'].callMethod('getDirectory', [_dirName,_CNNE,
          ((JsObject dir) => 
            dir.callMethod('removeRecursively',[
          ((JsObject fileEntry) => 
            cmpl.complete(done=true)
          ),_fail])),_fail])),_fail])
    ).catchError((err, st) => _deviceError(err, st));
    return cmpl.future;
  }
  
  static _deviceError(err,st) {
    // Handle Device Errors here...
    print("AN ERROR OCCURED:" +err);
    print("THAT'S THE STACK:" + st);
  }
  
  static _fail(err) {
    // Handle Cordova Fails here...
    print("AN ERROR OCCURED:" +err);
  }

}
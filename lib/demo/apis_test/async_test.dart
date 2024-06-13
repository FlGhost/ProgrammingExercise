//import async
import 'dart:async';

//all functions declared runs on main ui thread
//to prevent long operations blocking main thread
//use apis : (future, then) or (async,await)
main() {
  //starts -> end -> after 6 secs -> result str
  print('main prog starts');
  printFileContent();
  printFileContent2();
  print('main prog ends');
}

//async
printFileContent() async {
  //after downloading file, print file content
  //does not immediately return str value
  //await for a valid result -> can remove type future
  String file = await downloadFile();
  print('content of file /async --> $file');
  //to get result, needs to use await + async
}

//then
printFileContent2() {
  Future<String> file = downloadFile();
  //need to make sure to print str not future obj
  //wrap this obj
  //only print if u have valid str result
  file.then((res) {
    print('content of file /then --> $res');
  });
}

//dummy long running operation
//take 6 sec to return str
Future<String> downloadFile() {
  Future<String> res = Future.delayed(const Duration(seconds: 6), () {
    return 'dummy file download';
  });
  return res;
}

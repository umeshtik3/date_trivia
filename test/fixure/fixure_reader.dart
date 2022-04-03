import 'dart:io';

String fixure(String name) => File('test/fixure/$name').readAsStringSync();

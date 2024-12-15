import 'package:flutter/material.dart';

void printY(String text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}

void printR(String text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

void printG(String text) {
  debugPrint('\x1B[32m$text\x1B[0m');
}

void printM(String text) {
  debugPrint('\x1B[35m$text\x1B[0m');
}

void printC(String text) {
  debugPrint('\x1B[36m$text\x1B[0m');
}

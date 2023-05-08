import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppWebViewController? inAppWebViewController;
String Url = "";
String SelectedOption = "Option 1";
List<String> BookMark = [];
String urlBookmark = "";

PullToRefreshController? pullToRefreshController;


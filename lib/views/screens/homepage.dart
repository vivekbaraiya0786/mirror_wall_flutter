import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controllers/providers/connectivity_provider.dart';
import 'package:mirror_wall/utils/attributes.dart';
import 'package:provider/provider.dart';
import '../../controllers/providers/linear_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController SearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvier>(context, listen: false)
        .checkInternetConnectvity();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(),
      onRefresh: () async {
        await inAppWebViewController?.reload();
      },
    );
  }

  void showAlertDialog(String selectedOption) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Search Engine"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  fillColor: MaterialStateProperty.all(
                    Colors.purple,
                  ),
                  title: const Text("Google"),
                  value: "https://www.google.com/",
                  groupValue: Url,
                  onChanged: (value) {
                    setState(() {
                      Url = value!;
                    });
                    inAppWebViewController!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(Url),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  fillColor: MaterialStateProperty.all(
                    Colors.purple,
                  ),
                  title: const Text("Yahoo"),
                  value: "https://www.yahoo.com/",
                  groupValue: Url,
                  onChanged: (value) {
                    setState(() {
                      Url = value!;
                    });
                    inAppWebViewController!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(Url),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  fillColor: MaterialStateProperty.all(
                    Colors.purple,
                  ),
                  title: const Text("Bing"),
                  value: "https://www.bing.com/",
                  groupValue: Url,
                  onChanged: (value) {
                    setState(() {
                      Url = value!;
                    });
                    inAppWebViewController!
                        .loadUrl(urlRequest: URLRequest(url: Uri.parse(Url)));
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  fillColor: MaterialStateProperty.all(
                    Colors.purple,
                  ),
                  title: const Text("Duck Duck Go"),
                  value: "https://duckduckgo.com/",
                  groupValue: Url,
                  onChanged: (value) {
                    setState(() {
                      Url = value!;
                    });
                    inAppWebViewController!
                        .loadUrl(urlRequest: URLRequest(url: Uri.parse(Url)));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void bookmarklist(String selectedOption) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: const Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Dismiss",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: ListView.builder(
                      itemCount: BookMark.length,
                      itemBuilder: (context, i) => ListTile(
                        title: Text("${Name[i]}"),
                        subtitle: Text("${BookMark[i]}"),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                BookMark.remove(BookMark[i]);
                                Name.remove(Name[i]);
                                // Navigator.of(context).pop();
                              });
                            },
                            icon: const Icon(Icons.delete)),
                        onTap:(){
                          inAppWebViewController?.loadUrl(
                              urlRequest: URLRequest(
                                  url:
                                  BookMark[i]));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("No Connection"),
        content: const Text("Please check your internet connectivity"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Browser',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            PopupMenuButton(
              offset: const Offset(10, 60),
              shape: const OutlineInputBorder(),
              icon: const Icon(Icons.more_vert, color: Colors.black),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "Option 1",
                  child: Row(
                    children: [
                      const Icon(Icons.bookmark_add_outlined,
                          color: Colors.black),
                      SizedBox(
                        width: w * 0.04,
                      ),
                      const Text("All BookMark"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "Option 2",
                  child: Row(
                    children: [
                      const Icon(Icons.laptop, color: Colors.black),
                      SizedBox(
                        width: w * 0.04,
                      ),
                      const Text("Search Engine"),
                    ],
                  ),
                ),
              ],
              onSelected: (selectedOption) {
                setState(() {
                  SelectedOption = selectedOption;
                });
                if (selectedOption == "Option 1") {
                  bookmarklist(selectedOption);
                } else if (selectedOption == "Option 2") {
                  showAlertDialog(selectedOption);
                }
              },
            ),
          ],
        ),
        body: (Provider.of<ConnectivityProvier>(context)
                    .connectivityModel
                    .ConnectivityStatus ==
                "Waiting..")
            ? const Center(
                child: Text(
                  "Please check your internet connection",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(
                height: h * 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.74,
                        child: InAppWebView(
                          onProgressChanged: (controller, progess) {
                            liner = progess.toDouble() / 100;
                            if (progess == 100) {
                              pullToRefreshController?.endRefreshing();
                            }
                          },
                          pullToRefreshController: pullToRefreshController,
                          onWebViewCreated: (controller) {
                            inAppWebViewController = controller;
                          },
                          onLoadStart: (controller, url) {
                            setState(() {
                              inAppWebViewController = controller;
                              urlBookmark = url.toString();
                            });
                          },
                          onLoadStop: (controller, url) async {
                            await pullToRefreshController?.endRefreshing();
                          },
                          initialUrlRequest: URLRequest(
                              url: (Url.isEmpty)
                                  ? Uri.parse("https://www.google.com/")
                                  : Uri.parse(Url)),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.15,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: SearchController,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        String newLink = SearchController.text;
                                        inAppWebViewController?.loadUrl(
                                          urlRequest: URLRequest(
                                            url: (Url.isEmpty)
                                                ? Uri.parse(
                                                    "https://www.google.com/search?q=$newLink")
                                                : Uri.parse(
                                                    "${Url}search?q=$newLink"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              (Provider.of<LinerProvider>(context).l1.liner <
                                  1.0)
                                  ? Transform.scale(
                                scale: 1.5,
                                child: LinearProgressIndicator(
                                  color: Color(0xff6054c1),
                                  backgroundColor: Colors.indigo.shade100,
                                  value: Provider.of<LinerProvider>(context)
                                      .l1
                                      .liner,
                                ),
                              )
                                  : Container(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(Url),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.home, size: 35),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      // BookMark.add(urlBookmark);
                                      BookMark.add(await inAppWebViewController
                                          ?.getUrl());
                                      Name.add(await inAppWebViewController
                                          ?.getTitle());
                                    },
                                    icon: const Icon(
                                      Icons.bookmark_add_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (await inAppWebViewController!
                                          .canGoBack()) {
                                        await inAppWebViewController?.goBack();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_left_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await inAppWebViewController?.reload();
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (await inAppWebViewController!
                                          .canGoForward()) {
                                        await inAppWebViewController
                                            ?.goForward();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

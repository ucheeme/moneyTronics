import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/appUtil.dart';





class WebViewScreen extends StatefulWidget {
  final String url;
  final String callBackUrl;
  const WebViewScreen(this.url, this.callBackUrl,{Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var  controller = WebViewController();
  _initWebViewController(){
     controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("progress $progress");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            AppUtils.debug("nurl: ${request.url}");
            AppUtils.debug("nurl: ${widget.callBackUrl}");
            if (request.url.startsWith(widget.callBackUrl)) {

              Navigator.pop(context, true);
               return NavigationDecision.prevent;
            }else {
              return NavigationDecision.navigate;
            }
            },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void initState() {
    _initWebViewController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BVN Verification")),
      body: WebViewWidget(controller: controller),
    );
  }
}
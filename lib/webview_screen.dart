import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late var url;
  var initiaUrl = "https://www.google.com/";
  double progres = 0;
  var urlController = TextEditingController();
  var isloading = false;

  @override
  void initState() {
    super.initState();
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload();
      },
      options: PullToRefreshOptions(color: Colors.white, backgroundColor: Colors.black87)
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              ),
              backgroundColor: Colors.grey[50],
              // gimana cara supaya ada round edge di kanan pada drawer
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildHeader(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () async =>{
                        if(await webViewController!.canGoBack()) {
                          webViewController!.goBack()
                        }
                      }, icon: const Icon(Icons.arrow_back_rounded)),

                      IconButton(onPressed: () async =>{
                        if(await webViewController!.canGoForward()) {
                          webViewController!.goForward()
                        }
                      }, icon: const Icon(Icons.arrow_forward_rounded)),
                      IconButton(onPressed: ()=>{webViewController!.reload()}, icon: const Icon(Icons.refresh_rounded)),
                    
                    ],
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  
                  ListTile(
                    leading: const Icon(Icons.home_rounded),
                    title: const Text("Home"),
                    minLeadingWidth: 5,
                    onTap: () async{
                      url = Uri.parse("https://www.google.com/");
                      webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.announcement_rounded),
                    title: const Text("Pengumuman"),
                    minLeadingWidth: 5,
                    onTap: () async{
                      url = Uri.parse("string link");
                      webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.app_registration_rounded),
                    title: const Text("Kegiatan Harian"),
                    minLeadingWidth: 5,
                    onTap: () async{
                      url = Uri.parse("string link");
                      webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.analytics_rounded),
                    title: const Text("Jejak Kegiatan"),
                    minLeadingWidth: 5,
                    onTap: () async{
                      url = Uri.parse("string link");
                      webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: const Text("Scan URL"),
                    minLeadingWidth: 5,
                    onTap: () async{
                      url = Uri.parse("https://example.com");
                      webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Pengaturan"),
                    minLeadingWidth: 5,
                    onTap: () async{
                      url = Uri.parse("https://example.com");
                      webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                    },
                  ),

                    
                   // IconButton(
                      
                      //onPressed: () async {
                      //url = Uri.parse("https://example.com");
                      //webViewController!.loadUrl(urlRequest: URLRequest(url: url));
                  //  }, icon: const Icon(Icons.settings)),
                                   
                ],
              ),
            ),
            
      appBar: AppBar(

      //  leading: IconButton(


        //  onPressed: () async {
        //    url = Uri.parse("https://example.com");
        //    webViewController!.loadUrl(urlRequest: URLRequest(url: url));
        //  }, icon: const Icon(Icons.arrow_back_ios)),


      //  onPressed: () async {
      //      if(await webViewController!.canGoBack()) {
      //        webViewController!.goBack();
      //      } 
      //    }, icon: const Icon(Icons.arrow_back_ios)),

        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),

        child: TextField(
          onSubmitted: (value) {
            url = Uri.parse(value);
            if (url.scheme.isEmpty) {
              url = Uri.parse("${initiaUrl}search?q=$value");
            }
            webViewController!.loadUrl(urlRequest: URLRequest(url: url));
          },
          controller: urlController,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            hintText: "Masukan Alamat",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        ),

        actions: [
          IconButton(onPressed: () {
            webViewController!.reload();
          }, icon: const Icon(Icons.refresh))
        ],
      ),




      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                InAppWebView(
                  onLoadStart: (controller,url ) {
                    var v = url.toString();
                    setState(() {
                      isloading = true;
                      urlController.text = v;
                    });
                  },
                  onLoadStop: (controller, url) {
                    refreshController!.endRefreshing();
                    setState(() {
                      isloading = false;
                    });
                  },
                  pullToRefreshController: refreshController,
                  onWebViewCreated: (controller) => webViewController = controller,
                  initialUrlRequest: URLRequest(url : Uri.parse(initiaUrl)),
                ),
                Visibility(
                  visible: isloading,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.amber[900]),
                )),
              ],
            ))
        ],   
      ),

    );
  }

  _buildHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/pictures/person1.jpeg"),
            radius: 50,
          ),
          SizedBox(height: 10,),
          Text(
            "Nama Pengguna",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15
            ),
          )
        ],
      ),
    );
  }

  //_buildItem({required IconData icon, required String title, required GestureCancelCallback onTap}) {
  //  return ListTile(
  //    leading: Icon(icon),
  //   title: Text(title),
      //ubah yang on tap jadi () {} tapi gtw carannya
  //  onTap: onTap,
  //  minLeadingWidth: 5,
  //);
  //}

}
 
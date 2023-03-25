import 'package:flutter/material.dart';
import 'package:kuiz_123190146/data/disease_data.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Diseases disease;

  DetailPage({required this.disease});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isWishlisted = false;

  void toggleWishlist() {
    setState(() {
      isWishlisted = !isWishlisted;
    });

    final snackBar = SnackBar(
      content: Text(
          isWishlisted ? 'Ditambahkan ke wishlist' : 'Dihapus dari wishlist'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disease.name),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: toggleWishlist,
          ),
          IconButton(
            icon: Icon(
              Icons.link,
              color: Colors.white,
            ),
            onPressed: () async {
              final url = widget.disease.imgUrls; // ganti dengan link yang ingin di-launch
              await _launchInWebViewOrVC(
                Uri.parse(url)
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                widget.disease.imgUrls,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                'Tanaman: ${widget.disease.plantName}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Gejala: ${widget.disease.symptom}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Ciri-ciri: ',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.disease.nutshell
                    .map((ciri) => Text('- $ciri'))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kuiz_123190146/data/disease_data.dart';
import 'package:kuiz_123190146/detail_page.dart';
class HomeScreen extends StatelessWidget {
  final List<Diseases> listDisease;

  HomeScreen({required this.listDisease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease List'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: listDisease.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (BuildContext context, int index) {
          Diseases disease = listDisease[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(disease: disease),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      disease.imgUrls,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      disease.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      disease.plantName,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

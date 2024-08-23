import 'package:flutter/material.dart';

class SpecificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return index % 2 == 0
            ? _buildListItem(dataList[index])
            : _buildListItemReversed(dataList[index]);
      },
    );
  }

  Widget _buildListItem(DataModel data) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        // leading: FractionallySizedBox(
        //   widthFactor: 0.3,
        //   child: Image.network(
        //     data.imageUrl,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        title: Text(data.title),
        subtitle: Text(data.description),
        onTap: () {},
      ),
    );
  }

  Widget _buildListItemReversed(DataModel data) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        // trailing: FractionallySizedBox(
        //   widthFactor: 0.3,
        //   child: Image.network(
        //     data.imageUrl,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        title: Text(data.title),
        subtitle: Text(data.description),
        onTap: () {},
      ),
    );
  }
}

class DataModel {
  final String imageUrl;
  final String title;
  final String description;

  DataModel(
      {required this.imageUrl, required this.title, required this.description});
}

final List<DataModel> dataList = [
  DataModel(
    imageUrl: 'https://i.dummyjson.com/data/products/1/1.jpg',
    title: 'Item 1',
    description: 'Description for Item 1',
  ),
  DataModel(
    imageUrl: 'https://i.dummyjson.com/data/products/1/2.jpg',
    title: 'Item 2',
    description: 'Description for Item 2',
  ),
  DataModel(
    imageUrl: 'https://i.dummyjson.com/data/products/1/3.jpg',
    title: 'Item 3',
    description: 'Description for Item 3',
  ),
  DataModel(
    imageUrl: 'https://i.dummyjson.com/data/products/1/4.jpg',
    title: 'Item 4',
    description: 'Description for Item 4',
  ),
  // Add more items as needed
];

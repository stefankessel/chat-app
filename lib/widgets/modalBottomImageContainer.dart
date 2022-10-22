import 'package:flutter/material.dart';

import 'package:linkedin/repo/image_repository.dart';
import '../model/ImageEntity.dart';

class ModalBottomImageContainer extends StatelessWidget {
  ModalBottomImageContainer({Key? key, required this.onImageSelected})
      : super(key: key);

  final ImageRepository _imageRepository = ImageRepository();
  final Function(String) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imageRepository.getNetworkImages(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ImageEntity>> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                mainAxisSpacing: 2,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      onImageSelected(snapshot.data![index].urlSmallSize);
                    },
                    child: Image.network(snapshot.data![index].urlSmallSize));
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

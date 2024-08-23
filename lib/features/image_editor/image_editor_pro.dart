// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jai_poc/features/image_editor/imag_editor.dart';
//
// class ImageEditorPro extends StatefulWidget {
//   const ImageEditorPro({super.key});
//
//   @override
//   State<ImageEditorPro> createState() => _ImageEditorState();
// }
//
// class _ImageEditorState extends State<ImageEditorPro> {
//   late File _image;
//   final picker = ImagePicker();
//
//   Future getImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() async {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//
//         var editedImage = await Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) => ImageEditorJai(
//               image: File(pickedFile.path),
//               rotateOption: null,
//               cropOption: null,
//               blurOption: null,
//               brushOption: null,
//               filtersOption: null,
//               flipOption: null,
//             ),
//           ),
//         );
//
//         if (editedImage != null) {
//           final result = await ImageGallerySaver.saveImage(editedImage);
//           print(result);
//         }
//       }
//     });
//   }
//
//   Future getImageFromCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     setState(() async {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         var editedImage = await Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) => ImageEditorJai(
//               image: File(pickedFile.path),
//               rotateOption: null,
//               cropOption: null,
//               blurOption: null,
//               brushOption: null,
//               filtersOption: null,
//               flipOption: null,
//             ),
//           ),
//         );
//
//         if (editedImage != null) {
//           final result = await ImageGallerySaver.saveImage(editedImage);
//           print(result);
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Image Picker"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Gallery",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     getImageFromGallery();
//                   }),
//               MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Camera",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     getImageFromCamera();
//                   }),
//             ],
//           ),
//         ));
//   }
// }

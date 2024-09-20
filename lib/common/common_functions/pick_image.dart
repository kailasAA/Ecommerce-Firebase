import 'package:image_picker/image_picker.dart';

// Future<XFile?> pickImage() async {
//   final imagePicker = ImagePicker();
//   final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//   return pickedFile;
// }

Future<List<XFile?>> pickMultipleImage() async {
  final imagePicker = ImagePicker();
  final List<XFile> images = await imagePicker.pickMultiImage();
  return images;
}

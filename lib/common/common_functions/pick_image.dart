import 'package:image_picker/image_picker.dart';


Future<List<XFile?>> pickMultipleImage() async {
  final imagePicker = ImagePicker();
  final List<XFile> images = await imagePicker.pickMultiImage();
  return images;
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/blocs/createPost/crete_post_bloc.dart';
import 'package:projects/similiar/appcolors.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  final ImagePicker _picker = ImagePicker();
  TextEditingController titleControl_ = TextEditingController();
  TextEditingController addressControl_ = TextEditingController();
  TextEditingController priceControl_ = TextEditingController();
  TextEditingController provinceControl_ = TextEditingController();
  String photoMes = "Add a photo";
  XFile? images;
  @override
  void dispose(){
    super.dispose();
    titleControl_.dispose();
    addressControl_.dispose();
    priceControl_.dispose();
    provinceControl_.dispose();
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        photoMes = "photo added";
        images = image;
      });
      print('Image selected: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          InkWell(
            onTap: (){
              context.read<CretePostBloc>().add(CreatePost(
                  image: images!,
                  title: titleControl_.text.trim(),
                  province: provinceControl_.text.trim(),
                  address: addressControl_.text.trim(),
                  price: priceControl_.text.trim()
              ));
              Navigator.pushNamed(context, '/startpage');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Center(child: Text('Post', style: TextStyle(color: Colors.white),)),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red
              ),
              child: DropdownMenu(
                controller: provinceControl_,
                  textStyle: TextStyle(color: Colors.white),
                  initialSelection: Text("all"),
                  label: Text("province", style: TextStyle(color: Colors.white),),
                  dropdownMenuEntries: <DropdownMenuEntry<Color>>[
                    DropdownMenuEntry(value: Colors.white, label: "province1"),
                    DropdownMenuEntry(value: Colors.white, label: "province2"),
                    DropdownMenuEntry(value: Colors.white, label: "province3"),
                    DropdownMenuEntry(value: Colors.white, label: "province4"),
                    DropdownMenuEntry(value: Colors.white, label: "all"),
                  ]),
            ),
            TextField(
              controller: titleControl_,
              style: TextStyle(color: Colors.white, fontSize: 60),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white, fontSize: 60)
              ),
            ),
            InkWell(
              onTap: pickImageFromGallery,
              child: Text(photoMes, style: TextStyle(color: Colors.white, fontSize: 60)),
            ),
            TextField(
              controller: addressControl_,
              style: TextStyle(color: Colors.white, fontSize: 60),
              decoration: InputDecoration(
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 60)
              ),
            ),
            TextField(
              controller: priceControl_,
              style: TextStyle(color: Colors.white, fontSize: 60),
              decoration: InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 60)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

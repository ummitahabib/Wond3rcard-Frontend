import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wond3rcard/src/cards/data/controller/create_card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/create_card/create_card_model.dart';

// class CreateCardScreen extends ConsumerStatefulWidget {
//   @override
//   _CreateCardScreenState createState() => _CreateCardScreenState();
// }

// class _CreateCardScreenState extends ConsumerState<CreateCardScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _websiteController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   File? _cardPhoto;
//   Uint8List? _webImage;

//   @override
//   Widget build(BuildContext context) {
//     final cardController = ref.watch(createCardControllerProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: Text("Create Card")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(controller: _nameController, decoration: InputDecoration(labelText: "Card Name")),
//               TextFormField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
//               TextFormField(controller: _phoneController, decoration: InputDecoration(labelText: "Phone")),
//               TextFormField(controller: _websiteController, decoration: InputDecoration(labelText: "Website")),
//               TextFormField(controller: _addressController, decoration: InputDecoration(labelText: "Address")),

//               ElevatedButton(
//                 onPressed: () async {
//                   if (kIsWeb) {
//                     _webImage = await cardController.pickWebImage();
//                   } else {
//                     _cardPhoto = await cardController.pickImage(ImageSource.gallery);
//                   }
//                   setState(() {});
//                 },
//                 child: Text(_cardPhoto != null || _webImage != null ? "Image Selected" : "Pick Image"),
//               ),

//               if (_cardPhoto != null) Image.file(_cardPhoto!, height: 100),
//               if (_webImage != null) Image.memory(_webImage!, height: 100),

//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final card = CreateCardModel(
//                       cardType: "personal",
//                       ownerId: "67ae134c1926fbabef30d9a3",
//                       cardName: _nameController.text,
// suffix: "Mss",
// firstName: "Ummeeta",
// lastName: "Habeeb",
//                       email: _emailController.text,
//                       phone: _phoneController.text,
//                       website: _websiteController.text,
//                       address: _addressController.text,
//                       socialMediaLinks: [],
//                       cardPhoto: _cardPhoto,
//                     );

//                     ref.read(createCardControllerProvider.notifier).createCard(card);
//                   }
//                 },
//                 child: Text("Create Card"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wond3rcard/src/cards/data/controller/create_card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/create_card/create_card_model.dart';

class CreateCardScreen extends ConsumerStatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends ConsumerState<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  File? _cardPhoto;
  File? _cardCoverPhoto;
  Uint8List? _webCardPhoto;
  Uint8List? _webCardCoverPhoto;

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(createCardControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("Create Card")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Card Name")),
              ElevatedButton(
                onPressed: () async {
                  if (kIsWeb) {
                    _webCardPhoto = await cardController.pickWebImage();
                  } else {
                    _cardPhoto =
                        await cardController.pickImage(ImageSource.gallery);
                  }
                  setState(() {});
                },
                child: Text("Pick Card Photo"),
              ),
              if (_cardPhoto != null) Image.file(_cardPhoto!, height: 100),
              if (_webCardPhoto != null)
                Image.memory(_webCardPhoto!, height: 100),
              ElevatedButton(
                onPressed: () async {
                  if (kIsWeb) {
                    _webCardCoverPhoto = await cardController.pickWebImage();
                  } else {
                    _cardCoverPhoto =
                        await cardController.pickImage(ImageSource.gallery);
                  }
                  setState(() {});
                },
                child: Text("Pick Cover Photo"),
              ),
              if (_cardCoverPhoto != null)
                Image.file(_cardCoverPhoto!, height: 100),
              if (_webCardCoverPhoto != null)
                Image.memory(_webCardCoverPhoto!, height: 100),
              ElevatedButton(
                onPressed: () {
                  final card = CreateCardModel(
                      cardType: "personal",
                      ownerId: "67ae134c1926fbabef30d9a3",
                      cardName: _nameController.text,
                      email: "test@gmail.com",
                      phone: "+2348912345577",
                      website: "test",
                      address: "Test Address",
                      cardPhoto: _cardPhoto,
                      webCardPhoto: _webCardPhoto,
                      cardCoverPhoto: _cardCoverPhoto,
                      webCardCoverPhoto: _webCardCoverPhoto,
                      suffix: "Mss",
                      firstName: "Ummeeta",
                      lastName: "Habeeb",
                      socialMediaLinks: []);

                  ref
                      .read(createCardControllerProvider.notifier)
                      .createCard(card);
                },
                child: Text("Create Card"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

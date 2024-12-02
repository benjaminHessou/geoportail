import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:device_info_plus/device_info_plus.dart'; 
import 'package:geoportail/views/bienvenu/success_page.dart';
import 'package:geoportail/common/widgets/custom_button.dart';
import 'package:geoportail/common/widgets/custom_input_field.dart';
import 'package:geoportail/features/controller/soumission_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  Position? _currentPosition;
  String? _errorMessage;
  bool isLoading = false;
  bool _acceptTerms = false;
  bool _verificationValue = false; 
   String? _deviceBrand; 
  final GeoportailController _controller = Get.put(GeoportailController()); 

  @override
  void initState() {
    super.initState(); 
    _requestLocationPermission();
    _getDeviceBrand();
  }

   // Fonction pour récupérer la marque du téléphone
  Future<void> _getDeviceBrand() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _deviceBrand = androidInfo.brand; 
    });
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    setState(() {
      _deviceBrand = iosInfo.utsname.machine; 
    });
  }
  print('Device Brand: $_deviceBrand'); 
}

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedForeverDialog();
      return;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _errorMessage = null;
      });
    } catch (e) {
      print("Erreur lors de l'obtention de la localisation : $e");
    }
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Activer la localisation'),
        content: const Text('Veuillez activer les services de localisation dans les paramètres.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission refusée'),
        content: const Text('Veuillez accorder la permission de localisation pour continuer.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission refusée de manière permanente'),
        content: const Text('Veuillez aller dans les paramètres de l\'application pour activer les permissions de localisation.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _resetForm() {
    _nameController.clear();
    _contactController.clear();
    _descriptionController.clear();
    setState(() {
      _image = null;
      _currentPosition = null;
    });
  }

  // Afficher un modal de succès
  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Succès'),
        content: const Text('Données soumises avec succès !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();  
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Center(
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007533),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        CustomInputField(labelText: 'Nom', controller: _nameController),
                        const SizedBox(height: 10),
                        CustomInputField(labelText: 'Contact', controller: _contactController),
                        const SizedBox(height: 10),
                        CustomInputField(labelText: 'Description', controller: _descriptionController,),
                         CheckboxListTile(
                            title: const Text(
                              'En soumettant ce formulaire J\'autorise le MINEF à utiliser mes données personnelles dans le cadre du projet.',
                              style: TextStyle(fontSize: 12),
                            ),
                            value: _acceptTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                _acceptTerms = value ?? false;
                                _verificationValue = _acceptTerms; 
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Color(0xFF007533),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_image != null)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF007533)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 30),
                        CustomButton(
                          buttonText: 'Valider',
                          onPressed: () async {
                            final name = _nameController.text;
                            final contact = _contactController.text;
                            final description = _descriptionController.text;

                            if (_currentPosition != null && _image != null && _verificationValue) {
                              final latitude = _currentPosition?.latitude ?? 0.0;
                              final longitude = _currentPosition?.longitude ?? 0.0;

                              // Envoyer les données à la fonction submitData
                              await _controller.submitData(
                                name,
                                contact,
                                description,
                                _image!,
                                latitude,
                                longitude,
                                _verificationValue ? 1 : 0,
                                _deviceBrand,
                              );
                              Get.to(() => SuccessPage());

                              // Vérifiez la réponse après l'appel
                              if (_controller.successMessage.value.isNotEmpty) {
                              //  Get.to(() => SuccessPage());
                              // _showSuccessModal();
                                _resetForm();
                              }
                            } else {
                              setState(() {
                                _errorMessage = 'La localisation, l\'image, et la vérification sont obligatoires avant de continuer.';
                              });
                            }
                          },
                        ),

                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (_controller.isLoading.value)
                          const SpinKitCircle(
                            color: Color(0xFF007533),
                            size: 50.0,
                          ),
                        const SizedBox(height: 20),
                        Container(
                          width: 70,
                          height: 30,
                          alignment: Alignment.center,
                          child: const Text(
                            'Géoportail',
                            style: TextStyle( 
                              color: Color.fromRGBO(117, 188, 102, 1),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

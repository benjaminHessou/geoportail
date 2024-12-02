import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class GeoportailController extends GetxController {
  static const String apiUrl = 'http://vps107504.serveur-vps.net/projetminef/api/v1/geoportail';


  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  Future<void> submitData(
    String name, 
    String contact, 
    String description, 
    File image, 
    double latitude, 
    double longitude, 
    int verificationValue,
    String? deviceBrand,
    ) async {
    try {
      isLoading.value = true;

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.fields['name'] = name;
      request.fields['contact'] = contact;
      request.fields['description'] = description;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();
      request.fields['autoriserdonnees'] = verificationValue.toString();
      request.fields['telephone'] = deviceBrand!;



      // Ajouter l'image
      var imageBytes = await image.readAsBytes();
      var imageMultipart = http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: image.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(imageMultipart);

      // Envoyer la requête
      var response = await request.send();

      // Vérifier la réponse
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        // Vérifier le statut dans la réponse JSON
        if (jsonResponse['success'] == true && jsonResponse['statutReponse'] == 201) {
          successMessage.value = 'Données envoyées avec succès !';
        } else {
          errorMessage.value = 'Erreur lors de l\'envoi des données: ${jsonResponse['message']}';
        }
      } else {
        errorMessage.value = 'Erreur lors de l\'envoi des données. Code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Erreur : $e';
    } finally {
      isLoading.value = false;
    }
  }
}

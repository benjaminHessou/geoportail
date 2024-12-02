import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;

  // Constructeur pour passer les informations
  const CustomInputField({super.key, required this.labelText, required this.controller});

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    // Déterminer l'icône en fonction du labelText
    IconData? prefixIcon;
    TextInputType inputType = TextInputType.text;

    if (widget.labelText == 'Nom') {
      prefixIcon = Icons.person;
    } else if (widget.labelText == 'Contact') {
      prefixIcon = Icons.phone;
      inputType = TextInputType.phone;
    } else if (widget.labelText == 'Description') {
      prefixIcon = Icons.description;
      inputType = TextInputType.multiline; 
    }

    return Container(
      // Utiliser Container pour contrôler la largeur du champ d'entrée
      width: MediaQuery.of(context).size.width * 0.9, 
      child: TextFormField(
        controller: widget.controller,  // Lier le TextEditingController ici
        keyboardType: inputType,
        maxLines: widget.labelText == 'Description' ? 5 : 1, 
        decoration: InputDecoration(
          labelText: widget.labelText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    prefixIcon,
                    color: Colors.grey,
                  ),
                )
              : null, // Affiche l'icône seulement si elle est définie
        ),
      ),
    );
  }
}

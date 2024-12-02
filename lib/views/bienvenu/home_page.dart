import 'package:flutter/material.dart';
import 'package:geoportail/common/widgets/action_title.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions Agents',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007533),
              ),
            ),
            const SizedBox(height: 20),
            // Liste des actions
            Expanded(
              child: ListView(
                children: [
                  ActionTile(
                    title: 'Site de Reboisement',
                    onTap: () {
                      // Action pour Site de Reboisement
                    },
                  ),
            const SizedBox(height: 20),

                  ActionTile(
                    title: 'Site de Pépinières',
                    onTap: () {
                      // Action pour Site de Pépinières
                    },
                  ),
            const SizedBox(height: 20),

                  ActionTile(
                    title: 'Forêt Communautaire',
                    onTap: () {
                      // Action pour Forêt Communautaire
                    },
                  ),
            const SizedBox(height: 20),

                  ActionTile(
                    title: 'Forêt Privée',
                    onTap: () {
                      // Action pour Forêt Privée
                    },
                  ),
            const SizedBox(height: 20),

                  ActionTile(
                    title: 'Agro Forêt',
                    onTap: () {
                      // Action pour Agro Forêt
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



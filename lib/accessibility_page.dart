import 'package:flutter/material.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  
  bool _isSwitchedMoreResults = true;
  bool _isSwitchedZoomControls = true;
  bool _isSwitchedMapScrolling = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Accesibilidad',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFEAEAEA),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sube más resultados',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Prefiero un botón para subir más que un desplazamiento infinito en lugares con listas largas, como la pestaña Comunicaciones y Anuncios.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Switch(
                            value: _isSwitchedMoreResults,
                            onChanged: (bool value) {
                              setState(() {
                                _isSwitchedMoreResults = value;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'Controles de acercamiento/ alejamiento de un mapa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Acerca o aleja con botones distintos.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Switch(
                            value: _isSwitchedZoomControls,
                            onChanged: (bool value) {
                              setState(() {
                                _isSwitchedZoomControls = value;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'Controles de desplazamiento del mapa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Desplazarse por el mapa con botones direccionales.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Switch(
                            value: _isSwitchedMapScrolling,
                            onChanged: (bool value) {
                              setState(() {
                                _isSwitchedMapScrolling = value;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

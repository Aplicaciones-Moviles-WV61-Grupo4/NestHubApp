import 'package:flutter/material.dart';
import 'package:nesthub/delete_account_page.dart';

class SharedDataPage extends StatefulWidget {
  const SharedDataPage({Key? key}) : super(key: key);

  @override
  _SharedDataPageState createState() => _SharedDataPageState();
}

class _SharedDataPageState extends State<SharedDataPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, bool> toggleStates = {
    'readReceipts': true,
    'searchEngine': true,
    'showCity': true,
    'showTravelType': true,
    'showDuration': true,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildToggleSection(
      {required String title,
      required String description,
      required String toggleKey,
      String? moreInfo}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Switch(
              value: toggleStates[toggleKey] ?? false,
              onChanged: (bool value) {
                setState(() {
                  toggleStates[toggleKey] = value;
                });
              },
            ),
          ],
        ),
        if (moreInfo != null) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              // Handle "Más información" tap
            },
            child: Text(
              moreInfo,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Configuración de datos personales y compartidos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'Datos compartidos'),
            Tab(text: 'Eliminar cuenta'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Divulgación de los datos de tu actividad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Decide cómo se muestra tu perfil y actividad a los demás.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                _buildToggleSection(
                  title: 'Confirmaciones de lectura',
                  description:
                      'Cuando esta opción está activada, le mostramos a la gente que leíste sus mensajes.',
                  toggleKey: 'readReceipts',
                  moreInfo: 'Más información',
                ),
                _buildToggleSection(
                  title: 'Incluir mis anuncios en motores de búsqueda',
                  description:
                      'Si activas esta opción, los motores de búsqueda (como Google) incluirán tus anuncios en los resultados.',
                  toggleKey: 'searchEngine',
                ),
                const Text(
                  'Reseñas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Elige qué información se comparte cuando escribes una reseña. Si actualizas esta configuración, también se va a modificar la información que se muestra en todas las reseñas anteriores.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                _buildToggleSection(
                  title: 'Mostrar mi ciudad y país de origen',
                  description:
                      'Cuando esta opción está activada, es posible que se incluya la ubicación de tu alojamiento (p. ej.: ciudad y país) con tus reseñas.',
                  toggleKey: 'showCity',
                ),
                _buildToggleSection(
                  title: 'Mostrar mi tipo de viaje',
                  description:
                      'Cuando esta opción está activada, es posible que se incluya el tipo de viaje (p. ej., si te quedaste con niños, un grupo o mascotas) con tus reseñas.',
                  toggleKey: 'showTravelType',
                ),
                _buildToggleSection(
                  title: 'Mostrar la duración de la estadía',
                  description:
                      'Cuando está activada, es posible que se incluya una duración aproximada de la estadía (p. ej.: algunas noches, alrededor de una semana o más de una semana) con tus reseñas.',
                  toggleKey: 'showDuration',
                ),
              ],
            ),
          ),
          // Servicios tab content
          const DeleteAccountContent()
        ],
      ),
    );
  }
}
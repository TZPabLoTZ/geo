import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  static const route = '/location_page';

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? mapController;
  LatLng center = LatLng(-11.5442, -55.7211);
  double raio = 4.3;
  int tipoRaio = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar localização'),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Aplicar
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: center,
                    zoom: 14,
                  ),
                  circles: {
                    Circle(
                      circleId: CircleId('raio'),
                      center: center,
                      radius: raio * 1000,
                      fillColor: Colors.blue.withOpacity(0.2),
                      strokeColor: Colors.blue,
                      strokeWidth: 2,
                    ),
                  },
                  onMapCreated: (controller) => mapController = controller,
                  myLocationEnabled: true,
                ),
                Center(
                  child: Icon(Icons.location_pin, size: 40, color: Colors.blue),
                ),
              ],
            ),
          ),
          Column(
            children: [
              RadioListTile(
                title: Text("Raio sugerido"),
                value: 0,
                groupValue: tipoRaio,
                onChanged: (value) => setState(() => tipoRaio = value!),
              ),
              RadioListTile(
                title: Text("Raio personalizado"),
                value: 1,
                groupValue: tipoRaio,
                onChanged: (value) => setState(() => tipoRaio = value!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Slider(
                  min: 1,
                  max: 20,
                  divisions: 19,
                  value: raio,
                  label: "${raio.toStringAsFixed(1)} km",
                  onChanged: (value) => setState(() => raio = value),
                ),
              ),
              Text("${raio.toStringAsFixed(1)} km"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // salvar raio e posição
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text("Aplicar"),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

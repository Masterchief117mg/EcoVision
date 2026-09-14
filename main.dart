import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(const EcoVisionApp());
}

class EcoVisionApp extends StatelessWidget {
  const EcoVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoVision',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F4),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'EcoVision ♻️',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              const Text(
                'Reciclar empieza por reconocer.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Utiliza inteligencia artificial para identificar '
                'diferentes tipos de residuos y conocer cómo '
                'disponerlos correctamente.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // Tarjeta principal
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.recycling,
                        size: 55,
                        color: Color(0xFF2E7D32),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      '¿Qué residuo quieres identificar?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Toma una fotografía y deja que la IA '
                      'analice el residuo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                       onPressed: () async {
                       final ImagePicker picker = ImagePicker();

                        final XFile? image = await picker.pickImage(
                       source: ImageSource.camera,
                       );

                        if (image != null && context.mounted) {
                      Navigator.push(
                      context,
                     MaterialPageRoute(
                   builder: (context) => ResultPage(
                    imagePath: image.path,
                    ),
                  ),
                );
                }
              },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text(
                          'Escanear residuo',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                '¿Cómo funciona?',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  _InfoCard(
                    icon: Icons.camera_alt,
                    title: '1. Captura',
                    description: 'Toma una foto',
                  ),
                  const SizedBox(width: 12),
                  _InfoCard(
                    icon: Icons.psychology,
                    title: '2. Analiza',
                    description: 'La IA identifica',
                  ),
                  const SizedBox(width: 12),
                  _InfoCard(
                    icon: Icons.recycling,
                    title: '3. Recicla',
                    description: 'Sigue la guía',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.eco,
                      color: Color(0xFF2E7D32),
                      size: 35,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Cada residuo correctamente separado '
                        'contribuye a un planeta más sostenible.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

     bottomNavigationBar: NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (index) {
      if (index == 1) {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HistorialPage(),
        ),
        );
      }
    },
    destinations: const [
   NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: 'Inicio',
      ),
     NavigationDestination(
      icon: Icon(Icons.history),
      label: 'Historial',
      ),
    ],
    ),
    );
  }
}


class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF2E7D32),
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistorialItem { //memoria para guardad
  final String resultado;
  final double confianza;
  final String imagePath;
  final DateTime fecha;

  HistorialItem({
    required this.resultado,
    required this.confianza,
    required this.imagePath,
    required this.fecha,
  });
}

final List<HistorialItem> historial = [];

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
    appBar: AppBar(
        title: Text('Historial (${historial.length})'),
          ),
         body: historial.isEmpty
    ? const Center(
        child: Text(
          'Aún no hay análisis registrados.',
          style: TextStyle(fontSize: 16),
        ),
      )
    : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: historial.length,
        itemBuilder: (context, index) {
          final item = historial[index];

          return InkWell(
           onTap: () {
              Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    imagePath: item.imagePath,
                    desdeHistorial: true,
                    resultadoGuardado: item.resultado,
                    confianzaGuardada: item.confianza,
                ),
              ),
            );
            },
              borderRadius: BorderRadius.circular(16),
              child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(item.imagePath),
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.resultado,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Confianza: ${(item.confianza * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.fecha.day}/${item.fecha.month}/${item.fecha.year} '
                          '${item.fecha.hour.toString().padLeft(2, '0')}:'
                          '${item.fecha.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
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
        },
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
final String imagePath;
final bool desdeHistorial;
final String? resultadoGuardado;
final double? confianzaGuardada;

const ResultPage({
  super.key,
  required this.imagePath,
  this.desdeHistorial = false,
  this.resultadoGuardado,
  this.confianzaGuardada,
});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Interpreter? _interpreter;

  String _resultado = 'Analizando...';
  double _confianza = 0;
  String _recomendacion = '';

  final List<String> _labels = [
    'Plastico',
    'Metal',
    'Vidrio',
    'Carton',
    'Organico',
  ];

@override
void initState() {
  super.initState();

  if (widget.desdeHistorial) {
    _resultado = widget.resultadoGuardado ?? 'Sin resultado';
    _confianza = widget.confianzaGuardada ?? 0;
    _recomendacion = _obtenerRecomendacion(_resultado);
  } else {
    _analizarImagen();
  }
}

  Future<void> _analizarImagen() async {
    try {
      // Cargar el modelo de IA
      _interpreter = await Interpreter.fromAsset(
        'assets/models/model.tflite',
      );

      // Leer la fotografía
      final bytes = await File(widget.imagePath).readAsBytes();

      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        throw Exception('No se pudo leer la imagen.');
      }

      // El modelo de Teachable Machine trabaja con 224 x 224.
      final resizedImage = img.copyResize(
        decodedImage,
        width: 224,
        height: 224,
      );

      // Crear entrada para el modelo cuantificado.
      final input = List.generate(
        1,
        (_) => List.generate(
          224,
          (y) => List.generate(
            224,
            (x) {
              final pixel = resizedImage.getPixel(x, y);

              return [
                pixel.r.toInt(),
                pixel.g.toInt(),
                pixel.b.toInt(),
              ];
            },
          ),
        ),
      );

      // Cinco clases de salida.
      final output = [
        List<int>.filled(5, 0),
      ];

      // Ejecutar la IA.
      _interpreter!.run(input, output);

      final valores = output[0];

      // Convertir los resultados a valores comparables.
      final total = valores.fold<int>(
        0,
        (sum, value) => sum + value,
      );

      int indiceMayor = 0;

      for (int i = 1; i < valores.length; i++) {
        if (valores[i] > valores[indiceMayor]) {
          indiceMayor = i;
        }
      }

      double confianza;

      if (total > 0) {
        confianza = valores[indiceMayor] / total;
      } else {
        confianza = 0;
      }

      final resultado = _labels[indiceMayor];

      setState(() {
        _resultado = resultado;
        _confianza = confianza;
        _recomendacion = _obtenerRecomendacion(resultado);


        historial.add(
          HistorialItem(
            resultado: resultado,
            confianza: confianza,
            imagePath: widget.imagePath,
            fecha: DateTime.now(),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _resultado = 'Error';
        _confianza = 0;
        _recomendacion =
            'No fue posible analizar la imagen: $e';
      });
    } finally {
      _interpreter?.close();
    }
  }

  String _obtenerRecomendacion(String tipo) {
    switch (tipo) {
      case 'Plastico':
        return 'Deposita el plástico limpio y seco en el recipiente correspondiente.';
      case 'Metal':
        return 'Separa el metal para facilitar su aprovechamiento y reciclaje.';
      case 'Vidrio':
        return 'Deposita el vidrio con cuidado para evitar roturas y accidentes.';
      case 'Carton':
        return 'Mantén el cartón limpio y seco para facilitar su reciclaje.';
      case 'Organico':
        return 'Separa los residuos orgánicos de los materiales aprovechables.';
      default:
        return 'Consulta las recomendaciones locales de separación de residuos.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final porcentaje = (_confianza * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado del análisis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.file(
                File(widget.imagePath),
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            const Icon(
              Icons.psychology,
              size: 55,
              color: Color(0xFF2E7D32),
            ),

            const SizedBox(height: 10),

            const Text(
              'Resultado de la IA',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Text(
                    _resultado,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (_resultado == 'Analizando...')
                    const CircularProgressIndicator()
                  else if (_resultado != 'Error')
                    Text(
                      'Confianza: $porcentaje%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  const SizedBox(height: 15),

                  if (_recomendacion.isNotEmpty)
                    Text(
                      _recomendacion,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text(
                  'Analizar otro residuo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: const Center(
        child: Text(
          'Aún no hay residuos analizados.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
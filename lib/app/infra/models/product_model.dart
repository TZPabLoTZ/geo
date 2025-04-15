import 'package:geo/app/infra/models/location_model.dart';

class ProductModel {
  int? id;
  final String name;
  final String description;
  final double price;
  final String image;
  final List<String>? listImages;
  final LocationModel? location;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.listImages,
    this.location,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'image': image});
    if (listImages != null) {
      result.addAll({'listImages': listImages});
    }
    if (location != null) {
      result.addAll({'location': location!.toMap()});
    }

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      listImages: List<String>.from(map['listImages']),
      location:
          map['location'] != null
              ? LocationModel.fromMap(map['location'])
              : null,
    );
  }
}

final List<ProductModel> products = [
  ProductModel(
    id: 1,
    name: 'Product 1',
    description: 'Description of Product 1',
    price: 20,
    image: 'assets/images/lojas.png',
    listImages: [
      'assets/images/lojas.png',
      'assets/images/lojas.png',
      'assets/images/lojas.png',
    ],
    location: LocationModel(
      address: "rua serra do tombador",
      city: "Sorriso",
      state: "MT",
      latitude: -12.55043,
      longitude: -55.74707,
    ),
  ),
  ProductModel(
    id: 2,
    name: 'Product 2',
    description: 'Description of Product 2',
    price: 20,
    image: 'assets/images/lojas.png',
    listImages: [
      'assets/images/lojas.png',
      'assets/images/lojas.png',
      'assets/images/lojas.png',
    ],
    location: LocationModel(
      address: "Avenida Central",
      city: "Rio de Janeiro",
      state: "RJ",
      latitude: -22.90642,
      longitude: -43.18223,
    ),
  ),
  ProductModel(
    name: 'Product 3',
    description: 'Description of Product 3',
    price: 30,
    image: 'assets/images/lojas.png',
    listImages: [
      'assets/images/lojas.png',
      'assets/images/lojas.png',
      'assets/images/lojas.png',
    ],
    location: LocationModel(
      address: "Praça da Liberdade",
      city: "Belo Horizonte",
      state: "MG",
      latitude: -19.92083,
      longitude: -43.93778,
    ),
  ),
];

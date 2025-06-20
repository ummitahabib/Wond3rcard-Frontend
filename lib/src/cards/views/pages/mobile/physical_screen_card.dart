import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PhysicalCardScreen extends ConsumerWidget {
//   final String userId;

//   PhysicalCardScreen({required this.userId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cardsAsync = ref.watch(physicalCardProvider(userId));
//     String selectedRegion = 'nigeria';
//     String address = '123 LA, USA';

//     return Scaffold(
//       appBar: AppBar(title: Text("Your Physical Cards")),
//       body: cardsAsync.when(
//         data: (cards) {
//           return ListView.builder(
//             itemCount: cards.length,
//             itemBuilder: (context, index) {
//               final card = cards[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(card.cardTemplate.name),
//                   subtitle: Text("Status: ${card.status}"),
//                   trailing: ElevatedButton(
//                     child: Text("Order"),
//                     onPressed: () async {
//                       final region = await showDialog<String>(
//                         context: context,
//                         builder: (_) => SimpleDialog(
//                           title: Text("Select Region"),
//                           children: ["nigeria", "usa", "uk"]
//                               .map((r) => SimpleDialogOption(
//                                     child: Text(r),
//                                     onPressed: () => Navigator.pop(context, r),
//                                   ))
//                               .toList(),
//                         ),
//                       );
//                       if (region != null) {
//                         final response = await ref.read(createOrderProvider({
//                           'userId': userId,
//                           'physicalCardId': card.cardId,
//                           'cardTemplateId': card.cardTemplate.id,
//                           'quantity': 1,
//                           'region': region,
//                           'address': address,
//                         }).future);
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: Text("Pay Now"),
//                             content: Text("Pay at: ${response.paymentUrl} (${response.currency})"),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: Text("OK"),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text("Error loading cards")),
//       ),
//     );
//   }
// }



// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../repository/order_repository.dart';
// import '../models/order_response_model.dart';
// import '../models/physical_card_model.dart';
// import 'dio_provider.dart'; // provides Dio instance

// final orderRepositoryProvider = Provider((ref) {
//   final dio = ref.watch(dioProvider);
//   return OrderRepository(dio);
// });

// final physicalCardProvider = FutureProvider.family<List<PhysicalCard>, String>((ref, userId) {
//   return ref.read(orderRepositoryProvider).getUserPhysicalCards(userId);
// });

// final createOrderProvider = FutureProvider.family<OrderResponse, Map<String, dynamic>>((ref, data) {
//   return ref.read(orderRepositoryProvider).createOrder(
//     userId: data['userId'],
//     physicalCardId: data['physicalCardId'],
//     cardTemplateId: data['cardTemplateId'],
//     quantity: data['quantity'],
//     region: data['region'],
//     address: data['address'],
//   );
// });



// import 'package:dio/dio.dart';
// import '../models/order_response_model.dart';
// import '../models/physical_card_model.dart';

// class OrderRepository {
//   final Dio dio;

//   OrderRepository(this.dio);

//   Future<OrderResponse> createOrder({
//     required String userId,
//     required String physicalCardId,
//     required String cardTemplateId,
//     required int quantity,
//     required String region,
//     required String address,
//   }) async {
//     final response = await dio.post('/order-card', data: {
//       "userId": userId,
//       "physicalCardId": physicalCardId,
//       "cardTemplateId": cardTemplateId,
//       "quantity": quantity,
//       "region": region.toLowerCase(),
//       "address": address,
//     });

//     return OrderResponse.fromJson(response.data);
//   }

  // Future<List<PhysicalCard>> getUserPhysicalCards(String userId) async {
  //   final response = await dio.get('/user/$userId/physical-cards');
  //   final List data = response.data['payload'];
  //   return data.map((e) => PhysicalCard.fromJson(e)).toList();
  // }
//}



// class PhysicalCard {
//   final String id;
//   final String user;
//   final String cardId;
//   final CardTemplate cardTemplate;
//   final String primaryColor;
//   final String secondaryColor;
//   final String finalDesign;
//   final String status;

//   PhysicalCard({
//     required this.id,
//     required this.user,
//     required this.cardId,
//     required this.cardTemplate,
//     required this.primaryColor,
//     required this.secondaryColor,
//     required this.finalDesign,
//     required this.status,
//   });

//   factory PhysicalCard.fromJson(Map<String, dynamic> json) {
//     return PhysicalCard(
//       id: json['_id'],
//       user: json['user'],
//       cardId: json['cardId'],
//       cardTemplate: CardTemplate.fromJson(json['cardTemplate']),
//       primaryColor: json['primaryColor'],
//       secondaryColor: json['secondaryColor'],
//       finalDesign: json['finalDesign'],
//       status: json['status'],
//     );
//   }
// }

// class CardTemplate {
//   final String id;
//   final String name;
//   final int priceNaira;
//   final int priceUsd;

//   CardTemplate({
//     required this.id,
//     required this.name,
//     required this.priceNaira,
//     required this.priceUsd,
//   });

//   factory CardTemplate.fromJson(Map<String, dynamic> json) {
//     return CardTemplate(
//       id: json['_id'],
//       name: json['name'],
//       priceNaira: json['priceNaira'],
//       priceUsd: json['priceUsd'],
//     );
//   }
// }



// class OrderResponse {
//   final String paymentUrl;
//   final String currency;

//   OrderResponse({
//     required this.paymentUrl,
//     required this.currency,
//   });

//   factory OrderResponse.fromJson(Map<String, dynamic> json) {
//     final payload = json['payload'];
//     return OrderResponse(
//       paymentUrl: payload['paymentUrl'],
//       currency: payload['currency'],
//     );
//   }
// }

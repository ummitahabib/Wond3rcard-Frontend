// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';

// class ConnectUserButton extends ConsumerWidget {
//   final String contactUserId;

//   const ConnectUserButton({super.key, required this.contactUserId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final connectState = ref.watch(connectUserProvider);

//     return ElevatedButton(
//       onPressed: connectState.isLoading
//           ? null
//           : () async {
//               await ref.read(connectUserProvider.notifier).connect(contactUserId);

//               final response = ref.read(connectUserProvider);
//               if (response.hasValue) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Connected successfully!')),
//                 );
//               }
//             },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.deepPurple,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       child: connectState.isLoading
//           ? const CircularProgressIndicator(color: Colors.white)
//           : const Text('Connect', style: TextStyle(color: Colors.white)),
//     );
//   }
// }

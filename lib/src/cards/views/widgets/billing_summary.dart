import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class BillingSummary extends StatelessWidget {
  final Widget? selectedCardTemplate;
  final Uint8List? uploadedDesign;
  final String shippingAddress;
  final String nameOnCard;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final int quantity;
  final double totalPrice;

  const BillingSummary({
    super.key,
    this.selectedCardTemplate,
    this.uploadedDesign,
    required this.shippingAddress,
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Billing Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Card Design',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            if (uploadedDesign != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    uploadedDesign!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else if (selectedCardTemplate != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: selectedCardTemplate),
              )
            else
              const Text(
                'No design selected.',
                style: TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 20),
            Container(padding: EdgeInsets.all(10), margin: EdgeInsets.all(10),
            child: Column(children: [
    const Text(
              'Shipping Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              shippingAddress,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Card Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Name on Card: $nameOnCard',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Card Number: $cardNumber',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Expiry Date: $expiryDate',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'CVV: $cvv',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Quantity: $quantity',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            WonderCardButton(text: 'Checkout', onPressed: (){}, backgroundColor: AppColors.primaryShade, textColor: AppColors.defaultWhite,),
            SizedBox(height: 10,),
           WonderCardButton(text: 'Cancel Order', onPressed: (){}, textColor: AppColors.primaryShade, backgroundColor: AppColors.defaultWhite,),
           
            ],),
            ),
        
          ],
        ),
      ),
    );
  }
}
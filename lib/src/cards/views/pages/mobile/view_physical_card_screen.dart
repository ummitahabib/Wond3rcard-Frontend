import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewPhysicalCardScreen extends ConsumerWidget {
  const ViewPhysicalCardScreen({super.key});
  final String routeName = RouteString.viewPhysicalCard;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Physical Card', style: WonderCardTypography.boldTextH5(
          fontSize:23 , color:AppColors.grayScale , 
        ),), 
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios, color: AppColors.grayScale,)),
        centerTitle: true,
      ),
      
     body:  Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
   Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Card Name',
                style: TextStyle(
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              SizedBox(
                  width: 141,
                  height: 40,
                  child: WonderCardButton(
                      leadingIcon: HeroIcon(
                        HeroIcons.shoppingBag,
                        color: AppColors.defaultWhite,
                      ),
                      backgroundColor: AppColors.primaryShade,
                      textColor: AppColors.defaultWhite,
                      text: 'Order Card',
                      onPressed: () {}))
            ],
          ),
        ),

        
    SvgPicture.asset('images/profile_header.svg', color: Colors.green,),

        
      ],),
    );
  }
}
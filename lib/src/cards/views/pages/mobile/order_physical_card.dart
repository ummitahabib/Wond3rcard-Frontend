import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/utils/util.dart';

class OrderPhysicalCard extends ConsumerWidget {
  const OrderPhysicalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
   appBar: AppBar(
        title: Text('Order Physical Card', style: WonderCardTypography.boldTextH5(
          fontSize:23 , color:AppColors.grayScale , 
        ),), 
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios, color: AppColors.grayScale,)),
        centerTitle: true,
      ),

body: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
    Text('Choose card', style: WonderCardTypography.boldTextTitleBold(
fontSize: 18, color: AppColors.grayScale800,
    )),
        GestureDetector(
          onTap: (){
            context.go(RouteString.viewPhysicalCard);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.defaultWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryShade,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned.fill(
                      child: ClipOval(
                        child: Image.network(
                          ImageAssets.bgBlur,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Card name',
                          style: WonderCardTypography.boldTextH5(
                            fontSize: 23,
                            color: AppColors.grayScale700,
                          )),
                      Text('Designation',
                          style: WonderCardTypography.regularTextTitle2(
                              fontSize: 16, color: AppColors.grayScale600)),
                     
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.grayScale600,
                )
              ],
            ),
          ),
        ),

   SizedBox(height: 10,),
  Text('Physical Card Design', style: WonderCardTypography.boldTextTitleBold(
fontSize: 18, color: AppColors.primaryShade,
    )),
    SizedBox(height: 10,),
     Text('Choose Design from template', style: WonderCardTypography.boldTextTitleBold(
fontSize: 18, color: AppColors.primaryShade,
    )), 


    SizedBox(height: 20,),

    
  ],
),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class EarningWidgets extends StatelessWidget {
  const EarningWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: 394,
      height: size.height * SpacingConstants.size0point5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your earning this month',
            style: WonderCardTypography.boldTextTitleBold(
                color: Color(0xff3A3541)),
          ),
          Text(
            textAlign: TextAlign.center,
            '735.2',
            style: TextStyle(
              color: Color(0xff6E39CB),
              fontFamily: 'Barlow',
              fontSize: 64,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                width: 210,
                height: 49,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.defaultWhite,
                    border: Border.all(
                      color: AppColors.primaryShade,
                    )),
                child: Center(
                  child: Text(
                    'View Details',
                    style: WonderCardTypography.titleH6(),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

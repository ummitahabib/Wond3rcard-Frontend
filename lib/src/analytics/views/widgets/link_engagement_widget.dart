import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/util.dart';


class LinkEngagement {
  final String title;
  final String imageUrl;
  final String tapCount;
  final String metric;

  LinkEngagement({
    required this.title,
    required this.imageUrl,
    required this.tapCount,
    required this.metric,
  });
}



final List<LinkEngagement> dummyEngagements = [
  LinkEngagement(
    title: 'Instagram',
    imageUrl: 'https://via.placeholder.com/60',
    tapCount: '2.1k',
    metric: 'Taps',
  ),
  LinkEngagement(
    title: 'Twitter',
    imageUrl: 'https://via.placeholder.com/60',
    tapCount: '1.5k',
    metric: 'Taps',
  ),
  LinkEngagement(
    title: 'LinkedIn',
    imageUrl: 'https://via.placeholder.com/60',
    tapCount: '3.2k',
    metric: 'Taps',
  ),
];



class LinkEngagementWidget extends StatelessWidget {
  final LinkEngagement data;

  const LinkEngagementWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 83,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.grayScale50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              data.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.title,
            style: const TextStyle(
              fontFamily: 'Barlow',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.tapCount,
                style: const TextStyle(
                  fontFamily: 'Barlow',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                data.metric,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



class LinkEngagementList extends StatelessWidget {
  const LinkEngagementList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
                    padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(12),),
     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
           Text('Link engagement', style: WonderCardTypography.boldTextTitleBold(),),
              SizedBox(height: 9),
          SizedBox(
             height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyEngagements.length,
              itemBuilder: (context, index) {
                return 
                    LinkEngagementWidget(data: dummyEngagements[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

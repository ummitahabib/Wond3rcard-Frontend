import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class RecentlyJoinedWidget extends StatelessWidget {
  final RecentlyJoinedUser user;

  const RecentlyJoinedWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(user.imageUrl),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(width: 15),
          Text(
            user.firstName,
            style: WonderCardTypography.boldTextTitleBold(
              color: AppColors.grayScale700,
            ),
          ),
          SizedBox(width: 15),
          Text(
            user.workPlace,
            style: TextStyle(
              color: AppColors.grayScale600,
              fontFamily: 'Barlow',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Text(
            user.joinedTime,
            style: TextStyle(
              color: AppColors.grayScale600,
              fontFamily: 'Barlow',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class RecentlyJoinedUser {
  final String firstName;
  final String workPlace;
  final String imageUrl;
  final String joinedTime;

  RecentlyJoinedUser({
    required this.firstName,
    required this.workPlace,
    required this.imageUrl,
    required this.joinedTime,
  });
}

final List<RecentlyJoinedUser> recentlyJoinedUsers = [
  RecentlyJoinedUser(
    firstName: "Alice",
    workPlace: "Google",
    imageUrl: "https://via.placeholder.com/34",
    joinedTime: "10:30 AM",
  ),
  RecentlyJoinedUser(
    firstName: "Bob",
    workPlace: "Facebook",
    imageUrl: "https://via.placeholder.com/34",
    joinedTime: "11:45 AM",
  ),
  RecentlyJoinedUser(
    firstName: "Charlie",
    workPlace: "Amazon",
    imageUrl: "https://via.placeholder.com/34",
    joinedTime: "12:15 PM",
  ),
];

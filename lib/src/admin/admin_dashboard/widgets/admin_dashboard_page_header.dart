import 'package:flutter/material.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/shared/views/widgets/reusable_cached_network_image.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/to_sentence_case.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    required this.userData,
    required this.title,
    this.isTabView = false,
    super.key,
  });

  final User? userData;
  final String title;
  final bool isTabView;

  @override
  Widget build(BuildContext context) {
    if (isTabView) {
      return PageHeaderMobile(
        userData: userData,
        title: title,
        isTabView: isTabView,
      );
    } else {
      return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: size10, vertical: size10),
        color: AppColors.defaultWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: WonderCardTypography.headlineH2(),
            ),
            const SizedBox(width: size50),
            ResponsiveSearchTextField(),
            const Spacer(),
            reusableCachedNetworkImage(
              width: size40,
              imageUrl: emptyString ?? defaultImage,
            ),
            const SizedBox(width: size10),
            GestureDetector(
              onTap: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(width: size500, child: Container()),
                    );
                  },
                ),
              },
              child: Row(
                children: [
                  Text(
                    toSentenceCase(userData?.username) ??
                        AppStrings.emptyString,
                    style: WonderCardTypography.boldTextH5(
                      color: AppColors.grayScale800,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                  const SizedBox(width: size20),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

class PageHeaderMobile extends StatelessWidget {
  const PageHeaderMobile({
    required this.userData,
    required this.title,
    this.isTabView = false,
    super.key,
  });

  final User? userData;
  final String title;
  final bool isTabView;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: AppColors.defaultWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isTabView)
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: size25,
                color: AppColors.grayScale800,
              ),
            ),
          if (!isTabView) const Spacer(),
          Text(
            title,
            style: WonderCardTypography.boldTextTitleBold(
              color: AppColors.grayScale800,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
          const SizedBox(width: size10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(width: size500, child: Container()),
                  );
                },
              );
            },
            child: Row(
              children: [
                reusableCachedNetworkImage(
                  width: size25,
                  imageUrl: emptyString ?? defaultImage,
                ),
                const SizedBox(width: size10),
                SizedBox(
                  width: size50,
                  child: Text(
                    toSentenceCase(userData?.username) ??
                        AppStrings.emptyString,
                    overflow: TextOverflow.ellipsis,
                    style: WonderCardTypography.regularTextTitle2(
                      color: AppColors.grayScale800,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
          const SizedBox(width: size10),
        ],
      ),
    );
  }
}

class ResponsiveSearchTextField extends StatelessWidget {
  const ResponsiveSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth * 0.8;
        if (width > 600) width = 500;

        return Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFDBDCDE)),
            color: const Color(0xFFFFFFFF),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search anything here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Icon(Icons.search, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }
}

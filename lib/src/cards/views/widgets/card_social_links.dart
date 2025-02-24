import 'package:flutter/material.dart';

class SocialMediaSwitches extends StatefulWidget {
  const SocialMediaSwitches({super.key});

  @override
  _SocialMediaSwitchesState createState() => _SocialMediaSwitchesState();
}

class _SocialMediaSwitchesState extends State<SocialMediaSwitches> {
  bool activateAll = false;
  final Map<String, bool> socialMediaStatus = {
    "Instagram": false,
    "Facebook": false,
    "Twitter": false,
    "LinkedIn": false,
  };

  void toggleAllSwitches(bool value) {
    setState(() {
      activateAll = value;
      socialMediaStatus.updateAll((key, _) => value);
    });
  }

  void toggleIndividualSwitch(String platform, bool value) {
    setState(() {
      socialMediaStatus[platform] = value;
      activateAll = !socialMediaStatus.containsValue(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Master Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Activate All",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Switch(
                value: activateAll,
                onChanged: toggleAllSwitches,
              ),
            ],
          ),
          const Divider(),
          // Individual Switches
          ...socialMediaStatus.keys.map((platform) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  platform,
                  style: const TextStyle(fontSize: 16),
                ),
                Switch(
                  value: socialMediaStatus[platform]!,
                  onChanged: (value) => toggleIndividualSwitch(platform, value),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

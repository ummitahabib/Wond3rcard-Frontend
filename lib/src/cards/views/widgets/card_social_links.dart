import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SocialMediaSwitches extends StatefulWidget {
//   const SocialMediaSwitches({super.key});

//   @override
//   _SocialMediaSwitchesState createState() => _SocialMediaSwitchesState();
// }

// class _SocialMediaSwitchesState extends State<SocialMediaSwitches> {
//   bool activateAll = false;
//   final Map<String, bool> socialMediaStatus = {
//     "Instagram": false,
//     "Facebook": false,
//     "Twitter": false,
//     "LinkedIn": false,
//   };

//   void toggleAllSwitches(bool value) {
//     setState(() {
//       activateAll = value;
//       socialMediaStatus.updateAll((key, _) => value);
//     });
//   }

//   void toggleIndividualSwitch(String platform, bool value) {
//     setState(() {
//       socialMediaStatus[platform] = value;
//       activateAll = !socialMediaStatus.containsValue(false);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Master Switch
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Activate All",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Switch(
//                 value: activateAll,
//                 onChanged: toggleAllSwitches,
//               ),
//             ],
//           ),
//           const Divider(),
//           // Individual Switches
//           ...socialMediaStatus.keys.map((platform) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   platform,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 Switch(
//                   value: socialMediaStatus[platform]!,
//                   onChanged: (value) => toggleIndividualSwitch(platform, value),
//                 ),
//               ],
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }


class SocialMediaSwitches extends StatefulWidget {
  final Function(Map<String, bool>) onSwitchChanged;

  const SocialMediaSwitches({super.key, required this.onSwitchChanged});

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

  @override
  void initState() {
    super.initState();
    _loadSwitchStates();
  }

  Future<void> _loadSwitchStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      activateAll = prefs.getBool('activateAll') ?? false;
      socialMediaStatus.forEach((key, _) {
        socialMediaStatus[key] = prefs.getBool(key) ?? false;
      });
    });
    widget.onSwitchChanged(socialMediaStatus);
  }

  Future<void> _saveSwitchState(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void toggleAllSwitches(bool value) {
    setState(() {
      activateAll = value;
      socialMediaStatus.updateAll((key, _) => value);
    });
    socialMediaStatus.forEach((key, value) => _saveSwitchState(key, value));
    _saveSwitchState('activateAll', value);
    widget.onSwitchChanged(socialMediaStatus);
  }

  void toggleIndividualSwitch(String platform, bool value) {
    setState(() {
      socialMediaStatus[platform] = value;
      activateAll = !socialMediaStatus.containsValue(false);
    });
    _saveSwitchState(platform, value);
    widget.onSwitchChanged(socialMediaStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          ...socialMediaStatus.keys.map((platform) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(platform, style: const TextStyle(fontSize: 16)),
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

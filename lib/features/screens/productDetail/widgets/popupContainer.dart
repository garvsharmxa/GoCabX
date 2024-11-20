import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class RequestPopup extends StatelessWidget {
  const RequestPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/content/popUpicon.png')),
          ),
          const SizedBox(
            height: 8,
          ),
          Text('निम्नलिखित में से चयन करें',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 249, 238, 231)),
            child: Row(
              children: [
                const Text('कमपन से संपर्क करें'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        print('cnlacnk');
                      },
                      child: Icon(
                        Iconsax.call,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 249, 238, 231)),
            child: Row(children: [
              const Text('नजदीकी डीलर ढुंडे'),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    print('dac');
                  },
                  child: Image(
                      image: AssetImage('assets/images/content/personPng.png')),
                )),
              )
            ]),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 249, 238, 231)),
            child: Row(
              children: [
                const Text('आस पास से रेंट पर ले'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      print('object');
                    },
                    child: Image(
                        image: AssetImage('assets/images/content/logo3.png')),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

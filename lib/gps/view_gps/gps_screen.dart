
import 'package:flutter/material.dart';
import 'package:web_dashboard/ui/cards/white_card.dart';


import 'package:web_dashboard/ui/labels/custom_labels.dart';


class GpsScreen extends StatelessWidget {
  const GpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('GPS View', style: CustomLabels.h1,),
          const SizedBox(height: 10),
            const WhiteCard(
            title: 'GPS Screen',
            child:  _AccessButton()
          )
        ],
      )
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Is requerid access to GPS'),
        MaterialButton(
          color: Colors.amber,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: ()
        {},
          child: const Text('Request Access'),
      
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Text('Habilited GPS');
  }
}
      
        
      
  
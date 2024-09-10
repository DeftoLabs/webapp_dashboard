

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/providers/profile_form_provider.dart';
import 'package:web_dashboard/services/navigation_service.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;

  const WhiteCard({
    super.key,
    required this.child,
    this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (title != null)
            ...[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title!,
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
            ],
          Center(child: child), // Centra el contenido principal
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}

class WhiteCardColor extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final Color backgroundColor;
  final Color titleColor;

  const WhiteCardColor({
    super.key,
    required this.child,
    this.title,
    this.width,
    this.backgroundColor =  const Color.fromARGB(255, 58, 60, 65),
    this.titleColor = Colors.white,
  });

 @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (title != null)
            ...[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title!,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: titleColor), // Usa el color del título aquí
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
            ],
          Center(child: child), // Centra el contenido principal
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: backgroundColor, // Usa el color de fondo aquí
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}

class WhiteCardCustomer extends StatefulWidget {
  final String? title;
  final Widget child;
  final double? width;
  final Color backgroundColor;
  final Color titleColor;

  const WhiteCardCustomer({
    super.key,
    required this.child,
    this.title,
    this.width,
    this.backgroundColor =  const Color.fromARGB(255, 58, 60, 65),
    this.titleColor = Colors.white,
  });

  @override
  State<WhiteCardCustomer> createState() => _WhiteCardCustomerState();
}

class _WhiteCardCustomerState extends State<WhiteCardCustomer> {
 @override
  Widget build(BuildContext context) {

     final profileFormProvider = Provider.of<ProfileFormProvider>(context);
    final profile = profileFormProvider.profile;

    final image = (profile?.img?.isEmpty ?? true)
    ? const SizedBox(
        width: 55,
        height: 55,
        child: Image(image: AssetImage('noimage.jpeg')),
      )
    : SizedBox(
        width: 35,
        height: 35,
        child: FadeInImage.assetNetwork(
          placeholder: 'load.gif',
          image: profile!.img!,
          fit: BoxFit.cover, // Asegura que la imagen se ajuste bien al contenedor
        ),
      );

    return Container(
      width: widget.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            if (widget.title != null)
              ...[
                Row(
                  children: [
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    NavigationService.replaceTo('/dashboard/customers');
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
                  Text('Back', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14)),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.title!,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.titleColor), // Usa el color del título aquí
                        ),
                      ),
                    ),
                    ClipOval(child: image),
                    const SizedBox(width: 20)
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(177, 255, 46, 1),
                ),
              ],
            Center(child: widget.child), // Centra el contenido principal
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: widget.backgroundColor, // Usa el color de fondo aquí
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}

class WhiteCardNoMargin extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;

  const WhiteCardNoMargin({
    super.key,
    required this.child,
    this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          if (title != null)
            ...[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title!,
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
            ],
          Center(child: child), // Centra el contenido principal
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}
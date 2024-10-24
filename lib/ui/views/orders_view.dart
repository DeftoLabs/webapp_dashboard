
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/datatables/orders_datasource.dart';
import 'package:web_dashboard/providers/providers.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/ui/cards/rectangular_card.dart';



class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {

    @override
  void initState() {
    super.initState();
    final ordenDateProvider = Provider.of<OrdenDateProvider>(context, listen: false);
    ordenDateProvider.getOrdenByDay();
  }

  @override
  Widget build(BuildContext context) {

    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profiles.isNotEmpty ? profileProvider.profiles[0] : null;

    if (profile == null) {
    return const Center(child: Text(''));
    }

    final image = (profile.img == null) 
    ? const Image(image: AssetImage('noimage.jpeg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'load.gif', image: profile.img!, width: 35, height: 35);

    String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
    final ordenDateProvider = Provider.of<OrdenDateProvider>(context);
    // final ordenProvider = Provider.of<OrdenesProvider>(context);

      if (ordenDateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ordersDataSource = OrdersDateDataSource( ordenDateProvider.ordenes );

     final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded
              (
                child: Text('Orders View', style: GoogleFonts.plusJakartaSans(fontSize: 22),)),
              SizedBox(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: image,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),

          const SizedBox(height: 10),
          Column(
            children: [
              Container(
              decoration: BoxDecoration(
              color:Colors.grey[300],
              
              borderRadius: BorderRadius.circular(15)
              ),
                child: PaginatedDataTable(
                  header: Text('Order of the Day - $todayDate', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold),),
                  columns:const [
                    DataColumn(label: Text('# Order')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Delivery')),
                    DataColumn(label: Text('Customer')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Sales')),
                    DataColumn(label: Text('Edit')),
                  ], 
                  source: ordersDataSource,
                  columnSpacing: ordersDataSource.rowCount == 0 ? screenWidth * 0.07 : screenWidth * 0.028,
                  rowsPerPage: 7,
                  
                  ),
              ),

                const SizedBox( height: 20),

        const OrdersScrollRow(),
         const SizedBox( height: 20),
            ],
          )
        ],
      )
    );
  }
}

class OrdersScrollRow extends StatefulWidget {
  const OrdersScrollRow({super.key});

  @override
  OrdersScrollRowState createState() => OrdersScrollRowState();
}

class OrdersScrollRowState extends State<OrdersScrollRow> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset - 300, // Scroll hacia la izquierda
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 300, // Scroll hacia la derecha
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RectangularCard(
                title: 'Order Records',
                width: 200,
                child: const Center(child: Icon(Icons.push_pin_rounded)),
                onTap: () {
                  NavigationService.replaceTo('/dashboard/orders/records');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Status',
                width: 200,
                child: const Center(child: Icon(Icons.settings)),
                onTap: () {
                  NavigationService.replaceTo('');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Notifications',
                width: 200,
                child: const Center(child: Icon(Icons.notifications)),
                onTap: () {
                  NavigationService.replaceTo('');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Messages',
                width: 200,
                child: const Center(child: Icon(Icons.message)),
                onTap: () {
                  NavigationService.replaceTo('');
                },
              ),
              const SizedBox(width: 16),
              RectangularCard(
                title: 'Contacts',
                width: 200,
                child: const Center(child: Icon(Icons.contacts)),
                onTap: () {
                  NavigationService.replaceTo('');
                },
              ),
            ],
          ),
        ),
        // Flecha hacia la izquierda
        Positioned(
          left: 25,
          top: 0,
          bottom: 0,
          child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle
              ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _scrollLeft,
              ),
            ),
          ),
        ),
        // Flecha hacia la derecha
        Positioned(
          right: 25,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: _scrollRight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

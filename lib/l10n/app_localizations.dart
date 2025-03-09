import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @analityc.
  ///
  /// In en, this message translates to:
  /// **'Analisis'**
  String get analityc;

  /// No description provided for @estadistic.
  ///
  /// In en, this message translates to:
  /// **'Estadistics'**
  String get estadistic;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @shipment.
  ///
  /// In en, this message translates to:
  /// **'Shipment'**
  String get shipment;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @catalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get catalog;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @gps.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get gps;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get route;

  /// No description provided for @zone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zone;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @marketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get marketing;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get logout;

  /// No description provided for @createpayment.
  ///
  /// In en, this message translates to:
  /// **'CREATE PAYMENT\''**
  String get createpayment;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @paymentregistered.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT REGISTERED'**
  String get paymentregistered;

  /// No description provided for @doyouwant.
  ///
  /// In en, this message translates to:
  /// **'DO YOU WANT TO ATTACH A FILE?'**
  String get doyouwant;

  /// No description provided for @formatsallowed.
  ///
  /// In en, this message translates to:
  /// **'ALLOWED FORMATS: .jpg .jpeg .png'**
  String get formatsallowed;

  /// No description provided for @errorimage.
  ///
  /// In en, this message translates to:
  /// **'Failed to Upload Image'**
  String get errorimage;

  /// No description provided for @attachfile.
  ///
  /// In en, this message translates to:
  /// **'Attach File'**
  String get attachfile;

  /// No description provided for @errorpayment.
  ///
  /// In en, this message translates to:
  /// **'Could not save the Payment:'**
  String get errorpayment;

  /// No description provided for @representative.
  ///
  /// In en, this message translates to:
  /// **'Representative'**
  String get representative;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER'**
  String get customer;

  /// No description provided for @selectacustomer.
  ///
  /// In en, this message translates to:
  /// **'PLEASE SELECT A CUSTOMER'**
  String get selectacustomer;

  /// No description provided for @paymenttype.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT TYPE'**
  String get paymenttype;

  /// No description provided for @selectpayment.
  ///
  /// In en, this message translates to:
  /// **'PLEASE SELECT A PAYMENT TYPE'**
  String get selectpayment;

  /// No description provided for @errorcurrency01.
  ///
  /// In en, this message translates to:
  /// **'NO CURRENCIES AVAILABLE'**
  String get errorcurrency01;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'CURRENCY'**
  String get currency;

  /// No description provided for @selectcurrency.
  ///
  /// In en, this message translates to:
  /// **'PLEASE SELECT A CURRENCY'**
  String get selectcurrency;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'AMOUNT'**
  String get amount;

  /// No description provided for @selectamount.
  ///
  /// In en, this message translates to:
  /// **'PLEASE ENTER AN AMOUNT'**
  String get selectamount;

  /// No description provided for @validnumber.
  ///
  /// In en, this message translates to:
  /// **'PLEASE ENTER A VALID NUMBER'**
  String get validnumber;

  /// No description provided for @maxlegth12.
  ///
  /// In en, this message translates to:
  /// **'NOT EXCEED 12 CHARACTERS'**
  String get maxlegth12;

  /// No description provided for @errorbank01.
  ///
  /// In en, this message translates to:
  /// **'NO BANKS AVAILABLE'**
  String get errorbank01;

  /// No description provided for @bankaccount.
  ///
  /// In en, this message translates to:
  /// **'BANK ACCOUNT'**
  String get bankaccount;

  /// No description provided for @selectbank.
  ///
  /// In en, this message translates to:
  /// **'PLEASE SELECT A BANK RECEIVER'**
  String get selectbank;

  /// No description provided for @datepayment.
  ///
  /// In en, this message translates to:
  /// **'DATE PAYMENT'**
  String get datepayment;

  /// No description provided for @selectadate.
  ///
  /// In en, this message translates to:
  /// **'PLEASE SELECT A DATE'**
  String get selectadate;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'REFERENCE'**
  String get reference;

  /// No description provided for @selectreference.
  ///
  /// In en, this message translates to:
  /// **'PLEASE ENTER A REFERENCE\''**
  String get selectreference;

  /// No description provided for @maxlegth30.
  ///
  /// In en, this message translates to:
  /// **'COMMENTS MUST NOT EXCEED 30 CHARACTERS'**
  String get maxlegth30;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'BANK'**
  String get bank;

  /// No description provided for @selectbankemisor.
  ///
  /// In en, this message translates to:
  /// **'PLEASE ENTER A BANK NAME'**
  String get selectbankemisor;

  /// No description provided for @detailsandcomments.
  ///
  /// In en, this message translates to:
  /// **'DETAILS AND COMMENTS'**
  String get detailsandcomments;

  /// No description provided for @selectdetails.
  ///
  /// In en, this message translates to:
  /// **'PLEASE ENTER A COMMENTS OR DETAILS'**
  String get selectdetails;

  /// No description provided for @maxlegth50.
  ///
  /// In en, this message translates to:
  /// **'NOT EXCEED 50 CHARACTERS'**
  String get maxlegth50;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'CASH'**
  String get cash;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'TRANSFER'**
  String get transfer;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'CHECK'**
  String get check;

  /// No description provided for @usernotauth.
  ///
  /// In en, this message translates to:
  /// **'USER NOT AUTHENTICATED'**
  String get usernotauth;

  /// No description provided for @paymentview.
  ///
  /// In en, this message translates to:
  /// **'Payment View'**
  String get paymentview;

  /// No description provided for @createpaymentview.
  ///
  /// In en, this message translates to:
  /// **'Create Payment'**
  String get createpaymentview;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get date;

  /// No description provided for @control.
  ///
  /// In en, this message translates to:
  /// **'CONTROL'**
  String get control;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get type;

  /// No description provided for @customerview.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER'**
  String get customerview;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'EDIT'**
  String get edit;

  /// No description provided for @nopaymentsavailable.
  ///
  /// In en, this message translates to:
  /// **'NO PAYMENTS AVAILABLE'**
  String get nopaymentsavailable;

  /// No description provided for @todayorders.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S ORDERS'**
  String get todayorders;

  /// No description provided for @neworder.
  ///
  /// In en, this message translates to:
  /// **'NEW ORDERS'**
  String get neworder;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'APPROVED'**
  String get approved;

  /// No description provided for @noteinvoice.
  ///
  /// In en, this message translates to:
  /// **'NOTE / INVOICE'**
  String get noteinvoice;

  /// No description provided for @orderfromlast7days.
  ///
  /// In en, this message translates to:
  /// **'ORDER FROM LAST 7 DAYS'**
  String get orderfromlast7days;

  /// No description provided for @top5productstoday.
  ///
  /// In en, this message translates to:
  /// **'TOP 5 PRODUCTS TODAY'**
  String get top5productstoday;

  /// No description provided for @noproductsoldtoday.
  ///
  /// In en, this message translates to:
  /// **'NO PRODUCT SOLD TODAY'**
  String get noproductsoldtoday;

  /// No description provided for @ordersbysalesrepresntativelast7days.
  ///
  /// In en, this message translates to:
  /// **'ORDERS BY SALES REPRESENTATIVE LAST 7 DAYS'**
  String get ordersbysalesrepresntativelast7days;

  /// No description provided for @totalsoldlast7days.
  ///
  /// In en, this message translates to:
  /// **'TOTAL SOLD LAST 7 DAYS'**
  String get totalsoldlast7days;

  /// No description provided for @top5customertoday.
  ///
  /// In en, this message translates to:
  /// **'TOP 5 CUSTOMER TODAY'**
  String get top5customertoday;

  /// No description provided for @top5customerlast30days.
  ///
  /// In en, this message translates to:
  /// **'TOP 5 CUSTOMER IN THE LAST 30 DAYS'**
  String get top5customerlast30days;

  /// No description provided for @norderlast30days.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS IN THE LAST 30 DAYS'**
  String get norderlast30days;

  /// No description provided for @top5productinthelast30days.
  ///
  /// In en, this message translates to:
  /// **'TOP 5 PRODUCT IN THE LAST 30 DAYS'**
  String get top5productinthelast30days;

  /// No description provided for @availablesoon.
  ///
  /// In en, this message translates to:
  /// **'AVAILABLE SOON'**
  String get availablesoon;

  /// No description provided for @createorderm.
  ///
  /// In en, this message translates to:
  /// **'Create a Order'**
  String get createorderm;

  /// No description provided for @createorder.
  ///
  /// In en, this message translates to:
  /// **'CREATE A ORDER'**
  String get createorder;

  /// No description provided for @deliverydate.
  ///
  /// In en, this message translates to:
  /// **'DELIVERY DATE'**
  String get deliverydate;

  /// No description provided for @ordertype.
  ///
  /// In en, this message translates to:
  /// **'ORDER TYPE'**
  String get ordertype;

  /// No description provided for @errorordertype.
  ///
  /// In en, this message translates to:
  /// **'SELECT A ORDER TYPE'**
  String get errorordertype;

  /// No description provided for @noroute.
  ///
  /// In en, this message translates to:
  /// **'NO ROUTE or'**
  String get noroute;

  /// No description provided for @custumerassigned.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER ASSIGNED'**
  String get custumerassigned;

  /// No description provided for @selectcustomer.
  ///
  /// In en, this message translates to:
  /// **'PLEASE SELECT A CUSTOMER'**
  String get selectcustomer;

  /// No description provided for @addproduct.
  ///
  /// In en, this message translates to:
  /// **'ADD PRODUCT'**
  String get addproduct;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'ITEM'**
  String get item;

  /// No description provided for @selectitem.
  ///
  /// In en, this message translates to:
  /// **'SELECT A ITEM'**
  String get selectitem;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'PRICE'**
  String get price;

  /// No description provided for @selectprice.
  ///
  /// In en, this message translates to:
  /// **'SELECT A PRICE'**
  String get selectprice;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'QUANTITY'**
  String get quantity;

  /// No description provided for @selectqunatity.
  ///
  /// In en, this message translates to:
  /// **'ENTER THE QUANTITY'**
  String get selectqunatity;

  /// No description provided for @maxlength4.
  ///
  /// In en, this message translates to:
  /// **'CANNOT EXCEED 4 CHARACTERS'**
  String get maxlength4;

  /// No description provided for @observationsandcomments.
  ///
  /// In en, this message translates to:
  /// **'OBSERVATIONS AND COMMENTS:'**
  String get observationsandcomments;

  /// No description provided for @maxlegth100.
  ///
  /// In en, this message translates to:
  /// **'CANNOT EXCEED 100 CHARACTERS'**
  String get maxlegth100;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @warningmessage01.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get warningmessage01;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'SI'**
  String get yes;

  /// No description provided for @warningmessage02.
  ///
  /// In en, this message translates to:
  /// **'The product list is empty. Please add at least one product.'**
  String get warningmessage02;

  /// No description provided for @ordercreated.
  ///
  /// In en, this message translates to:
  /// **'Order Created'**
  String get ordercreated;

  /// No description provided for @ordererror.
  ///
  /// In en, this message translates to:
  /// **'Could not save the Order'**
  String get ordererror;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'ORDER'**
  String get order;

  /// No description provided for @branch.
  ///
  /// In en, this message translates to:
  /// **'BRANCH'**
  String get branch;

  /// No description provided for @noroderfound.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS FOUND FOR: '**
  String get noroderfound;

  /// No description provided for @dowload.
  ///
  /// In en, this message translates to:
  /// **'DOWNLOAD'**
  String get dowload;

  /// No description provided for @ordermessagedownload.
  ///
  /// In en, this message translates to:
  /// **'Download Order\''**
  String get ordermessagedownload;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'CREATE'**
  String get create;

  /// No description provided for @modify.
  ///
  /// In en, this message translates to:
  /// **'MODIFY'**
  String get modify;

  /// No description provided for @customerinfo.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER INFO'**
  String get customerinfo;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'CODE'**
  String get code;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'ADDRESS'**
  String get address;

  /// No description provided for @phoneh.
  ///
  /// In en, this message translates to:
  /// **'PHONE'**
  String get phoneh;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'CREDIT'**
  String get credit;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'DAYS'**
  String get days;

  /// No description provided for @routeh.
  ///
  /// In en, this message translates to:
  /// **'ROUTE'**
  String get routeh;

  /// No description provided for @deliveryh.
  ///
  /// In en, this message translates to:
  /// **'DELIVERY'**
  String get deliveryh;

  /// No description provided for @typeh.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get typeh;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'TAX'**
  String get tax;

  /// No description provided for @selectdate.
  ///
  /// In en, this message translates to:
  /// **'SELECT DATE'**
  String get selectdate;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get delete;

  /// No description provided for @qtymessage01.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get qtymessage01;

  /// No description provided for @qtymessage02.
  ///
  /// In en, this message translates to:
  /// **'Max 4 digits and 2 decimals'**
  String get qtymessage02;

  /// No description provided for @pricemessage01.
  ///
  /// In en, this message translates to:
  /// **'Enter a Price'**
  String get pricemessage01;

  /// No description provided for @pricemessage02.
  ///
  /// In en, this message translates to:
  /// **'Enter a Number'**
  String get pricemessage02;

  /// No description provided for @priceenter.
  ///
  /// In en, this message translates to:
  /// **'ENTER PRICE'**
  String get priceenter;

  /// No description provided for @orderdelete01.
  ///
  /// In en, this message translates to:
  /// **'This order has only 1 item. To cancel the order, please use: '**
  String get orderdelete01;

  /// No description provided for @orderdelete02.
  ///
  /// In en, this message translates to:
  /// **'Product Deleted'**
  String get orderdelete02;

  /// No description provided for @orderdelete03.
  ///
  /// In en, this message translates to:
  /// **'Error to Update the Order'**
  String get orderdelete03;

  /// No description provided for @salesrepresentative.
  ///
  /// In en, this message translates to:
  /// **'SALES REPRESENTATIVE'**
  String get salesrepresentative;

  /// No description provided for @manager.
  ///
  /// In en, this message translates to:
  /// **'GENERAL INFO'**
  String get manager;

  /// No description provided for @commentsmessage01.
  ///
  /// In en, this message translates to:
  /// **'Cannot be empty'**
  String get commentsmessage01;

  /// No description provided for @maxlegth25.
  ///
  /// In en, this message translates to:
  /// **'Cannot exceed 25 characters'**
  String get maxlegth25;

  /// No description provided for @deleteorder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to DELETE this ORDER?'**
  String get deleteorder;

  /// No description provided for @yesdelete.
  ///
  /// In en, this message translates to:
  /// **'YES, DELETE'**
  String get yesdelete;

  /// No description provided for @messageorderdelete.
  ///
  /// In en, this message translates to:
  /// **'The ORDER has been DELETED'**
  String get messageorderdelete;

  /// No description provided for @messageorder01.
  ///
  /// In en, this message translates to:
  /// **'Order Updated'**
  String get messageorder01;

  /// No description provided for @messageorder02.
  ///
  /// In en, this message translates to:
  /// **'Error to Update Order'**
  String get messageorder02;

  /// No description provided for @messageorder03.
  ///
  /// In en, this message translates to:
  /// **'Contact to Support'**
  String get messageorder03;

  /// No description provided for @ordersrecords.
  ///
  /// In en, this message translates to:
  /// **'Orders Records'**
  String get ordersrecords;

  /// No description provided for @searchbycustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get searchbycustomer;

  /// No description provided for @searchbydate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get searchbydate;

  /// No description provided for @searchbyrepresentative.
  ///
  /// In en, this message translates to:
  /// **'Representantive'**
  String get searchbyrepresentative;

  /// No description provided for @seachbysalesrepresentative.
  ///
  /// In en, this message translates to:
  /// **'Orders by Sales Representative'**
  String get seachbysalesrepresentative;

  /// No description provided for @searchbyproduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get searchbyproduct;

  /// No description provided for @searchbyroute.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get searchbyroute;

  /// No description provided for @rsales.
  ///
  /// In en, this message translates to:
  /// **'REPRESENTATIVE'**
  String get rsales;

  /// No description provided for @gerenalorders.
  ///
  /// In en, this message translates to:
  /// **'ORDERS VIEW'**
  String get gerenalorders;

  /// No description provided for @orderdownloadmessage01.
  ///
  /// In en, this message translates to:
  /// **'Order downloaded successfully.'**
  String get orderdownloadmessage01;

  /// No description provided for @orderdownloadmessage02.
  ///
  /// In en, this message translates to:
  /// **'That date has no orders'**
  String get orderdownloadmessage02;

  /// No description provided for @orderdownloadmessage03.
  ///
  /// In en, this message translates to:
  /// **'No orders found for the requested date'**
  String get orderdownloadmessage03;

  /// No description provided for @orderdownloadmessage04.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching the data. Please try again.'**
  String get orderdownloadmessage04;

  /// No description provided for @orderdownloadmessage05.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get orderdownloadmessage05;

  /// No description provided for @orderoftheday.
  ///
  /// In en, this message translates to:
  /// **'Order of the Day'**
  String get orderoftheday;

  /// No description provided for @norodertoday.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS RECEIVED FOR TODAY'**
  String get norodertoday;

  /// No description provided for @shipmentstatus.
  ///
  /// In en, this message translates to:
  /// **'Shipment Status'**
  String get shipmentstatus;

  /// No description provided for @productcatalog.
  ///
  /// In en, this message translates to:
  /// **'Product List & Catalog'**
  String get productcatalog;

  /// No description provided for @noproductsavailable.
  ///
  /// In en, this message translates to:
  /// **'NO PRODUCTS AVAILABLE'**
  String get noproductsavailable;

  /// No description provided for @catalogproducts.
  ///
  /// In en, this message translates to:
  /// **'PRODUCT CATALOG'**
  String get catalogproducts;

  /// No description provided for @bybrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get bybrand;

  /// No description provided for @bycategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get bycategories;

  /// No description provided for @byavailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get byavailable;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'SELECT AN OPTION'**
  String get select;

  /// No description provided for @noorder.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS'**
  String get noorder;

  /// No description provided for @selectcustomermessage.
  ///
  /// In en, this message translates to:
  /// **'Please select a Customer'**
  String get selectcustomermessage;

  /// No description provided for @nocustomerorder01.
  ///
  /// In en, this message translates to:
  /// **'Customer With No Orders'**
  String get nocustomerorder01;

  /// No description provided for @nocustomerorder02.
  ///
  /// In en, this message translates to:
  /// **'The customer currently has no Orders.'**
  String get nocustomerorder02;

  /// No description provided for @nocustomerorder03.
  ///
  /// In en, this message translates to:
  /// **'Error with the Customer Order'**
  String get nocustomerorder03;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'SEARCH'**
  String get search;

  /// No description provided for @noorderscustomer.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS FOUND FOR THIS CUSTOMER'**
  String get noorderscustomer;

  /// No description provided for @selectdeliverydate.
  ///
  /// In en, this message translates to:
  /// **'Please select a Delivery Date'**
  String get selectdeliverydate;

  /// No description provided for @selectcreatedate.
  ///
  /// In en, this message translates to:
  /// **'Please select a Delivery Date'**
  String get selectcreatedate;

  /// No description provided for @noorderdate.
  ///
  /// In en, this message translates to:
  /// **'No orders were found for the selected date.'**
  String get noorderdate;

  /// No description provided for @selectasalesrepresentative.
  ///
  /// In en, this message translates to:
  /// **'Please select a Sales Representative'**
  String get selectasalesrepresentative;

  /// No description provided for @noordernysalesrepresentative.
  ///
  /// In en, this message translates to:
  /// **'Sales Representative With No Orders'**
  String get noordernysalesrepresentative;

  /// No description provided for @noordercurrentlysalesrepresentative.
  ///
  /// In en, this message translates to:
  /// **'\'The Sales Representative currently has no Orders'**
  String get noordercurrentlysalesrepresentative;

  /// No description provided for @selectproductmessage01.
  ///
  /// In en, this message translates to:
  /// **'Please select a Product'**
  String get selectproductmessage01;

  /// No description provided for @selectproductmessage02.
  ///
  /// In en, this message translates to:
  /// **'Products With No Orders'**
  String get selectproductmessage02;

  /// No description provided for @selectproductmessage03.
  ///
  /// In en, this message translates to:
  /// **'No orders were found for the selected product.'**
  String get selectproductmessage03;

  /// No description provided for @selectproductmessage04.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving product orders'**
  String get selectproductmessage04;

  /// No description provided for @noroderfoundsales.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS FOUND FOR THIS SALES REPRESENTATIVE'**
  String get noroderfoundsales;

  /// No description provided for @nororderfoundproduct.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS FOUND FOR THIS PRODUCT'**
  String get nororderfoundproduct;

  /// No description provided for @selectroute.
  ///
  /// In en, this message translates to:
  /// **'Please select a Route'**
  String get selectroute;

  /// No description provided for @selectroutemessage01.
  ///
  /// In en, this message translates to:
  /// **'Routes With No Orders'**
  String get selectroutemessage01;

  /// No description provided for @selectroutemessage02.
  ///
  /// In en, this message translates to:
  /// **'No orders were found for the selected route'**
  String get selectroutemessage02;

  /// No description provided for @selectroutemessage03.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving route orders'**
  String get selectroutemessage03;

  /// No description provided for @selectroutemessage04.
  ///
  /// In en, this message translates to:
  /// **'NO ORDERS FOUND FOR THIS ROUTE'**
  String get selectroutemessage04;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'PRODUCT'**
  String get product;

  /// No description provided for @nutricional.
  ///
  /// In en, this message translates to:
  /// **'NUTRITIONAL INFO'**
  String get nutricional;

  /// No description provided for @dataanalysis.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis'**
  String get dataanalysis;

  /// No description provided for @productsview.
  ///
  /// In en, this message translates to:
  /// **'PRODUCTS VIEW'**
  String get productsview;

  /// No description provided for @productinformation.
  ///
  /// In en, this message translates to:
  /// **'Product Information'**
  String get productinformation;

  /// No description provided for @barcode.
  ///
  /// In en, this message translates to:
  /// **'BarCode & Internal Code'**
  String get barcode;

  /// No description provided for @levelprice.
  ///
  /// In en, this message translates to:
  /// **'LEVELS PRICE'**
  String get levelprice;

  /// No description provided for @generalinformation.
  ///
  /// In en, this message translates to:
  /// **'GENEREAL INFORMATION'**
  String get generalinformation;

  /// No description provided for @listofproducts.
  ///
  /// In en, this message translates to:
  /// **'List of Products'**
  String get listofproducts;

  /// No description provided for @pdflist.
  ///
  /// In en, this message translates to:
  /// **'PDF List'**
  String get pdflist;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @imagemessage01.
  ///
  /// In en, this message translates to:
  /// **'Failed to Upload Image'**
  String get imagemessage01;

  /// No description provided for @imagemessage02.
  ///
  /// In en, this message translates to:
  /// **'Recommended Image Size:'**
  String get imagemessage02;

  /// No description provided for @imagemessage03.
  ///
  /// In en, this message translates to:
  /// **'450x450 Pixels'**
  String get imagemessage03;

  /// No description provided for @codem.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get codem;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @pricem.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get pricem;

  /// No description provided for @prices.
  ///
  /// In en, this message translates to:
  /// **'Prices'**
  String get prices;

  /// No description provided for @pricel1.
  ///
  /// In en, this message translates to:
  /// **'Price Level 01'**
  String get pricel1;

  /// No description provided for @pricel2.
  ///
  /// In en, this message translates to:
  /// **'Price Level 02'**
  String get pricel2;

  /// No description provided for @pricel3.
  ///
  /// In en, this message translates to:
  /// **'Price Level 03'**
  String get pricel3;

  /// No description provided for @pricel4.
  ///
  /// In en, this message translates to:
  /// **'Price Level 04'**
  String get pricel4;

  /// No description provided for @pricel5.
  ///
  /// In en, this message translates to:
  /// **'Price Level 05'**
  String get pricel5;

  /// No description provided for @priceex.
  ///
  /// In en, this message translates to:
  /// **'Price - e.g. 10.20'**
  String get priceex;

  /// No description provided for @pricevalidation01.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get pricevalidation01;

  /// No description provided for @pricevalidation02.
  ///
  /// In en, this message translates to:
  /// **'Invalid price format. Use . for decimals'**
  String get pricevalidation02;

  /// No description provided for @pricevalidation03.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get pricevalidation03;

  /// No description provided for @descriptionm.
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION'**
  String get descriptionm;

  /// No description provided for @descriptionmessage01.
  ///
  /// In en, this message translates to:
  /// **'Description is Required'**
  String get descriptionmessage01;

  /// No description provided for @descriptionmessage02.
  ///
  /// In en, this message translates to:
  /// **'Description cannot be more than 40 characters'**
  String get descriptionmessage02;

  /// No description provided for @stockm.
  ///
  /// In en, this message translates to:
  /// **'STOCK'**
  String get stockm;

  /// No description provided for @stockd.
  ///
  /// In en, this message translates to:
  /// **'STOCK - (Accept up to 4 decimals) e.g. 10.1234'**
  String get stockd;

  /// No description provided for @stockmessage01.
  ///
  /// In en, this message translates to:
  /// **'STOCK IS REQUIRED'**
  String get stockmessage01;

  /// No description provided for @stockmessage02.
  ///
  /// In en, this message translates to:
  /// **'INVALID STOCK FORMAT (Only Numbers) Use . / Max 4 Decimals\''**
  String get stockmessage02;

  /// No description provided for @unitm.
  ///
  /// In en, this message translates to:
  /// **'UNIT'**
  String get unitm;

  /// No description provided for @unitmessage01.
  ///
  /// In en, this message translates to:
  /// **'UNIT IS REQUIRED'**
  String get unitmessage01;

  /// No description provided for @categorym.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get categorym;

  /// No description provided for @selectcategory.
  ///
  /// In en, this message translates to:
  /// **'SELECT A CATEGORY'**
  String get selectcategory;

  /// No description provided for @taxm.
  ///
  /// In en, this message translates to:
  /// **'TAX'**
  String get taxm;

  /// No description provided for @taxmessage01.
  ///
  /// In en, this message translates to:
  /// **'SELECT A TAX'**
  String get taxmessage01;

  /// No description provided for @taxmessage02.
  ///
  /// In en, this message translates to:
  /// **'Select a Tax'**
  String get taxmessage02;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @editm.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editm;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get update;

  /// No description provided for @productmessage01.
  ///
  /// In en, this message translates to:
  /// **'COULD NOT SAVE THE PRODUCT'**
  String get productmessage01;

  /// No description provided for @fieldrequest.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldrequest;

  /// No description provided for @maxlegth14.
  ///
  /// In en, this message translates to:
  /// **'The code cannot have more than 14 characters'**
  String get maxlegth14;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'CREATED'**
  String get created;

  /// No description provided for @categorys.
  ///
  /// In en, this message translates to:
  /// **'CATEGORIES'**
  String get categorys;

  /// No description provided for @createcaterory.
  ///
  /// In en, this message translates to:
  /// **'Create a Category'**
  String get createcaterory;

  /// No description provided for @createby.
  ///
  /// In en, this message translates to:
  /// **'Create by'**
  String get createby;

  /// No description provided for @customerm.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER'**
  String get customerm;

  /// No description provided for @legalname.
  ///
  /// In en, this message translates to:
  /// **'Legal Name'**
  String get legalname;

  /// No description provided for @branchm.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get branchm;

  /// No description provided for @zonem.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zonem;

  /// No description provided for @contacinfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contacinfo;

  /// No description provided for @creditsales.
  ///
  /// In en, this message translates to:
  /// **'CREDIT & SALES DATA'**
  String get creditsales;

  /// No description provided for @conditionsales.
  ///
  /// In en, this message translates to:
  /// **'Conditions Sales'**
  String get conditionsales;

  /// No description provided for @creditinfo.
  ///
  /// In en, this message translates to:
  /// **'Credit (Days) & Cash'**
  String get creditinfo;

  /// No description provided for @zonename.
  ///
  /// In en, this message translates to:
  /// **'Zone Name'**
  String get zonename;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'WebSite'**
  String get website;

  /// No description provided for @requiredcredit.
  ///
  /// In en, this message translates to:
  /// **'Credit is Required'**
  String get requiredcredit;

  /// No description provided for @onlynumbers.
  ///
  /// In en, this message translates to:
  /// **'Only numbers are allowed'**
  String get onlynumbers;

  /// No description provided for @maxlegth3.
  ///
  /// In en, this message translates to:
  /// **'Max 3 characters'**
  String get maxlegth3;

  /// No description provided for @selectzone.
  ///
  /// In en, this message translates to:
  /// **'Select a Zone'**
  String get selectzone;

  /// No description provided for @requiredmanager.
  ///
  /// In en, this message translates to:
  /// **'Manager is Required'**
  String get requiredmanager;

  /// No description provided for @maxlegth20.
  ///
  /// In en, this message translates to:
  /// **'Max 20 characters'**
  String get maxlegth20;

  /// No description provided for @requiredphone.
  ///
  /// In en, this message translates to:
  /// **'Phone is Required'**
  String get requiredphone;

  /// No description provided for @phonemessage01.
  ///
  /// In en, this message translates to:
  /// **'Only numbers and a leading + are allowed (No space allowed)'**
  String get phonemessage01;

  /// No description provided for @emailnotvalid.
  ///
  /// In en, this message translates to:
  /// **'Email not Valid'**
  String get emailnotvalid;

  /// No description provided for @requiredwebsite.
  ///
  /// In en, this message translates to:
  /// **'WebSite is Required'**
  String get requiredwebsite;

  /// No description provided for @maxlegth40.
  ///
  /// In en, this message translates to:
  /// **'Max 40 characters'**
  String get maxlegth40;

  /// No description provided for @updatecustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer Updated'**
  String get updatecustomer;

  /// No description provided for @errorupdatecustomer.
  ///
  /// In en, this message translates to:
  /// **'Error to Update the Customer'**
  String get errorupdatecustomer;

  /// No description provided for @requiredtaxid.
  ///
  /// In en, this message translates to:
  /// **'TAX ID is Required'**
  String get requiredtaxid;

  /// No description provided for @minlegth3.
  ///
  /// In en, this message translates to:
  /// **'Min 3 characters'**
  String get minlegth3;

  /// No description provided for @requiredbussinessname.
  ///
  /// In en, this message translates to:
  /// **'Bussiness Name is Required'**
  String get requiredbussinessname;

  /// No description provided for @maxlegth17.
  ///
  /// In en, this message translates to:
  /// **'Max 17 characters'**
  String get maxlegth17;

  /// No description provided for @max90legth.
  ///
  /// In en, this message translates to:
  /// **'Max 90 characters'**
  String get max90legth;

  /// No description provided for @requiredaddress.
  ///
  /// In en, this message translates to:
  /// **'Address is Required'**
  String get requiredaddress;

  /// No description provided for @max179legth.
  ///
  /// In en, this message translates to:
  /// **'Max 179 characters'**
  String get max179legth;

  /// No description provided for @requirednote.
  ///
  /// In en, this message translates to:
  /// **'Note is Required'**
  String get requirednote;

  /// No description provided for @requiredcode.
  ///
  /// In en, this message translates to:
  /// **'Code Required'**
  String get requiredcode;

  /// No description provided for @taxid.
  ///
  /// In en, this message translates to:
  /// **'TAX ID'**
  String get taxid;

  /// No description provided for @bussinessname.
  ///
  /// In en, this message translates to:
  /// **'Bussiness Name'**
  String get bussinessname;

  /// No description provided for @aditionalinformation.
  ///
  /// In en, this message translates to:
  /// **'Aditional Information'**
  String get aditionalinformation;

  /// No description provided for @addlocation.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get addlocation;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @bussinesssettings.
  ///
  /// In en, this message translates to:
  /// **'Bussiness Settings'**
  String get bussinesssettings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @accountsettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountsettings;

  /// No description provided for @financesettings.
  ///
  /// In en, this message translates to:
  /// **'Finance Settings'**
  String get financesettings;

  /// No description provided for @banksaccount.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get banksaccount;

  /// No description provided for @generalsettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalsettings;

  /// No description provided for @inactiveusers.
  ///
  /// In en, this message translates to:
  /// **'Inactive '**
  String get inactiveusers;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

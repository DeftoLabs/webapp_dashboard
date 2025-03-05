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

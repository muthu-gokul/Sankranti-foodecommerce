
import 'package:flutter/material.dart';


class AppStateNotifier extends ChangeNotifier {
  //
  bool isDarkModeOn = false;
  Color appBarColor=Color(0xFF131314);
  Color appBarColor2=Color(0xFFAA2324);
  Color tabBarColor=Color(0xFF131314);
  Color tabTextColor=Color(0xFFffffff);
  Color tabSelectTextColor=Color(0xFFffffff);

  Color mainCateBgColor=Color(0xFF1F2023);
  Color mainCateSelectedColor=Color(0xFF131314);
  Color mainCateTextSelectedColor=Color(0xFFE34343);
  Color mainCateUnSelectedColor=Color(0xFFE34343);

  Color f5e5e60Color=Color(0xFF5E5E60);
  Color searchIconColor=Color(0xFFFFFFFF);

  Color secondaryBgColor=Color(0xFF2B2B30);

  Color subCateStrokeColor=Color(0xFF5E5E60);
  Color subCateSelectedColor=Color(0xFFE34343);
  Color subCateUnSelectedColor=Color(0xFF1F2023);
  Color subCateUnSelectedTextColor=Color(0xFFFFFFFF);



  Color billingBgColor=Color(0xFF5E5E60);
  Color billingItemStrokeColor=Color(0xFF444448);
  Color billingSelectColor=Color(0xFF2B2B30);
  Color billingIconColor=Color(0xFFFFFFFF);
  Color billingTextColor=Color(0xFFFFFFFF);
  Color billingCalculatedPriceColor=Color(0xFF9C9C9C);
  Color billingBlinkColor=Color(0xFF8D8D8D);

  Color addNewBgColor=Color(0xFFE34343);
  Color billHistoryGrid=Color(0xFFEAE8F0);


  Color itemBgColor=Color(0xFF5E5E60);
  Color itemTextColor=Color(0xFFFFFFFF);

  Color scrollGlowColor=Color(0xFF444448).withOpacity(0.1);

  Color keyBoardbg=Color(0xFF47474A);
  Color keyBoardtextColor=Color(0xFFFFFFFF);

  Color CustomerDetailsAppbar=Color(0xFF131314);
  Color CustomerDetailsleftBg=Color(0xFFe9f3fc);
  Color CustomerDetailsrighttBg=Color(0xFF2B2B30);
  Color CustomerDetailsplaceHolder=Color(0xFF959595);
  Color CustomerDetailsTextColor=Color(0xFF363636);
  Color CustomerDetailsTextColor2=Color(0xFF242424);
  Color CustomerDetailsTextColor3=Color(0xFF989898);
  Color CustomerDetailsListContent=Color(0xFFe9f3fc);



  //.bill split(bs) textEditing controller
  Color bstextformColor=Color(0xFF454448);

  // Color appBarColor=Color(0xFF2B2B30);
  //Online Orders
  Color cancelBtnBg=Color(0xFF2B2B30);
  Color bodyColor=Color(0xFF3B3B3D);
  Color newOrderBgColor=Color(0xFF2B2B30).withOpacity(0.5);
  Color newOrderPopUpBgColor= Color(0xFF3b3b3d);
  Color newOrderTotalItemsColor=Colors.white;
  Color approveOrdersBgColor=Colors.transparent;

  //PayScreen(ps)
  Color psSideNavColor=Color(0xFF131314);
  Color psExemptionColor=Color(0xFF131314);
  Color psBgColor=Color(0xFF2C2B30);
  Color psNumPadColor=Color(0xFF5E5E60);
  Color psCashCardColor=Color(0xFFE34343);
  Color psNumPadText=Color(0xFF464646);

  //Settings

  Color setTextColor=Color(0xffC5C4C9);
  Color setActiveColor=Color(0xFFE34343);
  Color setDividerColor=Color(0xff16151B);
  Color setSubBgColor=Color(0xff131315);



  //DashBoard(dash)

  Color dashColor1=Color(0xFF131314);
  Color dashRedColor=Color(0xFFE6463D);
  Color dashGreyColor=Color(0xFF7A7C7D);


  BoxDecoration addNewIconShadow=BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFE34343),
      boxShadow: [
        BoxShadow(
            color:Color(0xFFE34343).withOpacity(0.7),
            offset: const Offset(0, 9.0),
            blurRadius: 25.0,
            spreadRadius: 1
        ),
      ]
  );


  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;

    appBarColor=isDarkModeOn?Color(0xFF131314):Color(0xFFff0022);
    tabBarColor=isDarkModeOn?Color(0xFF131314):Color(0xFFe0e4e8);
    tabTextColor=isDarkModeOn?Color(0xFF131314):Color(0xFF6c6c6c);
    tabSelectTextColor=isDarkModeOn?Color(0xFF131314):Color(0xFFffffff);

    dashColor1=isDarkModeOn?Color(0xFF131314):Color(0xFFffffff);
    dashRedColor=isDarkModeOn?Color(0xFFE6463D):Color(0xFFff0022);

    mainCateBgColor=isDarkModeOn?Color(0xFF1F2023):Color(0xFF1AC591);
    mainCateSelectedColor=isDarkModeOn?Color(0xFF131314):Color(0xFFff0022).withOpacity(0.05);
    mainCateUnSelectedColor=isDarkModeOn?Color(0xFFE34343):Color(0xFFffffff);
    mainCateTextSelectedColor=isDarkModeOn?Color(0xFFE34343):Color(0xFFff0022);
    addNewBgColor=isDarkModeOn?Color(0xFFE34343):Color(0xFF1AC591);
    addNewIconShadow=isDarkModeOn?BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE34343),
        boxShadow: [
          BoxShadow(
              color:Color(0xFFE34343).withOpacity(0.7),
              offset: const Offset(0, 9.0),
              blurRadius: 25.0,
              spreadRadius: 1
          ),
        ]
    ):BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFff0022),
        boxShadow: [
          BoxShadow(
              color:Color(0xFFff0022).withOpacity(0.5),
              offset: const Offset(5, 9.0),
              blurRadius: 17.0,
              spreadRadius: 1
          ),
        ]
    );
    // mainCateTextSelectedColor=isDarkModeOn?Color( 0xFFDB2B2B):Color(0xFF1AC591);

    // mainCateUnSelectedColor=isDarkModeOn?Color( 0xFFDB2B2B):Color(0xFF0A9A6E);
    //  0xFFDB2B2B
    f5e5e60Color=isDarkModeOn?Color(0xFF5E5E60):Color(0xFFFFFFFF);

    searchIconColor=isDarkModeOn?Color(0xFFFFFFFF):Color(0xFFFFFFFF);

    secondaryBgColor=isDarkModeOn?Color(0xFF2B2B30):Color(0xFFf2f3f7);

    subCateStrokeColor=isDarkModeOn?Color(0xFF5E5E60):Color(0xFF0A9A6E);
    subCateSelectedColor=isDarkModeOn?Color(0xFFE34343):Color(0xFFff0022);
    subCateUnSelectedColor=isDarkModeOn?Color(0xFF1F2023):Color(0xFFe0e4e8);
    subCateUnSelectedTextColor=isDarkModeOn?Color(0xFFFFFFFF):Color(0xFF056E4E);

    billingBgColor=isDarkModeOn?Color(0xFF5E5E60):Color(0xFFFFFFFF);
    billingItemStrokeColor=isDarkModeOn?Color(0xFF444448):Color(0xFFEDEDED);
    bstextformColor=isDarkModeOn?Color(0xFF454448):Color(0xFFEDEDED);
    scrollGlowColor=isDarkModeOn?Color(0xFF444448).withOpacity(0.1):Color(0xFFEDEDED);
    billingBlinkColor=isDarkModeOn?Color(0xFF8D8D8D):Color(0xFFF3F3F3);
    billingSelectColor=isDarkModeOn?Color(0xFF2B2B30):Color(0xFFF3F3F3);
    billingIconColor=isDarkModeOn?Color(0xFFFFFFFF):Color(0xFFF3F3F3);
    billingTextColor=isDarkModeOn?Color(0xFFFFFFFF):Color(0xFF242424);

    itemBgColor=isDarkModeOn?Color(0xFF5E5E60):Color(0xFFFFFFFF);
    itemTextColor=isDarkModeOn?Color(0xFFFFFFFF):Color(0xFF000000);

    keyBoardbg=isDarkModeOn?Color(0xFF47474A):Color(0xFFCFCFCF);
    keyBoardtextColor=isDarkModeOn?Color(0xFFFFFFFF):Color(0xFF1F2023);

    //Online Orders
    bodyColor=isDarkModeOn?Color(0xFF3B3B3D):Color(0xFFFFFFFF);
    newOrderBgColor=isDarkModeOn?Color(0xFF2B2B30).withOpacity(0.3):Color(0xFFF2F9FF);
    newOrderPopUpBgColor=isDarkModeOn? Color(0xFF3b3b3d):Color(0xFFF2F9FF);
    newOrderTotalItemsColor=isDarkModeOn?Colors.white:Color(0xFF1F2024);
    cancelBtnBg=isDarkModeOn?Color(0xFF2B2B30):Color(0xFF323135);
    approveOrdersBgColor=isDarkModeOn?Colors.transparent:Color(0xFFE9F4FF);


    //PayScreen
    psSideNavColor=isDarkModeOn?Color(0xFF131314):Color(0xFF0A9A6E);
    psExemptionColor=isDarkModeOn?Color(0xFF131314):Color(0xFFACACAC);
    psBgColor=isDarkModeOn?Color(0xFF2C2B30):Color(0xFFf1f0f3);
    psNumPadColor=isDarkModeOn?Color(0xFF5E5E60):Color(0xFFE0E3E7);
    psCashCardColor=isDarkModeOn?Color(0xFFE34343):Color(0xFFff0022);


    //Customer Details
    CustomerDetailsAppbar=isDarkModeOn?Color(0xFF131314):Color(0xFFff0022);
    CustomerDetailsleftBg=isDarkModeOn?Color(0xFF5E5E60):Color(0xFFFFFFFF);
    CustomerDetailsrighttBg=isDarkModeOn?Color(0xFF2B2B30):Color(0xFFf1f0f3);

    //Settings
    setTextColor=isDarkModeOn?Color(0xffC5C4C9):Color(0xFF646466);
    setDividerColor=isDarkModeOn?Color(0xff16151B):Color(0xFFCFCFCF);
    setSubBgColor=isDarkModeOn?Color(0xff131315):Color(0xFFFFFFFF);
    setActiveColor=isDarkModeOn?Color(0xFFE34343):Color(0xFFff0022);




    notifyListeners();
  }

// final Connectivity _connectivity =new Connectivity();

//  StreamSubscription<ConnectivityResult> _connectionSubscription= _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {

//});


}
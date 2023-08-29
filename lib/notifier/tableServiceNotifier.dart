import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../models/waiter_model.dart';


class TableServiceModelTables{
  String? tableNo;
  String? noOfSeats;
  String? floor;
  int? status;
  GlobalKey? key;
  TableServiceModelTables({this.tableNo,this.noOfSeats,this.floor,this.status,this.key});
}



class TableServiceNotifier extends ChangeNotifier{
  bool isAllClicked=true;//AC
  bool isKoTSendClicked=false;//KSC
  bool isKoTNotSendClicked=false;//KNSC
  bool isNewOrderClicked=false;//NOC

  void changeACtrue(){
    isAllClicked=true;
    notifyListeners();
  }
  void changeACfalse(){
    isAllClicked=false;
    notifyListeners();
  }

  void changeKSCtrue(){
    isKoTSendClicked=true;
    notifyListeners();
  }
  void changeKSCfalse(){
    isKoTSendClicked=false;
    notifyListeners();
  }

  void changeKNSCtrue(){
    isKoTNotSendClicked=true;
    notifyListeners();
  }
  void changeKNSCfalse(){
    isKoTNotSendClicked=false;
    notifyListeners();
  }

  void changeNOCtrue(){
    isNewOrderClicked=true;
    notifyListeners();
  }
  void changeNOCfalse(){
    isNewOrderClicked=false;
    notifyListeners();
  }







  /* FLOOR PAGEVIEW
  * 0-free
  * 1-fill
  * 2-reserved
  * 3-waiting for bill
  * */
  int floorPageIndex=0;
  PageController floorPageController=new PageController();

  List<String> floors=["All","First Floor","Second Floor","Third Floor","A/C Hall","A/C Hall 2","A/C Hall 3"];
  List<TableServiceModelTables> filteredList=[];
  List<TableServiceModelTables> floorlist=[

    TableServiceModelTables(tableNo: "1",noOfSeats: "4",status: 0,floor: 'First Floor',key: GlobalKey()),
     TableServiceModelTables(tableNo: "2",noOfSeats: "4",status: 1,floor: 'First Floor',key: GlobalKey()),
     TableServiceModelTables(tableNo: "3",noOfSeats: "6",status: 2,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "4",noOfSeats: "6",status: 3,floor: 'First Floor',key: GlobalKey()),
     TableServiceModelTables(tableNo: "5",noOfSeats: "2",status: 2,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "6",noOfSeats: "4",status: 2,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "7",noOfSeats: "4",status: 2,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "8",noOfSeats: "6",status: 0,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "9",noOfSeats: "2",status: 0,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "10",noOfSeats: "6",status: 2,floor: 'First Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "11",noOfSeats: "4",status: 2,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "12",noOfSeats: "6",status: 1,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "13",noOfSeats: "2",status: 2,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "14",noOfSeats: "4",status: 1,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "15",noOfSeats: "6",status: 2,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "16",noOfSeats: "2",status: 1,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "17",noOfSeats: "6",status: 3,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "18",noOfSeats: "2",status: 0,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "19",noOfSeats: "6",status: 2,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "2",status: 2,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "6",status: 1,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "6",status: 0,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "4",status: 2,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "6",status: 3,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "13",noOfSeats: "2",status: 2,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "14",noOfSeats: "4",status: 1,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "15",noOfSeats: "6",status: 2,floor: 'Second Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "16",noOfSeats: "2",status: 1,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "17",noOfSeats: "6",status: 3,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "18",noOfSeats: "2",status: 0,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "19",noOfSeats: "6",status: 2,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "2",status: 2,floor: 'Third Floor',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "6",status: 1,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "6",status: 0,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "4",status: 2,floor: 'A/C Hall',key: GlobalKey()),
    TableServiceModelTables(tableNo: "20",noOfSeats: "6",status: 3,floor: 'A/C Hall',key: GlobalKey()),
  ];


  void filterAll(){
    floorPageIndex=0;
    filteredList=floorlist;
    notifyListeners();
  }
  void filter(String floor){
    filteredList=floorlist.where((element) => element.floor!.contains(floor)).toList();
    notifyListeners();
  }
  void floorPageViewController(int index){
    this.floorPageIndex=index;
    this.floorPageController.animateToPage(index,duration: Duration(milliseconds: 300),curve: Curves.ease).then((value) {
      if(floorPageIndex!=0){
        filter(floors[floorPageIndex]);

      }else{
        filterAll();
      }

    });

    notifyListeners();
  }


  /* ADD NEW TABLE */
  bool isLongPress=false;
  double? dx,dy;

  void changeLongPresstrue(){
    isLongPress=true;
    notifyListeners();
  }
  void changeLongPressfalse(){
    isLongPress=false;
    notifyListeners();
  }

  void updateDxDy(double x,double y){
    dx=x;
    dy=y;
    notifyListeners();
  }




/* TABLE CLICK EVENT  */

int? tableSelected;
bool isNoGuestPopUpOpen=false;

List<String> noGuestsNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "C", "0", "X"];
int? noGuestSelected;
int guestIndex=0;
String noOfGuests="";
List<String> currentGuests = ["", "", ""];

bool isSingleDigit=true;
bool isBlur=false;

void updateTableSelected(int index){
  tableSelected=index;
  notifyListeners();
}

void updateNoGuestPopUpOpen(){
  isNoGuestPopUpOpen=!isNoGuestPopUpOpen;
  notifyListeners();
}

void updateNoGuestSelected(int index){
  noGuestSelected=index;
  notifyListeners();
}

void updateSingleDigit(){
    isSingleDigit=!isSingleDigit;
    notifyListeners();
}

void updateBlur(){
  isBlur=!isBlur;
  notifyListeners();
}


  pinIndexSetup(String text) {
    if (guestIndex == 0) {
      guestIndex = 1;
      notifyListeners();
    } else if (guestIndex < 3) {
      guestIndex++;
      notifyListeners();
    }

    currentGuests[guestIndex - 1] = text;
    noOfGuests = "";
    currentGuests.forEach((element) {
      noOfGuests += element;
    });
    notifyListeners();
  }

  clearPin() {
    if (guestIndex == 0) {
      guestIndex = 0;
      notifyListeners();
    } else {

      currentGuests[guestIndex - 1] = "";
      guestIndex--;
      noOfGuests="";
      currentGuests.forEach((element) {
        noOfGuests += element;
      });
      notifyListeners();
    }
  }







/* WAITER POPUP  */

bool isWaiterPopUpOpen=false;

void changeWaiterPopupOpen(){
  isWaiterPopUpOpen=!isWaiterPopUpOpen;
  notifyListeners();
}


List<WaiterModel> waitersList=[
  WaiterModel(waiterName: "Akash",waiterId: "1243"),
  WaiterModel(waiterName: "Arun",waiterId: "2344"),
  WaiterModel(waiterName: "Ashwin",waiterId: "2344"),
  WaiterModel(waiterName: "Balaji",waiterId: "644"),
  WaiterModel(waiterName: "Babu",waiterId: "765"),
];
List<WaiterModel> filterWaitersList=[];

void initializeWaiterList(){
  filterWaitersList=waitersList;
  print(inspect(filterWaitersList));
  notifyListeners();
}


void filterWaiterListFunc(String name){
  filterWaitersList=waitersList.where((element) => element.waiterName!.toLowerCase().contains(name.toLowerCase()) || element.waiterId!.contains(name)
  ).toList();
  notifyListeners();
}

}
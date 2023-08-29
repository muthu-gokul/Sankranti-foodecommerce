import 'dart:async';

import 'package:flutter/cupertino.dart';

class BranchSelectNotifier extends ChangeNotifier{
  bool isBranchClick=false;
  bool isHallClick=false;

  bool branchReload=false;
  bool hallReload=false;

  void changeBranchClick(){
    isBranchClick=!isBranchClick;
    notifyListeners();
  }

  void changeHallClick(){
    isHallClick=!isHallClick;
    notifyListeners();
  }

  void branchReloadTrue(){
    branchReload=true;
    notifyListeners();
  }

  void hallReloadTrue(){
    hallReload=true;
    notifyListeners();
  }

  List<String> floorlist = ["Ground Floor", "First Floor", "Second Floor","A/C Hall 1", "A/C Hall 2", "A/C Hall 3"];
  String selectedFloor="Select Hall";

  List<String> branchlist = ["Adayar", "Aavadi", "Porur","VyasarBadi","Vadapalani","Ramapuram","MaduraVayal","Thiruverkadu"];
  String selectedBranch="Select Branch";

  void selectedBranchFunc(int index){
    selectedBranch=branchlist[index];
    Timer(Duration(milliseconds: 300), (){
      branchReload=false;
      notifyListeners();
    });
    notifyListeners();
  }

  void selectedHallFunc(int index){
    selectedFloor=floorlist[index];
    Timer(Duration(milliseconds: 300), (){
      hallReload=false;
      notifyListeners();
    });
    notifyListeners();
  }

}
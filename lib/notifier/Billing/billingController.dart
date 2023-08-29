import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/getBillingOutletModels.dart';
import '../../styles/constants.dart';
import '../utils.dart';
import 'configuration.dart';
import 'settings/intervalCallManager.dart';


RxList<UserTable> filteruser=<UserTable>[].obs;
RxList<OrderType> orderTypeList=<OrderType>[].obs;
RxList<OutletFloor> filteroutletFloor=<OutletFloor>[].obs;
List<UserOutlet>? filteruserOutlet;
List<TablesFloor>? filtertablesFloor;
RxList<MenuList> filtermenu=<MenuList>[].obs;
RxList<MainCategoryTable4> filtermainCategory=<MainCategoryTable4>[].obs;
RxList<SubCategory> filtersubCategory=<SubCategory>[].obs;
RxList<SubCategory> filterInnersubCategory=<SubCategory>[].obs;
List<SubCategory> tempInnersubCategory=[];

List<Captain>? filtercaptain;
List<Waiter>? filterwaiter;
List<OrderType>? filterorderType;


RxList<dynamic> filterproduct=<dynamic>[].obs;
RxList<dynamic> filterModifiers=<dynamic>[].obs;
RxList<dynamic> outletFloorList=<dynamic>[].obs;
// List<dynamic>? filterproduct;
List<ProductDetails> orders=[];


List<dynamic>? filterkitchenComments=[];
List<dynamic>? filterAddons=[];
List<dynamic>? filterPaymentType=[];

var currentDate="".obs,errorCodePrefix="".obs, dbCurrentDate="".obs,outletShiftStartTime="".obs,errorMsg="".obs, startDate="".obs;
var dayCloseTime=DateTime.parse("${DateFormat(dbDateFormat).format(DateTime.now())} 23:59:59").obs;
class BillingController extends GetxController{


  late ProductDetailMaster productDetail;
  void fetchOutletDetails(var parsed){

    productDetail=ProductDetailMaster.fromJson(parsed);
    filteruser.value=productDetail.userTable!;
    filteruserOutlet=productDetail.userOutlet;
    filteroutletFloor.value=productDetail.outletFloor??[];
    outletFloorList.value=productDetail.outletFloor??[];
    filtertablesFloor=productDetail.tablesFloor;
    filtermenu.value=productDetail.menuList??[];
    filtercaptain=productDetail.captain;
    filterwaiter=productDetail.waiter;
    filtersubCategory.value=productDetail.subCategory??[];
    filterproduct.value=productDetail.productList??[];
    filterkitchenComments=productDetail.kitchenComments;
    filterAddons=productDetail.addons;
    filterPaymentType=productDetail.paymentType;






    if(parsed["Table15"].isNotEmpty){
      errorCodePrefix.value=parsed["Table15"][0]['ErrorPrefix'];
      errorMsg.value=parsed["Table15"][0]['ShowMessage'];

    }



    if(parsed["Table18"].isNotEmpty){
      var l=parsed["Table18"] as List;

      if(l[0]['BillDate']!=null){
        //currentDate.value=DateFormat("dd-MM-yyyy").format(DateTime.parse(l[0]['BillDate']));
        currentDate.value=l[0]['BillDate'];
        dbCurrentDate.value=l[0]['DBDate'];
       /* currentDate2=l[0]['BillDate'];
        dbCurrentDate2=l[0]['DBDate'];*/
        outletShiftStartTime.value=l[0]['OutletShiftStartTime'];

        try{
          dayCloseTime.value=DateTime.parse("${l[0]['OutletShiftEndTime']}");
        }catch(e){}
      }
      else{
        currentDate.value=DateFormat("dd-MMM-yyyy").format(DateTime.now());
        dbCurrentDate.value=DateFormat("yyyy-MM-dd").format(DateTime.now());
        outletShiftStartTime.value=DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      /*  currentDate2=DateFormat("dd-MM-yyyy").format(DateTime.now());
        dbCurrentDate2=DateFormat("yyyy-MM-dd").format(DateTime.now());
*/
      }

    }
    else{
      currentDate.value=DateFormat("dd-MM-yyyy").format(DateTime.now());
      dbCurrentDate.value=DateFormat("yyyy-MM-dd").format(DateTime.now());
      /*currentDate2=DateFormat("dd-MM-yyyy").format(DateTime.now());
      dbCurrentDate2=DateFormat("yyyy-MM-dd").format(DateTime.now());*/

      outletShiftStartTime.value=DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      dayCloseTime.value=DateTime.parse("$dbCurrentDate 23:59:59");
    }
    if(isHasBillSettingsAccess(featuresAccessId['AutoDayClose'])){
      intervalCallInit(needTimer: true);
    }

    /*    updateMenu(0);
        updateFloorSelectedIndex(floorSelected);
        updateIcon(iconSelected);
        updateisSettlementButtonClick(false);*/

  }



  //Online Internet Check
  var ISOnline=true.obs;

}




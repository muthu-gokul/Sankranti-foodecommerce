import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodecommerce/widgets/customTextField.dart';
import 'package:foodecommerce/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../models/parameterMode.dart';
import '../../notifier/themeNotifier.dart';
import '../../notifier/utils.dart';
import '../../notifier/utils/apiUtils.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customNetworkImg.dart';
import '../loginpage/login.dart';
import 'myProfileEdit.dart';
RxMap profileDetail=RxMap();
class ViewProfile extends StatefulWidget {
  // VoidCallback voidCallback;
  // ViewProfile({required this.voidCallback});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  late double width, height, width2, height2;

  RxBool isLoading=RxBool(false);

  customerDetail phoneNumber=customerDetail(Detials: '${profileDetail['CustomerContactNumber']}', Img: 'assets/images/landingPage/call.png', Title: 'Phone Number',regEx: MyConstants.digitRegEx,onUpdate: (e){},);
  customerDetail email=customerDetail(Detials: '${profileDetail['CustomerEmail']}', Img: 'assets/images/landingPage/mail.png', Title: 'Email',regEx: MyConstants.emailRegEx,onUpdate: (e){},);
  customerDetail name=customerDetail(Detials: '${profileDetail['CustomerName']}', Img: 'assets/images/landingPage/translate.png', Title: 'Name',regEx: MyConstants.alphaSpaceRegEx,onUpdate: (e){},);

  @override
  void initState() {
    phoneNumber.onUpdate=(v){
      profileDetail['CustomerContactNumber']=v;
      updateProfile();
    };
    email.onUpdate=(v){
      profileDetail['CustomerEmail']=v;
      updateProfile();
    };
    name.onUpdate=(v){
      profileDetail['CustomerName']=v;
      updateProfile();
    };
    getProfileDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    width2 = width - 16;
    height2 = height - 16;
    return SafeArea(
        child:Scaffold(
        backgroundColor: ColorUtil.themeColorBg,
          body: Stack(
            children: [
              Container(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: ColorUtil.themeColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: [
                            Container(
                                height: 120,
                                width: 120,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.white, shape: BoxShape.circle),
                                child: Stack(
                                  children: [
                                    Obx(() => Container(
                                        height: 120,
                                        width: 120,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: profileDetail.isEmpty || isLoading.value? Image.asset("assets/images/landingPage/avatar-01.jpg"):
                                        CustomNetworkImg(
                                          dbFilePath: profileDetail['CustomerImage'],
                                          directoryPath: MyConstants.imgPath,
                                          height: 120,
                                          loaderHeight: 120,
                                          loaderWidth: 120,
                                          errorImage: "assets/images/landingPage/avatar-01.jpg",
                                          baseUrl: GetBaseUrl() +'/AppAttachments/',
                                          fit: BoxFit.cover,
                                        )
                                    )),
                                    Positioned(
                                      bottom: 0,right: 0,
                                      child: GestureDetector(
                                        onTap: () async{
                                          XFile? temp=await (ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40,));
                                          if(temp==null)return;
                                          File tempImage = File(temp.path);
                                          isLoading.value=true;
                                          String pat=await MyHelper.uploadFile('Customer', tempImage);
                                          print("pat $pat");
                                          profileDetail['CustomerImage']='Customer/$pat';
                                          isLoading.value=false;
                                          updateProfile();
                                        },
                                        child: Container(
                                          height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.grey)
                                            ),
                                            child: Icon(Icons.edit,size: 18,)
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() => Text(
                                  '${profileDetail['CustomerName']??""}',
                                  style: TextStyle(
                                      fontFamily: 'RB',
                                      fontSize: 18,
                                      color: ColorUtil.themeColor,
                                      letterSpacing: 0.1),
                                ),),
                                const SizedBox(height: 10,),
                                Container(
                                  width: SizeConfig.screenWidth! * 0.20,
                                  height: 0,
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorUtil.themeColor,
                                      borderRadius: BorderRadius.circular(25)
                                    // shape: BoxShape.circle
                                  ),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontFamily: 'RM',
                                        fontSize: 16,
                                        color: ColorUtil.primaryColor,
                                        letterSpacing: 0.1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox( height: 35, ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: const EdgeInsets.fromLTRB(10,10,10,0),
                        padding: const EdgeInsets.fromLTRB(15,20,15,20),
                        decoration: BoxDecoration(
                          color:ColorUtil.thWhite,
                          border: Border.all(color: const Color(0XFFE4E4E4)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 0,
                        child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    child: Image.asset('assets/images/landingPage/addressicon.png',fit:BoxFit.contain,width: 25,)),
                                const SizedBox(width: 20,),
                                const Text(
                                  'Delivery Address',
                                  style: TextStyle(
                                      fontFamily: 'RB',
                                      fontSize: 16,
                                      color: Colors.black,
                                      letterSpacing: 0.1),
                                ),
                                const Spacer(),
                                GestureDetector(
                                onTap: (){
                                  Get.to(MyProfileEdit());
                                },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontFamily: 'RB',
                                        fontSize: 16,
                                        color: ColorUtil.primaryColor,
                                        letterSpacing: 0.1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Text(
                              'No:14, NP Developed Plots, TVK Industrial Estate, Ekkattuthangal Chennai-600032',
                              style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 16,
                                  color: ColorUtil.thBlack),
                            )
                          ],
                        ),
                      ),
                      //Obx(() => CustomerDetail('assets/images/landingPage/translate.png', 'Date of Birth', '${profileDetail['CustomerDOB']}', 'Change'),),
                      name,
                      phoneNumber,
                      email,

                      const SizedBox( height: 35, ),
                      Align(
                      alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: (){
                            clearSession();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>loginPage()));
                          },
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.5,
                            height: 60,
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorUtil.themeColor,
                                borderRadius: BorderRadius.circular(25)
                              // shape: BoxShape.circle
                            ),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 18,
                                  color: ColorUtil.primaryColor,
                                  letterSpacing: 0.1),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )),
              Obx(() => Loader(value: isLoading.value,))
            ],
          ),
        ),);
  }

  void updateProfile()async{
    isLoading.value=true;
    params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName",Value: Sp.updateProfileDetail,Type: "string"));
    profileDetail.forEach((key, value) {
      params.add(ParameterModel(Key: key,Value: value,Type: "string"));
    });
    params.where((element) => element.Key=='CustomerImage').forEach((element) {
      List split=element.Value.split("/");
      if(split.length>=2){
        element.Value=split[split.length-1];
      }

    });
    ApiManager.GetInvoke(params).then((value) {
      isLoading.value=false;
      log("$value");
      //isLoading.value=false;
      if(value[0]){
        var response=json.decode(value[1]);
        profileDetail.value=response['Table'][0];
        phoneNumber.Detials=profileDetail['CustomerContactNumber'];
        phoneNumber.refresh.value=!phoneNumber.refresh.value;
        email.Detials=profileDetail['CustomerEmail'];
        email.refresh.value=!email.refresh.value;
        name.Detials=profileDetail['CustomerName'];
        name.refresh.value=!email.refresh.value;
        //profileDetail.refresh();
      }
    });
  }

}


void getProfileDetail() async{
  //isLoading.value=true;
  params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName",Value: Sp.getProfileDetail,Type: "string"));
  ApiManager.GetInvoke(params).then((value) {
    log("$value");
    //isLoading.value=false;
    if(value[0]){
      var response=json.decode(value[1]);
      profileDetail.value=response['Table'][0];
    }
  });
}

class customerDetail extends StatelessWidget {
  String Img;String Title; String Detials;
  String regEx;
  Function(String) onUpdate;
  customerDetail({super.key,required this.Detials,required this.Img,required this.Title,this.regEx=MyConstants.emailRegEx,required this.onUpdate}){
    addNewLabelTextField.setValue(Detials);
    addNewLabelTextField.textInputType=Title=='Phone Number'?TextInputType.number:TextInputType.emailAddress;
    addNewLabelTextField.regExp=regEx;
    addNewLabelTextField.textLength=Title=='Phone Number'?15:null;
  }
  RxBool isEdit=RxBool(false);
  RxBool refresh=RxBool(false);

  AddNewLabelTextField addNewLabelTextField=AddNewLabelTextField(
    dataname: '',
    margin: EdgeInsets.zero,
    onChange: (v){},
    ontap: (){},
    required: true,
  );

  @override
  Widget build(BuildContext context) {
    addNewLabelTextField.onEditComplete=(){
      FocusScope.of(context).unfocus();
    };
    return Obx(() => Container(
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.fromLTRB(10,10,10,0),
      padding: const EdgeInsets.fromLTRB(15,20,15,20),
      decoration: BoxDecoration(
        color:refresh.value?ColorUtil.thWhite:ColorUtil.thWhite,
        border: Border.all(color: const Color(0XFFE4E4E4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child:  Row(
        children: [
          Image.asset(Img,fit:BoxFit.contain,width: 25,),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Title,
                style: const TextStyle(
                    fontFamily: 'RB',
                    fontSize: 16,
                    color: Colors.black,
                    letterSpacing: 0.1),
              ),
              const SizedBox(height: 5,),
              Obx(() => Visibility(
                  visible: !isEdit.value,
                  child: Text(
                    Detials,
                    style: const TextStyle(
                        fontFamily: 'RM',
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 0.1),
                  ),
                  replacement: Container(
                      height: 71,
                      width: SizeConfig.screenWidth!-200,
                      child: addNewLabelTextField
                  )
              ),),

            ],
          ),
          const Spacer(),
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  if(isEdit.value){
                    if(addNewLabelTextField.validate()){
                      onUpdate(addNewLabelTextField.getValue());
                      isEdit.value=false;
                    }
                  }
                  else{
                    isEdit.value=true;
                  }

                },
                child: Obx(() => Text(
                  "${isEdit.value?"Update":"Change"}",
                  style: TextStyle(
                      fontFamily: 'RB',
                      fontSize: 16,
                      color: ColorUtil.primaryColor,
                      letterSpacing: 0.1),
                ),),
              ),
              Obx(() => Visibility(
                visible: isEdit.value,
                child: GestureDetector(
                  onTap: (){
                    isEdit.value=false;
                    addNewLabelTextField.setValue(Detials);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      'Cancel',
                      style: const TextStyle(
                          fontFamily: 'RM',
                          fontSize: 16,
                          color: Colors.red,
                          letterSpacing: 0.1),
                    ),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    ));
  }
}



 Widget CustomerDetail(String Img,String Title, String Detials , String Edit){
    RxBool isEdit=RxBool(false);
    AddNewLabelTextField addNewLabelTextField=AddNewLabelTextField(
        dataname: '',
      margin: EdgeInsets.zero,
    );
    addNewLabelTextField.setValue(Detials);
    return Container(
       width: SizeConfig.screenWidth,
       margin: const EdgeInsets.fromLTRB(10,10,10,0),
       padding: const EdgeInsets.fromLTRB(15,20,15,20),
       decoration: BoxDecoration(
         color:ColorUtil.thWhite,
         border: Border.all(color: const Color(0XFFE4E4E4)),
         borderRadius: BorderRadius.circular(4),
       ),
       child:  Row(
         children: [
           Image.asset(Img,fit:BoxFit.contain,width: 25,),
           const SizedBox(width: 20,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 Title,
                 style: const TextStyle(
                     fontFamily: 'RB',
                     fontSize: 16,
                     color: Colors.black,
                     letterSpacing: 0.1),
               ),
               const SizedBox(height: 5,),
               Obx(() => Visibility(
                 visible: !isEdit.value,
                 child: Text(
                   Detials,
                   style: const TextStyle(
                       fontFamily: 'RM',
                       fontSize: 16,
                       color: Colors.black,
                       letterSpacing: 0.1),
                 ),
                 replacement: Container(
                     height: 60,
                     width: SizeConfig.screenWidth!-200,
                     child: addNewLabelTextField
                 )
               ),)
             ],
           ),
           const Spacer(),
           GestureDetector(
             onTap: (){
               isEdit.value=!isEdit.value;
             },
             child: Obx(() => Text(
               "${isEdit.value?"Update":"Change"}",
               style: TextStyle(
                   fontFamily: 'RB',
                   fontSize: 16,
                   color: ColorUtil.primaryColor,
                   letterSpacing: 0.1),
             ),),
           )
         ],
       ),
     );
 }
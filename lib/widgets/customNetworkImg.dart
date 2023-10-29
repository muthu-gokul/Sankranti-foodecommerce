import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../notifier/Billing/configuration.dart';
import '../utils/utils.dart';
import 'loader.dart';
import 'shimmer.dart';

class CustomNetworkImg extends StatefulWidget {
  String dbFilePath;
  String directoryPath;
  Widget? errorBuilder;
  double? width;
  double? height;
  double? loaderHeight;
  double? loaderWidth;
  String errorImage;
  String? baseUrl;
  BoxFit? fit;
  CustomNetworkImg({Key? key,required this.dbFilePath,required this.directoryPath,this.errorBuilder,this.width,this.height,
  this.loaderHeight,this.loaderWidth,this.errorImage="assets/items/DefaultProduct.png",this.baseUrl,this.fit}) : super(key: key);

  @override
  State<CustomNetworkImg> createState() => _CustomNetworkImgState();
}

class _CustomNetworkImgState extends State<CustomNetworkImg> {
  var loaded=false.obs;

  late FileImage fileImage;

  @override
  void initState(){
    fileImage=FileImage(File('${widget.directoryPath}/${widget.dbFilePath}'));
    init();
    super.initState();
  }
  String fileName="";
  void init(){
    String imgFolder=getFolderNameFromFolderPath(widget.dbFilePath);
    fileName=getFileNameFromFolderPath(widget.dbFilePath);
    download(widget.baseUrl==null?GetImageBaseUrl()+widget.dbFilePath:widget.baseUrl!+widget.dbFilePath,widget.directoryPath,imgFolder,fileName,successCb: (){
      console("downloaded");
    }).then((value){
      loaded.value=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => loaded.value?Image(
        image: fileImage,
        key: UniqueKey(),
        fit: widget.fit??BoxFit.contain,
        //fit: BoxFit.fitHeight,
        width: widget.width,
        height: widget.height,
        errorBuilder: (a,b,c){
          return widget.errorBuilder??Image.asset(widget.errorImage,fit: BoxFit.cover);
        },
     /* loadingBuilder: (a,b,c){
          return ImgShimmer();
      },*/
    ): ImgShimmer(
      height: widget.loaderHeight,
      width: widget.loaderWidth,
    )
    );
  }

  @override
  void dispose(){
    // imageCache.clear();
    // imageCache.clearLiveImages();
    imageCache.evict(fileImage);
  //  console("CustomNetworkImg dispose ${fileName} ${imageCache.evict(fileImage)}");
    super.dispose();
  }
}

class ImgShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  const ImgShimmer({Key? key,required this.height,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Column(
            /*shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),*/
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //  const BannerPlaceholder(),
              Container(
                width: width??50.0,
                height: height??50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
              )
              /*  const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              const SizedBox(height: 16.0),
              const TitlePlaceholder(width: 200.0),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              const SizedBox(height: 16.0),
              const TitlePlaceholder(width: 200.0),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),*/
            ],
          )
      ),
    );
  }
}



/*class CustomNetworkImg extends StatelessWidget {
  String dbFilePath;
  String directoryPath;
  Widget? errorBuilder;
  double? width;
  double? height;
  CustomNetworkImg({Key? key,required this.dbFilePath,required this.directoryPath,this.errorBuilder,this.width,this.height}) : super(key: key){
    init();
  }
  var loaded=false.obs;
  void init(){
    //console("init $dbFilePath");
    String imgFolder=getFolderNameFromFolderPath(dbFilePath);
    String fileName=getFileNameFromFolderPath(dbFilePath);
    download(GetImageBaseUrl()+dbFilePath,directoryPath,imgFolder,fileName).then((value){
      loaded.value=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => loaded.value?Image.file(File('$directoryPath/$dbFilePath'),
        fit: BoxFit.cover,
        //fit: BoxFit.fitHeight,
        width: width,
        height: height,
        errorBuilder: (a,b,c){
      return errorBuilder??Image.asset('assets/logo.png',fit: BoxFit.cover);
    }):
    Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Column(
            /*shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),*/
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //  const BannerPlaceholder(),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              const SizedBox(height: 20.0),
              const ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              /*  const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              const SizedBox(height: 16.0),
              const TitlePlaceholder(width: 200.0),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              const SizedBox(height: 16.0),
              const TitlePlaceholder(width: 200.0),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),*/
            ],
          )
      ),
    )
    );
  }
}*/
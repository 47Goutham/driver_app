class Vehicle {
  String id;
  String licenseNo;
  String brand;
  String model;
  late String type;
  late String name;


  Vehicle({required this.id,required this.licenseNo,required this.brand,required this.model}){

    if(brand == 'Bike') {
      type = 'Bike';
      name = licenseNo;
    } else if ( brand == 'Hyundai' &&  model == 'Solaris'){
      type = 'OnFoot';
      name = 'OnFoot';
    }else {
      type = 'Car';
      name = '$licenseNo $brand $model';
    }



  }






}
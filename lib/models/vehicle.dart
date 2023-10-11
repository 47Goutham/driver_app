class Vehicle {
  String id;
  String licenseNo;
  String brand;
  String model;
  late String type;

  Vehicle({required this.id,required this.licenseNo,required this.brand,required this.model}){

    if(brand == 'Bike') {
      type = 'Bike';
    } else if ( brand == 'Hyundai' &&  model == 'Solaris'){
      type = 'OnFoot';
    }else {
      type = 'Car';
    }

  }




}
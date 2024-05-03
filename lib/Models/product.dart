class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pCategory;
  int pQuantity;
  Product(
      {this.pQuantity = 0,
      required this.pCategory,
      required this.pDescription,
      required this.pLocation,
      required this.pName,
      required this.pPrice});
}

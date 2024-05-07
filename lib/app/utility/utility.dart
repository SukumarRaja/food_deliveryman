calculateDiscount({price, discountPrice}) {
  var discount =
      ((int.parse(price) - int.parse(discountPrice)) / int.parse(price) * 100)
          .round();
  return discount;
}

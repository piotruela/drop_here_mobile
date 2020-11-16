extension Formatting on double {
  String formatPrice() {
    if (this % 1 == 0) {
      return "${this.toInt().toString()} zł";
    }
    return "${this.toString()} zł";
  }
}

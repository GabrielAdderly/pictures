class Dictionary {
  const Dictionary();

  Dictionary.empty();

  @override
  bool operator ==(Object other) {
    bool isIdentical = identical(this, other);

    if (other is Dictionary) {
      return isIdentical;
    }

    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
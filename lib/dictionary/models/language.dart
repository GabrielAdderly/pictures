class Dictionary {
  const Dictionary();

  Dictionary.empty();

  @override
  bool operator ==(Object other) {
    final bool isIdentical = identical(this, other);

    if (other is Dictionary) {
      return isIdentical;
    }

    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
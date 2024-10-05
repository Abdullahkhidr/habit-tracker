int generateId() {
  return DateTime.now().millisecondsSinceEpoch % 100000;
}

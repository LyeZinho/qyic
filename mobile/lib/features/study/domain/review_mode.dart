/// Values match `qyic.v1.ReviewMode`. Every mode reschedules cards the same
/// way; the mode only feeds statistics and history.
enum ReviewMode {
  standard(1),
  exam(2);

  const ReviewMode(this.value);

  final int value;
}

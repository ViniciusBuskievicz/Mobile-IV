enum OperationType {
  addition(symbol: "+"),
  subtraction(symbol: "-"),
  multiplication(symbol: "x"),
  division(symbol: "\u00f7");

  final String symbol;
  const OperationType({required this.symbol});
}
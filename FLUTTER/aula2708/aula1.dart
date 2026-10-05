import 'dart:io';

void main() {
  stdout.write("Digite um numero: ");
  int numero1 = int.parse(stdin.readLineSync()!);

  stdout.write("Digite outro numero: ");
  int numero2 = int.parse(stdin.readLineSync()!);

  print("A soma dos numeros é: ${numero1 + numero2}");
  print("A subtração dos numeros é: ${numero1 - numero2}");
  print("A multiplicação dos numeros é: ${numero1 * numero2}");
  print("A divisão dos numeros é: ${numero1 / numero2}");
  print(
    "Os resultados são: ${numero1 + numero2}, ${numero1 - numero2}, ${numero1 * numero2}, ${numero1 / numero2}",
  );

  int num1 = int.parse(stdin.readLineSync()!);
  int num2 = int.parse(stdin.readLineSync()!);

  print("A soma dos numeros é: ${num1 + num2}");
  print("A subtração dos numeros é: ${num1 - num2}");
  print("A multiplicação dos numeros é: ${num1 * num2}");
  print("A divisão dos numeros é: ${num1 / num2}");
}

int soma(int a, int b) {
  int c = a+b;
  return c;
}

void imprimeMensagem(String mensagem) {
  print(mensagem);
}

void exibirNomes(String nome, [String? sobrenome]){
  print("$nome $sobrenome");
}

void saudar({required String nome, String saudacao = "Oq ha velinho"}){
  print("$saudacao $nome");
}

int subtrair(int a, int b) => a-b;

void main() {
  imprimeMensagem(" Ola, mundo ");
  print(soma(1, 2));

  exibirNomes("Vinicius" , "Alisson");
  exibirNomes("godofredo");
  
  saudar(nome: "Vinicius");
  saudar(nome: "Alisson", saudacao: "opa");
  saudar(saudacao: "opa", nome: "Alisson");

  print(subtrair(458, 98880));


  var nomes = ["Cristiano Ronaldo", "Neymar", "Yuri Alberto"];

  nomes.forEach((nome){
    print("Ola $nome");
  });


  var lista = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  var impares = lista.where((n) => n % 2 != 0);
  print(impares);

  List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  print(numeros);


  Map<String, String> pessoa = {
    "nome" : "Luiz",
    "Idade" : "78",
    "cidade" : "Guarapuava"
  };

  print(pessoa);

}


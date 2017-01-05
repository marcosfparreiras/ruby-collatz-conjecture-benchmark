# Conjectura de Collatz

fonte: http://en.wikipedia.org/wiki/Collatz_conjecture

A seguinte sequência iterativa é definida pelo conjunto de inteiros positivos onde:
```
n -> n/2 (se n é par)
n -> 3n + 1 (se n é impar)
```
Usando as regras acima e começando pelo número 13, nós geraríamos a seguinte sequência:
```
13 40 20 10 5 16 8 4 2 1
```
O que pode ser observado dessa sequência (começando no 13 e terminando no 1) é que ela contém 10 items. Embora ainda não esteja matematicamente provado, é esperando que, dado um numero inteiro positivo qualquer, a sequencia sempre chegará em 1.

Pergunta: Qual inteiro positivo abaixo de 1 milhão, produz a sequencia com mais items?

Resposta: Executando os algoritmos propostos, chega-se à seguinte resposta.
> O inteiro com maior sequência é o 837,799 com sequência contendo 524 elementos"

 Para a execução, basta rodar `ruby collatz_test.rb` ou `ruby collatz_test_cache.rb` (dois algoritmos com abordagens diferentes, como explicado abaixo).

# Benchmark
Para resolver o problema, foram propostas duas soluções:
- A primeira, mostrada no arquivo `collatz_test.rb`, apresenta melhor modularização, com uma classe específica para calcular o resultado da sequência de collatz para cada número. Isso favorece melhor legibilidade e manutenabilidade;
- A segunda, mostrada no arquivo `collatz_test_cache.rb`, utiliza outra abordagem, abrindo mão de parte da modularização do código para obter um ganho significativo na performance tendo como base o tempo de execução. Para tanto, foi utilizado um Hash para criar uma estrutura que simula uma cache, armazenando o tamanho da sequência iterativa para números parciais. Com isso, caso esse número parcial apareça em qualquer sequência, não é necessário fazer nenhum processamento a partir desse ponto, tendo em vista que já se sabe o tamanho da sequência a partir desse ponto.

Para comparar os dois algoritmos foi criada a classe `CollatzTestBenchmark`, que verifica o tempo gasto para a execução de cada uma das soluções propostas, levando em conta o número máximo de 1 a 10 milhões, em potências de 10. Para executar o benchmark basta executar:
```
ruby collatz_test_benchmark.rb
```

É mostrada a seguir uma tabela comparando os resultados obtidos pelos dois algoritmos propostos.
- **Algoritmo 1** é o algoritmo que não usa cache;
- **Algoritmo 2** é o algoritmo que usa cache;

|Número máximo| Tempo Gasto pelo Algoritmo 1 (s) | Tempo Gasto pelo Algoritmo 2 (s)
|-------------|---------------------------------|-------------------------------
|10           | 4.0e-05  | 6.0e-05
|100          | 0.00079  | 0.00046
|1.000        | 0.01339  | 0.00364
|10.000       | 0.19415  | 0.03940
|100.000      | 2.39526  | 0.91555
|1.000.000    | 28.1662  | 8.21007
|10.000.000   | 342.742  | 92.4415

Como se pode ver, o algoritmo com cache foi ligeiramente inferior somente no caso em que o número máximo utilizado foi muito pequeno é que a estrutura de cache não fez diferença. Em todos os outros casos, foi superior chegando a ser, no caso das maiores instância (100.000, 1.000.000 e 10.000.000) de registros, cerca de 3 vezes mais eficiente.

# Trabalho 2 — Agenda em Lisp

Implementação de uma agenda de contatos para a disciplina de **Tópicos em Tecnologia e Programação** — PUC-Campinas.

O programa mantém uma agenda no formato abaixo e disponibiliza um menu interativo para cadastrar, alterar, excluir e visualizar contatos:

```lisp
((Nome Telefone1 Telefone2 ...) ...)
```

## Integrantes

- Beatriz Kamien Tehzy — RA 25007147
- Matheus Augusto Mendonça — RA 22011027

## Estrutura do projeto

| Arquivo | Finalidade |
| --- | --- |
| `agenda.lsp` | Implementação das operações da agenda e do menu CRUD interativo. |
| `test-agenda.lsp` | Bateria de testes automatizados das funções principais. |
| `run.sh` | Script Bash para iniciar o menu automaticamente com uma instalação local de CLISP. |
| `.gitignore` | Ignora a pasta `.local-clisp/`, usada apenas pelo ambiente local de execução. |

## Requisitos para execução

Para executar pelo script, é necessário um ambiente compatível com Bash, como Linux, macOS, WSL ou Git Bash.

### Opção 1 — Executar com `run.sh`

O arquivo `run.sh` inicia o programa e já chama a função `(menu)` automaticamente.

No terminal, dentro da pasta do projeto:

```bash
chmod +x run.sh
./run.sh
```

> O script procura uma instalação local em `.local-clisp/`. Essa pasta não faz parte do repositório porque é ignorada pelo Git. Caso ela esteja presente no ambiente de entrega, basta executar `./run.sh`.

### Opção 2 — Executar com CLISP instalado no computador

Caso o comando `./run.sh` mostre a mensagem `CLISP local nao encontrado`, instale o CLISP no sistema e execute diretamente o arquivo Lisp.

Em distribuições Debian/Ubuntu/WSL:

```bash
sudo apt-get update
sudo apt-get install -y clisp
```

Depois, ainda dentro da pasta do projeto:

```bash
clisp -q -q -i agenda.lsp
```

Quando o interpretador abrir, inicie o sistema com:

```lisp
(menu)
```

## Como usar o menu

Ao iniciar, o programa apresenta as seguintes opções:

```text
1 - Adicionar contato
2 - Alterar telefone de contato
3 - Excluir contato
4 - Visualizar contatos
5 - Sair
```

Os nomes devem ser digitados sem espaços, por exemplo `Rose`. Os telefones devem ser informados como números, por exemplo `991919191`.

Exemplo de uso no menu:

```text
Escolha uma opcao: 1
Nome do contato: Rose
Telefone: 32666556

Escolha uma opcao: 1
Nome do contato: Rose
Telefone: 991919191

Escolha uma opcao: 4
(ROSE 32666556 991919191)
Fim da agenda.
```

## Execução dos testes automatizados

O arquivo `test-agenda.lsp` carrega `agenda.lsp`, cria uma agenda de teste e valida as operações principais. Ele usa recursos do CLISP, incluindo `EXT:EXIT`, para finalizar com código de sucesso ou erro.

Execute o comando abaixo **a partir da pasta do projeto**:

```bash
clisp -q -q -i test-agenda.lsp
```

Saída esperada:

```text
OK: inclui contatos e telefones
OK: altera telefone de um contato
OK: exclui contato inteiro
OK: mantem os demais contatos apos exclusao
Todos os testes passaram.
```

Em caso de falha, o teste informa o nome da verificação, o valor esperado e o valor obtido, encerrando com código de erro `1`.

## Teste manual das funções

Também é possível carregar somente `agenda.lsp` e testar as funções diretamente no interpretador:

```lisp
(load "agenda.lsp")

(setq AGENDA 'nil)
(setq AGENDA (incluir AGENDA '(Bel 32338778)))
(setq AGENDA (incluir AGENDA '(Rose 32666556)))
(setq AGENDA (incluir AGENDA '(Rose 991919191)))
(setq AGENDA (incluir AGENDA '(Beto 32529119)))

(Telefones AGENDA 'Rose)
; Resultado: (32666556 991919191)

(setq AGENDA (alterar AGENDA '(Rose 991919191 11112222)))
(Telefones AGENDA 'Rose)
; Resultado: (32666556 11112222)

(setq AGENDA (excluir AGENDA '(Rose 11112222)))
(Telefones AGENDA 'Rose)
; Resultado: (32666556)

(setq AGENDA (excluir-contato AGENDA 'Rose))
(Telefones AGENDA 'Rose)
; Resultado: INEXISTENTE
```

## Operações implementadas

- `incluir`: inclui um contato novo ou adiciona um novo telefone a um contato existente. Telefones duplicados não são inseridos.
- `alterar`: substitui um telefone existente de um contato.
- `excluir`: remove um telefone específico; se ele for o último telefone do contato, o contato também é removido.
- `excluir-contato`: remove um contato inteiro pelo nome.
- `Telefones`: retorna a lista de telefones de um contato ou o símbolo `INEXISTENTE` quando o nome não está cadastrado.
- `visualizar-contatos`: imprime todos os contatos armazenados na agenda.
- `menu`: inicia o CRUD interativo.

## Atendimento aos requisitos

- A agenda é armazenada como uma lista de registros no formato `((Nome Tel1 Tel2 ...) ...)`.
- A inclusão preserva a ordem dos telefones já cadastrados.
- A exclusão de um único telefone remove automaticamente o contato quando não restam números vinculados a ele.
- A busca retorna somente os telefones do contato ou `INEXISTENTE`.
- As funções centrais de manipulação da agenda foram construídas recursivamente, usando os operadores trabalhados em aula, como `CAR`, `CDR`, `CONS`, `ATOM`, `EQ` e `COND`.

## Diário de bordo

### Matheus Augusto Mendonça

| Data | Hora de início | Duração | Atividade |
| :--- | :--- | :--- | :--- |
| 12/06/2026 | 14:00 | 1h 30min | Leitura do enunciado do trabalho da agenda em Lisp e análise das funções permitidas de Lisp Puro. |
| 13/06/2026 | 10:00 | 2h 00min | Planejamento lógico e rascunho das recursões para adicionar no fim da lista e remover elementos. |
| 15/06/2026 | 15:30 | 2h 00min | Escrita do código principal em Lisp Puro no arquivo `agenda.lsp` — funções `add-fim`, `remover-elem`, `incluir`, `excluir` e `Telefones`. |

### Beatriz Kamien Tehzy

| Data | Hora de início | Duração | Atividade |
| :--- | :--- | :--- | :--- |
| 16/06/2026 | 14:00 | 1h 30min | Leitura do código final, busca e correção de erros lógicos. |
| 16/06/2026 | 16:00 | 1h 30min | Execução de bateria de testes usando as interações do PDF da atividade. |
| 16/06/2026 | 18:00 | 1h 00min | Elaboração do documento de entrega e consolidação final do projeto. |

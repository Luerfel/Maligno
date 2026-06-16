# Trabalho 2 - Agenda em Lisp

Trabalho de Programação Funcional da disciplina Tópicos em Tecnologia e Programação (PUC-Campinas).

## Integrantes
- Beatriz Kamien Tehzy – 25007147
- Matheus Augusto Mendonça – 22011027

## Como usar no XLISP (Ambiente do Professor)

Como a pasta da disciplina contém o `xLisp.zip` com o executável para Windows, siga estes passos para rodar o projeto nele:

1. **Extrair o XLISP**: Extraia o arquivo `xLisp.zip` (que está na pasta do professor `3) ARQUIVOS DE PROGRAMAS`).
2. **Copiar o arquivo**: Copie o seu arquivo `agenda.lsp` para a mesma pasta onde está o executável `xlispwin.exe` ou `xlwin32.exe`.
3. **Abrir o XLISP**: Dê um duplo clique em `xlispwin.exe` ou `xlwin32.exe` para abrir o interpretador.
4. **Carregar o arquivo**: Na janela do XLISP, digite o seguinte comando e aperte Enter:
   ```lisp
   (load "agenda.lsp")
   ```
   *(Deve retornar `T`, indicando que as funções foram carregadas com sucesso).*

5. **Testar as funções**: Agora você pode testar digitando os comandos linha por linha:
   ```lisp
   ; 1. Inicializar a agenda como vazia
   (setq AGENDA 'nil)
   
   ; 2. Incluir contatos
   (setq AGENDA (incluir AGENDA '(Bel 32338778)))
   (setq AGENDA (incluir AGENDA '(Rose 32666556)))
   
   ; 3. Adicionar telefone em contato existente (Rose deve ficar com dois números)
   (setq AGENDA (incluir AGENDA '(Rose 991919191)))
   (setq AGENDA (incluir AGENDA '(Beto 32529119)))
   
   ; 4. Testar a busca
   (Telefones AGENDA 'Jose) ; Deve retornar o símbolo: INEXISTENTE
   (Telefones AGENDA 'Rose) ; Deve retornar a lista: (32666556 991919191)
   
   ; 5. Excluir telefone
   (setq AGENDA (excluir AGENDA '(Rose 991919191)))
   (Telefones AGENDA 'Rose) ; Deve retornar: (32666556)
   
   ; 6. Excluir último telefone (Rose deve sumir da agenda)
   (setq AGENDA (excluir AGENDA '(Rose 32666556)))
   (Telefones AGENDA 'Rose) ; Deve retornar: INEXISTENTE
   ```

---

## Verificação dos Requisitos Exigidos

* **Estrutura da Agenda**: A agenda armazena os dados exatamente como `((Nome Tel1 Tel2 ...) ...)`, conforme solicitado.
* **Inclusão**: A função `incluir` verifica se o nome já existe na agenda. Se existir, adiciona o novo telefone no fim do registro existente (mantendo a ordem dos telefones anteriores).
* **Exclusão**: A função `excluir` remove o número solicitado. Caso seja o único número do contato (ou seja, resta apenas o nome no registro), o contato é removido completamente da agenda.
* **Busca**: A função `Telefones` retorna apenas os números vinculados ao nome pesquisado, ou `INEXISTENTE` se o nome não constar na lista.
* **Lisp Puro**: Apenas os operadores permitidos pelo professor em aula (`CAR`, `CDR`, `CONS`, `ATOM`, `EQ` e `COND`) foram usados, sem funções avançadas prontas de manipulação de listas.

---

## Diário de Bordo
Conforme exigido na especificação (entradas individuais), segue o registro das atividades divididas entre a dupla:

**Matheus Augusto Mendonça:**
| Data | Hora Início | Duração | Atividade |
| :--- | :--- | :--- | :--- |
| 12/06/2026 | 14:00 | 1h 30min | Leitura do enunciado do trabalho da agenda em Lisp e análise das funções permitidas de Lisp Puro. |
| 13/06/2026 | 10:00 | 2h 00min | Planejamento lógico e rascunho das recursões para adicionar no fim da lista e remover elementos. |
| 15/06/2026 | 15:30 | 2h 00min | Escrita do código principal em Lisp Puro no arquivo agenda.lsp (funções add-fim, remover-elem, incluir, excluir e Telefones). |

**Beatriz Kamien Tehzy:**
| Data | Hora Início | Duração | Atividade |
| :--- | :--- | :--- | :--- |
| 16/06/2026 | 14:00 | 1h 30min | Leitura do código final, busca e correção de erros lógicos. |
| 16/06/2026 | 16:00 | 1h 30min | Execução de bateria de testes usando as interações do PDF da atividade. |
| 16/06/2026 | 18:00 | 1h 00min | Elaboração do documento de entrega e consolidação final do projeto. |

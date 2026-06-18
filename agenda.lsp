;; Trabalho de Lisp - Agenda
;; Dupla: Beatriz Kamien Tehzy (RA: 25007147) e Matheus Augusto Mendonça (RA: 22011027)

;; Verifica se um elemento pertence a lista.
;; Retorna T quando encontra o elemento e NIL quando chega ao fim da lista.
(DEFUN membro (elem lista)
  (COND ((ATOM lista) 'NIL)
        ((EQ (CAR lista) elem) 'T)
        ('T (membro elem (CDR lista)))))

;; Adiciona um elemento no final da lista.
;; Esta funcao e usada para inserir um novo telefone mantendo a ordem antiga.
(DEFUN add-fim (elem lista)
  (COND ((ATOM lista) (CONS elem 'NIL))
        ('T (CONS (CAR lista) (add-fim elem (CDR lista))))))

;; Remove um telefone da lista do contato.
;; A lista recebida tem o formato (Nome Tel1 Tel2 ...).
(DEFUN remover-elem (elem lista)
  (COND ((ATOM lista) 'NIL)
        ((EQ (CAR lista) elem) (CDR lista))
        ('T (CONS (CAR lista) (remover-elem elem (CDR lista))))))

;; Troca um elemento por outro dentro de uma lista.
;; No CRUD, esta funcao troca o telefone antigo pelo telefone novo.
(DEFUN substituir-elem (antigo novo lista)
  (COND ((ATOM lista) 'NIL)
        ((EQ (CAR lista) antigo) (CONS novo (CDR lista)))
        ('T (CONS (CAR lista) (substituir-elem antigo novo (CDR lista))))))

;; Inclui contato novo ou insere telefone se o contato ja existe.
;; Exemplo de contato recebido: (Rose 32666556).
;; Se Rose ja existir, o telefone e colocado no final da lista dela.
(DEFUN incluir (agenda contato)
  (COND ((ATOM agenda) (CONS contato 'NIL))
        ((EQ (CAR (CAR agenda)) (CAR contato))
         (COND ((membro (CAR (CDR contato)) (CAR agenda)) agenda)
               ('T (CONS (add-fim (CAR (CDR contato)) (CAR agenda)) (CDR agenda)))))
        ('T (CONS (CAR agenda) (incluir (CDR agenda) contato)))))

;; Altera um telefone de um contato.
;; O parametro info tem o formato (Nome TelefoneAntigo TelefoneNovo).
;; Se o nome nao existir, a agenda continua sendo percorrida ate o fim.
(DEFUN alterar (agenda info)
  (COND ((ATOM agenda) 'NIL)
        ((EQ (CAR (CAR agenda)) (CAR info))
         (CONS (substituir-elem (CAR (CDR info))
                                (CAR (CDR (CDR info)))
                                (CAR agenda))
               (CDR agenda)))
        ('T (CONS (CAR agenda) (alterar (CDR agenda) info)))))

;; Exclui um telefone. Se for o unico telefone, remove o contato todo da agenda.
;; O parametro info tem o formato (Nome Telefone).
(DEFUN excluir (agenda info)
  (COND ((ATOM agenda) 'NIL)
        ((EQ (CAR (CAR agenda)) (CAR info))
         (COND ((ATOM (CDR (remover-elem (CAR (CDR info)) (CAR agenda))))
                (CDR agenda))
               ('T (CONS (remover-elem (CAR (CDR info)) (CAR agenda)) (CDR agenda)))))
        ('T (CONS (CAR agenda) (excluir (CDR agenda) info)))))

;; Exclui o contato inteiro pelo nome.
;; Esta funcao atende a opcao DELETE do menu CRUD.
(DEFUN excluir-contato (agenda nome)
  (COND ((ATOM agenda) 'NIL)
        ((EQ (CAR (CAR agenda)) nome) (CDR agenda))
        ('T (CONS (CAR agenda) (excluir-contato (CDR agenda) nome)))))

;; Busca e retorna os telefones de um contato. Retorna INEXISTENTE se nao achar.
(DEFUN Telefones (agenda nome)
  (COND ((ATOM agenda) 'INEXISTENTE)
        ((EQ (CAR (CAR agenda)) nome) (CDR (CAR agenda)))
        ('T (Telefones (CDR agenda) nome))))

;; Imprime todos os contatos cadastrados.
;; Cada contato aparece no mesmo formato usado internamente:
;; (Nome Tel1 Tel2 ...)
(DEFUN visualizar-contatos (agenda)
  (COND ((ATOM agenda)
         (PROGN
           (PRINC "Fim da agenda.")
           (TERPRI)))
        ('T
         (PROGN
           (PRINC (CAR agenda))
           (TERPRI)
           (visualizar-contatos (CDR agenda))))))

;; Le os dados de um novo contato e devolve a agenda atualizada.
;; O nome deve ser digitado sem espacos, por exemplo: Rose
(DEFUN menu-adicionar (agenda)
  (PROGN
    (PRINC "Nome do contato: ")
    (SETQ NOME (READ))
    (PRINC "Telefone: ")
    (SETQ TELEFONE (READ))
    (incluir agenda (CONS NOME (CONS TELEFONE 'NIL)))))

;; Le nome, telefone antigo e telefone novo para alterar um contato.
;; Exemplo de uso no menu: Rose 991919191 11112222.
(DEFUN menu-alterar (agenda)
  (PROGN
    (PRINC "Nome do contato: ")
    (SETQ NOME (READ))
    (PRINC "Telefone antigo: ")
    (SETQ TELEFONE-ANTIGO (READ))
    (PRINC "Telefone novo: ")
    (SETQ TELEFONE-NOVO (READ))
    (alterar agenda
             (CONS NOME
                   (CONS TELEFONE-ANTIGO
                         (CONS TELEFONE-NOVO 'NIL))))))

;; Le o nome e remove o contato completo da agenda.
(DEFUN menu-excluir (agenda)
  (PROGN
    (PRINC "Nome do contato que deseja excluir: ")
    (SETQ NOME (READ))
    (excluir-contato agenda NOME)))

;; Mostra as opcoes disponiveis para o usuario.
(DEFUN mostrar-menu ()
  (PROGN
    (TERPRI)
    (PRINC "===== MENU DA AGENDA =====")
    (TERPRI)
    (PRINC "1 - Adicionar contato")
    (TERPRI)
    (PRINC "2 - Alterar telefone de contato")
    (TERPRI)
    (PRINC "3 - Excluir contato")
    (TERPRI)
    (PRINC "4 - Visualizar contatos")
    (TERPRI)
    (PRINC "5 - Sair")
    (TERPRI)
    (PRINC "Escolha uma opcao: ")))

;; Laco principal do menu.
;; A agenda e passada como parametro para manter o estado atualizado.
(DEFUN menu-loop (agenda)
  (PROGN
    (mostrar-menu)
    (SETQ OPCAO (READ))
    (COND ((EQ OPCAO 1)
           (menu-loop (menu-adicionar agenda)))
          ((EQ OPCAO 2)
           (menu-loop (menu-alterar agenda)))
          ((EQ OPCAO 3)
           (menu-loop (menu-excluir agenda)))
          ((EQ OPCAO 4)
           (PROGN
             (visualizar-contatos agenda)
             (menu-loop agenda)))
          ((EQ OPCAO 5)
           (PROGN
             (PRINC "Saindo da agenda.")
             (TERPRI)
             agenda))
          ('T
           (PROGN
             (PRINC "Opcao invalida.")
             (TERPRI)
             (menu-loop agenda))))))

;; Funcao inicial para abrir o programa.
;; Digite (menu) no interpretador Lisp para iniciar o CRUD.
(DEFUN menu ()
  (PROGN
    (SETQ AGENDA 'NIL)
    (menu-loop AGENDA)))

;; Trabalho de Lisp - Agenda
;; Dupla: Beatriz Kamien Tehzy (RA: 25007147) e Matheus Augusto Mendonça (RA: 22011027)

;; Adiciona um elemento no final da lista
(DEFUN add-fim (elem lista)
  (COND ((ATOM lista) (CONS elem 'NIL))
        ('T (CONS (CAR lista) (add-fim elem (CDR lista))))))

;; Remove um telefone da lista do contato
(DEFUN remover-elem (elem lista)
  (COND ((ATOM lista) 'NIL)
        ((EQ (CAR lista) elem) (CDR lista))
        ('T (CONS (CAR lista) (remover-elem elem (CDR lista))))))

;; Inclui contato novo ou insere telefone se o contato ja existe
(DEFUN incluir (agenda contato)
  (COND ((ATOM agenda) (CONS contato 'NIL))
        ((EQ (CAR (CAR agenda)) (CAR contato))
         (CONS (add-fim (CAR (CDR contato)) (CAR agenda)) (CDR agenda)))
        ('T (CONS (CAR agenda) (incluir (CDR agenda) contato)))))

;; Exclui um telefone. Se for o unico telefone, remove o contato todo da agenda.
(DEFUN excluir (agenda info)
  (COND ((ATOM agenda) 'NIL)
        ((EQ (CAR (CAR agenda)) (CAR info))
         (COND ((ATOM (CDR (remover-elem (CAR (CDR info)) (CAR agenda))))
                (CDR agenda))
               ('T (CONS (remover-elem (CAR (CDR info)) (CAR agenda)) (CDR agenda)))))
        ('T (CONS (CAR agenda) (excluir (CDR agenda) info)))))

;; Busca e retorna os telefones de um contato. Retorna INEXISTENTE se nao achar.
(DEFUN Telefones (agenda nome)
  (COND ((ATOM agenda) 'INEXISTENTE)
        ((EQ (CAR (CAR agenda)) nome) (CDR (CAR agenda)))
        ('T (Telefones (CDR agenda) nome))))

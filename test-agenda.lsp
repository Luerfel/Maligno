;; Testes simples para validar as operacoes principais da agenda.
;; Este arquivo usa recursos de teste apenas para verificacao automatica.

(LOAD "agenda.lsp")

(DEFUN assert-equal (esperado obtido nome-teste)
  (COND ((EQUAL esperado obtido)
         (FORMAT T "OK: ~A~%" nome-teste))
        ('T
         (PROGN
           (FORMAT T "FALHOU: ~A~%" nome-teste)
           (FORMAT T "Esperado: ~S~%" esperado)
           (FORMAT T "Obtido: ~S~%" obtido)
           (EXT:EXIT 1)))))

(SETQ AGENDA 'NIL)
(SETQ AGENDA (incluir AGENDA '(Bel 32338778)))
(SETQ AGENDA (incluir AGENDA '(Rose 32666556)))
(SETQ AGENDA (incluir AGENDA '(Rose 991919191)))
(SETQ AGENDA (incluir AGENDA '(Beto 32529119)))

(assert-equal
 '((BEL 32338778) (ROSE 32666556 991919191) (BETO 32529119))
 AGENDA
 "inclui contatos e telefones")

(SETQ AGENDA (alterar AGENDA '(Rose 991919191 11112222)))

(assert-equal
 '(32666556 11112222)
 (Telefones AGENDA 'Rose)
 "altera telefone de um contato")

(SETQ AGENDA (excluir-contato AGENDA 'Bel))

(assert-equal
 'INEXISTENTE
 (Telefones AGENDA 'Bel)
 "exclui contato inteiro")

(assert-equal
 '((ROSE 32666556 11112222) (BETO 32529119))
 AGENDA
 "mantem os demais contatos apos exclusao")

(FORMAT T "Todos os testes passaram.~%")
(EXT:EXIT 0)

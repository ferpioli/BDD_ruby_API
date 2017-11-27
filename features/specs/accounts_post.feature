#language:pt

Funcionalidade: Cadastro de usuário

    @smoke
    Cenario: Novo usuário

        Dado que o cliente informou seus dados cadastrais:
            | name     | Fernando Pimentel   |
            | email    | fernando@test.io |
            | password | 123456              |
        Quando faço uma requisição POST para o serviço accounts
        Então o código de resposta deve ser "200"

    @duplicado
    Cenario: Não permite email duplicado

        Dado que o cliente informou seus dados cadastrais:
            | name     | Fernando Duplicado     |
            | email    | fernando@duplicado.com |
            | password | 123456                 |
        Mas esse cliente já está cadastrado
        Quando faço uma requisição POST para o serviço accounts
        Então o código de resposta deve ser "409"
        E deve ser exibido um JSON com a mensagem:
        """
        O e-mail informado, ja está cadastrado!
        """

    Esquema do Cenario: Campos obrigatórios

        Dado que o cliente informou seus dados cadastrais:
            | name     | <nome>  |
            | email    | <email> |
            | password | <senha> |
        Quando faço uma requisição POST para o serviço accounts
        Então o código de resposta deve ser "409"
        E deve ser exibido um JSON com a mensagem:
        """
        <mensagem>
        """

        Exemplos:
        |nome    |email             |senha  |mensagem                   |
        |        |fernando@teste.com|123456 |Nome deve ser obrigatório! |
        |Fernando|                  |123456 |Email deve ser obrigatório!|
        |Fernando|fernando@teste.com|       |Senha deve ser obrigatório!|

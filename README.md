# Sistema DEAME

As polícias judiciárias dos Estados são elementos integrantes do SisFPC (Sistema de Fiscalização de Produdos Controlados), na condição de auxiliares da fiscalização de PCE (Produtos Controlados pelo Exército) realizada pelo Comando do Exército.

No Estado de Minas Gerais, exites a Delegacia Especializadas em Armas, Munições e Explosivos (DEAME) que fica com o encargo de realizar esse auxílio ao Comando do Exército.

Dentre suas funções administrativas temos:

* O registro e emissão de Licença de Atividade de Empresa para os empreendimentos que trabalhem com PCE no território do Estado de Minas Gerais;
* A avaliação dos conhecimentos do cidadão que deseje exercer a função de encarreagado de fogo (blaster), e posterior emissão da respectiva carteira funcional de blaster, caso aprovado em prova de conhecimento da matéria;
* Emissão de Licença para Queima de Fogos de Artifício para as empresas devidamente registradas e com blaster em dia com as obrigações junto ao DEAME;
* Emissão da autorização de venda de colete balístico e posterior registro do mesmo para o cidação que realizar tal pleito, após análise descricionária da autoridade policial.

## Razão do Sistema DEAME

Diante o acima mencionado, é de fundamental importância a existencia de um sistema de controle das emissões dos documentos do DEAME, bem como a organização das datas para a realização de provas de blaster e material para consulta para realização de fiscalizações.

Deste modo, para melhor atendimento à população e melhor desenvolvimento das atividade policiais judiciárias do DEAME, este Sistema está sendo desenvolvido.

## Tecnologia a ser utilizada

Este sistema será desenvolvido com a utilização, a princípio, das seguintes tecnologias:

* Linguagem de Programação PHP;
* Framework Laravel;
* Banco de dados MySQL;
* Banco de dados Redis;
* Armazenamento de arquivos MinIO;
* Tailwind CSS;
* AlpineJS;
* Docker (Sail).

## Forma de uso para desenvolvimento

Para fazer a utilização deste código para desenvolvimento, o primeiro passo a ser dado é realizar o clone deste projeto:

Obs.: Este projeto inicia-se privado, portanto é necessário que o interessado tenha acesso prévio a este repositório.

```
git clone git@github.com:GRClaudioDev/SysDEAME.git
```

Após a clonagem do repositório, realizar a instalação dos componentes necessários para desenvolvimento.

```
./sail up -d
./sail composer install
./sail npm install
./sail npm run build
```

Caso prefira, pode ser criado o alias para o comando sail que será útil para o desenvolvimento de todos os aplicativos com Laravel Sail.

Neste caso, deverá ser acrescentado a seguinte linha no seu arquivo de configuração shell, normalmente o ~/.zshrc ou ~/.bashrc.


```
alias sail='bash $([ -f sail ] && echo sail || echo vendor/bin/sail)'
```

Não se esqueça de reiniciar o seu shell após esta alteração.

Caso já tenha feito este procedimento anteriomente, seguindo as orientações na documentação do próprio laravel e tenha encontrado um erro na execução do arquivo, no seu comando alias onde troque a palavra sh por bash, para que o comando fique como o mostrado acima.

## Alterações no Script Sail

Alteração do comando open para abrir navegador utilizando o navegador do windows quando usando o WSL2.

Antes de rodar os comandos sail, se não houver um arquivo de configurações .env e existir o arquivo de .env.example, será informado da ausencia do arquivo de confirguração e será perguntado se deseja criar um novo arquivo de configuração com base no .env.example. Após a criação do mesmo, será perguntado se deseja executar o comando sail install, para instalar as dependencias do projeto (composer install, key:generate, npm install e npm run build).

Foi criado o comando install para instalar as dependências do projeto (composer install, key:generate, npm install e npm run build).

O comando up inicia os container já em modo desatachado, não sendo necessário utilizar o parametro -d.

O commando stop finaliza os containers baixando e escluindo eles, como se utilizado o comando sail down.

O fomando force executa os comando seguintes direto no docker compose.

O comando ds inicia o servidor LaraDumps.

O comando stan inicia o verificador de código LaraStan.
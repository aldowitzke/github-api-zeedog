# ZeeDog

Essa é uma API criada para o desafio técnico da ZeeDog, onde o principal objetivo é realizar requisições na API do Github, podendo utilizar filtros de linguagens, usuários, *stars*, *forks*, *sorts* e *orders*.

A aplicação foi construída utilizando as seguintes ferramentas:

- [Ruby on Rails](https://rubyonrails.org/)
- [HTTParty](https://github.com/jnunemaker/httparty)
- [RSpec](https://rspec.info/)

## Começando

### Heroku

O projeto está no Heroku e você pode fazer as requisições a partir da base_url https://github-api-zeedog.herokuapp.com/v1 (doc mais abaixo)

### Local

Para instalar o projeto, rode os seguintes códigos no seu terminal dentro do seu dirétorio de projetos:
```
1) Abra seu terminal e clone o projeto:
git clone https://github.com/aldowitzke/github-api-zeedog.git
# É possível que seja pedido suas credenciais para clonar o repositório

2) Entre no novo diretório criado
cd github-api-zeedog

3) Vamos instalar as gems:
bundle install

4) Atualize o arquivo config/database.yml com suas credenciais do postgres local

5) Rode o servidor:
rails server

6) Para rodar os testes:
rspec
```

## Realizando requisições

### GET /authorization

Primeiramente, é necessário fazer uma requisição para o endpoint de authorizations para receber um token JWT

```
curl --location --request GET 'localhost:3000/v1/authorization'
```
Exemplo de response:
```
Status: 200 OK
eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhbGRvd2l0emtlIiwiZXhwIjoxNjI5OTA3MzQyfQ.Fs0UO5bWcJTeCNnCWALrWYmbRNvzE5Z5JVt6WCTOHtg
```

### GET /repositories

Utilize o token gerado no endpoint anterior passando no header Authorization. 
Você tem a possibilidade de filtrar os repositórios utilizando os seguintes query params:

| Parâmetro  | Descrição  |  
|------------|------------|
|free_text|Campo de texto livre|
| language   |Linguagem principal dos repositórios (caso nenhuma for inserida, o padrão é Ruby)| 
| user | Repositórios públicos de determinado usuário|
|    sort    |Realizar sort por stars, forks ou updated             |   
|      order      |      asc ou desc     |   
| page | Página que será buscada|
| per_page| Número de repositórios por página |

Exemplo de requisição (alterar o JWT token para o recebido na ultima requisição do /authorization)

```
curl --location --request GET 'localhost:3000/v1/repositories?sort=stars&order=desc&page=1&per_page=10' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhbGRvd2l0emtlIiwiZXhwIjoxNjI5OTA3MzQyfQ.Fs0UO5bWcJTeCNnCWALrWYmbRNvzE5Z5JVt6WCTOHtg'
```
Exemplo de response

```
{
    "page": "1",
    "data": [
        {
            "full_name": "rails/rails",
            "description": "Ruby on Rails",
            "stargazers_count": 48906,
            "forks_count": 19641,
            "author_name": "rails"
        },
        {
            "full_name": "jekyll/jekyll",
            "description": ":globe_with_meridians: Jekyll is a blog-aware static site generator in Ruby",
            "stargazers_count": 43209,
            "forks_count": 9504,
            "author_name": "jekyll"
        },
    ...
    ]
}
 
```

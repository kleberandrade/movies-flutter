# Revisão do tutorial no Medium

Artigo próprio: [Criando um aplicativo em Flutter para consumir uma API de Filmes (TMDb)](https://medium.com/flutter-comunidade-br/criando-um-aplicativo-em-flutter-para-consumir-uma-api-de-filmes-tmdb-2b5a9982bfcd).

Em 17/11/2026, o artigo real foi aberto e lido no navegador autenticado. O menu da conta de Kleber Andrade expôs **Edit story**. Após validar o código, a revisão foi salva com **Save and publish**. A página pública voltou com o aviso **Your changes have been published.**, e a seção **Atualização prática — novembro de 2026** foi conferida no artigo publicado. A URL e a identidade `2b5a9982bfcd`, o título, o idioma e a finalidade didática foram preservados. Nenhuma newsletter, e-mail ou mensagem a seguidores foi enviada.

## Conteúdo atualizado

- Flutter 3.41.9, Dart 3.11.5/null safety, Dio 5.11.1, flutter_svg 2.3.4, cupertino_icons 1.0.9 e dependências de teste do manifesto atual; remoção de dartz/intl.
- Clone, dependências com lockfile, execução Chrome, configuração por arquivo local ignorado, análise, testes e build/servidor Web.
- Exemplo compatível de `Movie.fromJson`, origem local fictícia dos doze filmes e roteiro para experimentar busca, detalhes, vazio e paginação.
- Caminhos atuais de domínio, repositórios, estado e widgets; validação de entradas, `Duration`, `DioException`, respostas antigas descartadas, retry e deduplicação.
- Autenticação Bearer com token próprio, retirada de credenciais do código atual e necessidade de revogação das já expostas no histórico. Explicação de que parâmetros de compilação não protegem segredos em clientes distribuídos.
- Endpoints atuais e links oficiais de autenticação/condições. Corrigidas também as duas explicações antigas que tratavam TMDB como API de código aberto/uso irrestrito.
- Limites honestos: testes com fixture/adaptador não demonstram API real nem teste em telefone. A seção registra os 23 testes, análise e Web validados.
- Exercícios novos de domínio/estado/acessibilidade. Vídeos, referências, imagens, créditos e exercícios originais ficaram sob **Arquivo didático de 2020**, com aviso explícito sobre Dart 2/Dio 3, classes substituídas e credenciais antigas. Não se alteraram materiais de terceiros.

O README e `docs/validation.md` registram a verificação completa dos builds nativos e da interface Web. A captura comprobatória da publicação foi preservada no resultado local da tarefa; não foi incluída no repositório por mostrar elementos da conta do navegador.

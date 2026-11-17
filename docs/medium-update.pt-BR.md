# Revisão completa do tutorial no Medium

Artigo próprio: [Criando um aplicativo em Flutter para consumir uma API de Filmes (TMDb)](https://medium.com/flutter-comunidade-br/criando-um-aplicativo-em-flutter-para-consumir-uma-api-de-filmes-tmdb-2b5a9982bfcd).

Em 17/11/2026, a revisão completa substituiu o corpo antigo por uma aula contínua em português. O título, a autoria, a URL e a identidade `2b5a9982bfcd` foram preservados. Não foram enviados e-mails, newsletters nem mensagens a seguidores. A publicação anterior, que acrescentava uma atualização antes das notas históricas, foi substituída por esta edição integral.

## Texto, código e versões

A aula tem objetivos de aprendizagem, pré-requisitos e nove etapas: experimentar o aplicativo, compreender dependências, separar responsabilidades, validar JSON, injetar repositórios, controlar concorrência/paginação, apresentar estados acessíveis, configurar TMDB e executar verificações.

As versões publicadas correspondem ao projeto atual: Flutter **3.50.0**, Dart **3.14.0**, Dio **5.11.1**, flutter_svg **2.4.0**, cupertino_icons **2.0.0**, material_ui **1.11.1**, flutter_lints **6.0.0** e flutter_test do SDK. O texto explica a migração para Material independente e os três limites transitivos de material_color_utilities, test_api e xml, sem afirmar que foram atualizados além das restrições dos mantenedores. A auditoria está em `docs/dependencies.md` e `docs/dependency-audit.json`.

Os códigos são texto copiável, com caminhos reais, contexto dos trechos, contrato do repositório, configuração Dio com Duration, método de busca e comandos atualizados. O exemplo completo `example/parse_movie.dart` foi executado e produz `Exemplo local • 8.0/10 • Sem data`. O pequeno programa imprime esse resultado intencionalmente; sua única exceção de lint é `avoid_print`, restrita à instrução de impressão do exemplo, sem silenciar erros de compilação.

As notas, referências, vídeos e exercícios da edição de 2020 permanecem no arquivo histórico ligado no artigo, sem duplicar instruções obsoletas na aula atual. Permanecem créditos dos materiais de terceiros e a referência a Cine Collection, de Letícia Ellen Bernardo.

## Capa e imagens

A capa nova é uma ilustração editorial criada com IA, salva em `docs/media/medium-cover.png`. Ela não representa uma tela ou dados reais do TMDB. Os prompts e a edição que retirou um emblema não solicitado estão documentados em `docs/media/README.md`.

Duas capturas reais foram feitas novamente com o Web build atual: catálogo e detalhes em largura de celular. Foram enviadas ao Medium pelo seletor nativo de arquivos após o upload pela extensão falhar. Nenhuma permissão do navegador foi modificada. As três imagens têm texto alternativo, distinguindo explicitamente ilustração, captura de navegador e dados fictícios.

Após salvar com **Save and publish**, a página pública foi aberta novamente. Foram conferidos:

- Título/autoria/URL preservados e texto atual com Flutter 3.50.0 / Dart 3.14.0.
- Capa nova carregada e também usada em `og:image`, a imagem da prévia de compartilhamento: `1*1l6GLys1GNrfGdNZ74yRxg.png`.
- Catálogo carregado: `1*yWiQUpBiJBY8NqC1Q-0THQ.jpeg`.
- Detalhes carregados: `1*rFRPaGBhuGGjaKg8sP-0kA.jpeg`.
- Ausência dos marcadores temporários de inserção de imagens.
- Última seção didática com **exatamente cinco exercícios**, verificada no conteúdo público.

## Cinco exercícios finais

1. Validar um novo campo no modelo, fixture, detalhes e testes.
2. Melhorar a busca local para caixa/acentos, sem misturar API e exemplos.
3. Criar uma lista pessoal persistente e sem IDs duplicados.
4. Demonstrar falha e recuperação da próxima página preservando os itens.
5. Comparar duas apresentações acessíveis, com teclado e texto a 200%.

Cada exercício publicado inclui um critério observável de conferência. Nenhum texto didático foi acrescentado depois dessa lista.

A cópia local do conteúdo e das imagens está em `docs/medium-tutorial.pt-BR.html`. Capturas da página publicada foram preservadas no resultado local da tarefa; não entram no Git por conterem elementos da conta do navegador. A demonstração continua identificada como fictícia, sem alegar integração real com TMDB ou teste em aparelho físico.

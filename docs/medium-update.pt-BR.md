# Revisão completa do tutorial no Medium

Artigo próprio: [Criando um aplicativo em Flutter para consumir uma API de Filmes (TMDb)](https://medium.com/flutter-comunidade-br/criando-um-aplicativo-em-flutter-para-consumir-uma-api-de-filmes-tmdb-2b5a9982bfcd).

Em 17/11/2026, a revisão completa substituiu o corpo antigo por uma aula contínua em português. O título, a autoria, a URL e a identidade `2b5a9982bfcd` foram preservados. Não foram enviados e-mails, newsletters nem mensagens a seguidores. A publicação anterior, que acrescentava uma atualização antes das notas históricas, foi substituída por esta edição integral.

## Atualização posterior: pôsteres locais

A edição seguinte, também em 17/11/2026, publicou os pôsteres SVG originais incluídos no aplicativo para todos os doze filmes fictícios. O texto explica `poster_asset`, a validação exclusiva de `Movie.fromDemoJson`, o uso de `SvgPicture.asset`, a declaração de `flutter.assets` e a diferença entre recursos locais e cache offline do navegador. O bloco novo foi configurado como YAML e conferido na página pública, preservando indentação e caminhos. A suíte atual tem **25 testes**.

As quatro capturas do repositório foram refeitas a partir do build Web atual. Duas foram enviadas pelo seletor de arquivos do navegador integrado e publicadas no mesmo artigo, com novas descrições alternativas:

- Catálogo: `1*8-LE89tP7SQN4DF8aTCB2Q.jpeg`.
- Detalhes em **390 × 844**: `1*esqQfJBDDj2Zr0pjIa2gHg.jpeg`.

Depois de **Save and publish**, a página pública foi recarregada. Foram confirmados os dois novos endereços de imagem com conteúdo carregado, o texto atualizado, as nove etapas, o bloco YAML e exatamente cinco itens na última seção didática. A capa editorial continua sendo `1*1l6GLys1GNrfGdNZ74yRxg.png`, inclusive em `og:image`. A prova visual desta publicação foi salva fora do Git em `medium-local-posters.jpg`. As seções abaixo registram a revisão integral anterior.

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

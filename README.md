# Movies Flutter

[![Language: Dart](https://img.shields.io/badge/Language-Dart-0175C2)](https://github.com/kleberandrade/movies-flutter/blob/main/pubspec.yaml)
[![Framework: Flutter](https://img.shields.io/badge/Framework-Flutter-02569B)](https://github.com/kleberandrade/movies-flutter/blob/main/pubspec.yaml)

Flutter classroom movie-list application using the TMDb API.

## Getting started

- Select a Flutter release whose bundled Dart SDK satisfies the manifest constraint, then run the commands below from the repository root.

```sh
flutter pub get
flutter run
```

- If the app depends on Firebase or another external service, configure your own service project using the dependencies and original notes; credentials are not supplied by this guide.

## Recorded requirements

- Dart SDK constraint from [`pubspec.yaml`](https://github.com/kleberandrade/movies-flutter/blob/main/pubspec.yaml): `>=2.7.0 <3.0.0`.

## Repository map

- [lib](https://github.com/kleberandrade/movies-flutter/tree/main/lib)
- [test](https://github.com/kleberandrade/movies-flutter/tree/main/test)
- [android](https://github.com/kleberandrade/movies-flutter/tree/main/android)
- [ios](https://github.com/kleberandrade/movies-flutter/tree/main/ios)

## Validation status

This update documents the tracked source and project metadata. It does not certify a successful build, device test or compatibility with a current toolchain. Follow any project-specific validation instructions in the original material.

## License and attribution

No standalone repository-wide license file was identified in this review. Preserve the original credits and any component-specific licenses; this documentation update grants no additional rights.

---

## Original project material

# Filmes (Movies)

Aplicativo de lista de filmes utilizando a API do [TMDb](https://www.themoviedb.org/?language=pt-BR) criado para disciplina de Programação Mobile, criado por Kleber de Oliveira Andrade

Tutorial de criação deste app: [clique aqui](https://kleberandrade.medium.com/criando-um-aplicativo-em-flutter-para-consumir-uma-api-de-filmes-tmdb-2b5a9982bfcd)

<p align="center">
    <img src="https://miro.medium.com/max/334/1*QWNFydDZqp2Y12UDsRROHQ.png" width="250"/>
    <img src="https://miro.medium.com/max/334/1*zk7ckxu63R3zKAGdUdUAbg.png" width="250"/>
    <img src="https://miro.medium.com/max/334/1*SpoH2wRV3jNAuCk1Hz4EzQ.png" width="250"/>
</p>

## Como clonar o projeto

*   Faça um fork do projeto (precisa ter uma conta no github)
*   Abra o terminal do Visual Studio Code
*   Acesse a pasta onde deseja salvar o aplicativo e digite: git clone *link_do_projeto_no_seu_github* **movies**
*   Clique em File --> Open e abra o projeto
*   Não se esqueça de abrir o arquivo *pubspec.yaml* e salvar (CTRL + S) o arquivo para que os plugins sejam baixados 

## Desafio para aula

*   [ ] Adicionar um [ícone](https://pub.dev/packages/flutter_launcher_icons) e uma [tela de splash](https://pub.dev/packages/custom_splash) para o aplicativo;
*   [ ] Na MovieDetailPage adicionar pelo menos 2 novas informaçoes;
*   [ ] Criar um [IconButton na AppBar](https://medium.com/flutterpub/playing-with-appbar-in-flutter-3a8abd9b982a) que altere o crossAxisCount do GridView entre 2 e 3. Nao se esqueçam do setState;
*   [ ] Trocar a lógica do ScrollController por [InfiniteScrollPagination](https://pub.dev/packages/infinite_scroll_pagination);
*   [ ] Utilizar [FancyShimmerImage](https://pub.dev/packages/fancy_shimmer_image) para os posters (MoviePage) e banners (MovieDetailPage);

## Licença

    Copyright 2020 Kleber de Oliveira Andrade
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

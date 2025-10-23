É uma excelente ideia documentar o uso do seu gerador de *features*\! Isso facilita muito para qualquer pessoa (ou você mesmo no futuro) começar a usá-lo rapidamente em diferentes sistemas operacionais.

Aqui está um modelo de `README.md` completo:

-----

# 🛠️ Gerador de Estrutura de Feature (Clean Architecture)

Este `Makefile` automatiza a criação de um módulo ou *feature* completo, seguindo uma estrutura de Clean Architecture (Domain, Infra, External, Presentation), economizando tempo e garantindo a consistência do código.

## 🚀 Como Utilizar o Gerador

O comando principal para gerar uma nova *feature* é `make feature`. Você deve sempre passar o nome da *feature* através da variável `FEATURE`.

### Comando Principal

```bash
make feature FEATURE=<nome_da_feature_em_snake_case>
```

**Exemplo:**

Para criar a feature chamada `autenticacao`, use:

```bash
make feature FEATURE=autenticacao
```

**Saída esperada:** A estrutura de pastas e arquivos (`autenticacao_entity.dart`, `autenticacao_cubit.dart`, `autenticacao_page.dart`, etc.) será criada dentro de `lib/feature/autenticacao`.

-----

## 💻 Configuração do Ambiente (macOS, Linux e Windows)

O `make` e os comandos de *shell* usados neste `Makefile` são nativos em sistemas Unix, mas requerem um ambiente especial no Windows.

### 🐧 macOS e Linux (Recomendado)

O utilitário `make` e o ambiente de execução Bash já vêm instalados.

1.  Abra seu Terminal (`Bash`, `Zsh` ou outro).
2.  Navegue até a pasta onde o arquivo `Makefile` se encontra.
3.  Execute o comando normalmente.

**Exemplo:**

```bash
cd /caminho/do/seu/projeto
make feature FEATURE=login
```

### 🪟 Windows (Usando Git Bash)

O ambiente padrão do Windows (`Prompt de Comando` ou `PowerShell`) **não** reconhece o comando `make` nem os comandos de *shell* (`mkdir -p`, `echo`, `if [...]`) usados no `Makefile`.

A solução padrão é usar o **Git Bash**, que é instalado juntamente com o Git.

1.  **Instale o Git** se ainda não o tiver.
2.  Clique com o botão direito na pasta raiz do seu projeto e selecione **"Git Bash Here"**.
3.  O terminal Git Bash será aberto. **Use-o** para rodar todos os comandos `make`.

**Exemplo (no Git Bash):**

```bash
make feature FEATURE=cadastro_cliente
```

-----

## 📂 Estrutura Gerada

O gerador cria a seguinte hierarquia de arquivos com *templates* Dart, usando a primeira letra capitalizada (`[Feature]`) em nomes de classes:

```
lib/v2/feature/[FEATURE]/
├── domain/
│   ├── entities/
│   │   └── [feature]_entity.dart (class [Feature]Entity)
│   ├── repositories/
│   │   └── [feature]_repository.dart (abstract class [Feature]Repository)
│   └── usecase/
│       └── get_[feature]_usecase.dart (class Get[Feature]Usecase implements Usecase...)
├── external/
│   ├── datasources/
│   │   └── [feature]_datasource_impl.dart (class [Feature]DatasourceImp)
│   └── error/
│       └── [feature]_error.dart (class [Feature]Error extends Failure)
├── infra/
│   ├── datasources/
│   │   └── [feature]_datasource.dart (abstract class [Feature]Datasource)
│   ├── model/
│   │   └── [feature]_model.dart (class [Feature]Model extends [Feature]Entity)
│   └── repositories/
│       └── [feature]_repository_imp.dart (class [Feature]ReositoryImp implements [Feature]Repository)
└── presentation/
    ├── controller/
    │   ├── [feature]_cubit.dart (class [Feature]Cubit)
    │   └── [feature]_state.dart (abstract class [Feature]State)
    ├── page/
    │   └── [feature]_page.dart (StatefulWidget usando CopelBodyBase)
    └── resources/
        └── [feature]_string.dart (class [Feature]Strings)
```

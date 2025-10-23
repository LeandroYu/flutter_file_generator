# -----------------------------------------------------------
# GERADOR DE ARQUIVOS DE FEATURE (CLEAN ARCHITECTURE)
# -----------------------------------------------------------

# -----------------------------------------------------------
# VARIÁVEIS DE CONFIGURAÇÃO
# -----------------------------------------------------------
FEATURE ?= feature_padrão
DIRETORIO_RAIZ_FEATURES = lib/feature
DIRETORIO_FINAL = $(DIRETORIO_RAIZ_FEATURES)/$(FEATURE)

SUBPASTAS = \
    domain/entities \
    domain/enum \
    domain/repositories \
    domain/usecase \
    external/datasources \
    external/error \
    infra/datasources \
    infra/model \
    infra/repositories \
    presentation/controller \
    presentation/page \
    presentation/resources \
    presentation/widget

EXTENSAO = .dart

# Variável de capitalização da primeira letra (exige shell tools: cut, tr)
FEATURE_CAPITALIZADA = $(shell echo $(FEATURE) | cut -c1 | tr '[:lower:]' '[:upper:]')$(shell echo $(FEATURE) | cut -c2-)

# -----------------------------------------------------------
# REGRAS PRINCIPAIS E ENCADEMAMENTO
# -----------------------------------------------------------

.PHONY: feature criar_pastas criar_arquivos criar_domain criar_infra criar_external criar_presentation

feature:
	@if [ "$(FEATURE)" = "feature_padrão" ]; then \
		echo "ERRO: O nome do módulo não foi fornecido ou é o valor padrão."; \
		echo "Uso correto: make feature FEATURE=NOME_DA_FEATURE"; \
		exit 1; \
	fi
	
	@echo "--- Iniciando Criação do Módulo $(FEATURE) ---"
	@$(MAKE) criar_pastas FEATURE=$(FEATURE)
	@$(MAKE) criar_arquivos FEATURE=$(FEATURE)

	@echo "========================================================"
	@echo "FEATURE: $(FEATURE)"
	@echo "Estrutura completa criada com sucesso em: $(DIRETORIO_FINAL)"
	@echo "========================================================"

# --- Criação de Pastas ---
criar_pastas:
	@mkdir -p $(DIRETORIO_FINAL)
	@echo "Diretório raiz '$(DIRETORIO_FINAL)' criado/garantido."
	@for dir in $(SUBPASTAS); do \
		mkdir -p $(DIRETORIO_FINAL)/$$dir; \
		echo "Subpasta: $${dir} criada."; \
	done

# --- Regra Encadeadora de Criação de Arquivos ---
criar_arquivos: criar_domain criar_infra criar_external criar_presentation
	@echo "Todos os templates de arquivos foram gerados."

# -----------------------------------------------------------
# REGRAS MODULARIZADAS
# -----------------------------------------------------------

criar_domain:
	@echo "-> Gerando arquivos DOMAIN..."
	
	# [FEATURE]_entity.dart
	@echo "class $(FEATURE_CAPITALIZADA)Entity{}" > $(DIRETORIO_FINAL)/domain/entities/$(FEATURE)_entity$(EXTENSAO)

	# [FEATURE]_repository.dart (Interface)
	@echo "abstract class $(FEATURE_CAPITALIZADA)Repository{}" > $(DIRETORIO_FINAL)/domain/repositories/$(FEATURE)_repository$(EXTENSAO)
	
	# get_[FEATURE]_usecase.dart (Estrutura completa)
	@printf "import 'package:dartz/dartz.dart';\n\nimport '../../../../shared/domain/errors/errors.dart';\nimport '../../../../shared/domain/usecases/usecase.dart';\n\nclass Get$(FEATURE_CAPITALIZADA)Usecase implements Usecase<void, Either<void, Failure>>{\n  @override\n  Future<Either<void, Failure>> call({required void params}) {\n    // TODO: implement call\n    throw UnimplementedError();\n  }\n}" > $(DIRETORIO_FINAL)/domain/usecase/get_$(FEATURE)_usecase$(EXTENSAO)

criar_infra:
	@echo "-> Gerando arquivos INFRA..."

	# [FEATURE]_model.dart (Model/DTO)
	@printf "import '../../domain/entities/$(FEATURE)_entity$(EXTENSAO)';\n\nclass $(FEATURE_CAPITALIZADA)Model extends $(FEATURE_CAPITALIZADA)Entity{}" > $(DIRETORIO_FINAL)/infra/model/$(FEATURE)_model$(EXTENSAO)

	# [FEATURE]_repository_imp.dart
	@printf "import '../../domain/repositories/$(FEATURE)_repository$(EXTENSAO)';\n\nclass $(FEATURE_CAPITALIZADA)ReositoryImp implements $(FEATURE_CAPITALIZADA)Repository{}" > $(DIRETORIO_FINAL)/infra/repositories/$(FEATURE)_repository_imp$(EXTENSAO)
	
	# [FEATURE]_datasource.dart (Interface do Datasource)
	@echo "abstract class $(FEATURE_CAPITALIZADA)Datasource{}" > $(DIRETORIO_FINAL)/infra/datasources/$(FEATURE)_datasource$(EXTENSAO)

criar_external:
	@echo "-> Gerando arquivos EXTERNAL..."

	# [FEATURE]_datasource_impl.dart (Implementação do Datasource)
	@printf "import '../../infra/datasources/$(FEATURE)_datasource$(EXTENSAO)';\n\nclass $(FEATURE_CAPITALIZADA)DatasourceImp implements $(FEATURE_CAPITALIZADA)Datasource{}" > $(DIRETORIO_FINAL)/external/datasources/$(FEATURE)_datasource_impl$(EXTENSAO)

	# [FEATURE]_error.dart (Exceção Específica)
	@printf "import '../../../../shared/domain/errors/errors.dart';\n\nclass $(FEATURE_CAPITALIZADA)Error extends Failure{}" > $(DIRETORIO_FINAL)/external/error/$(FEATURE)_error$(EXTENSAO)

criar_presentation:
	@echo "-> Gerando arquivos PRESENTATION..."
	
	# [FEATURE]_page.dart (StatefulWidget)
	@printf "import 'package:flutter/material.dart';\n\nimport '../../../../shared/presentation/widgets/copel_body_base.dart';\n\nclass $(FEATURE_CAPITALIZADA)Page extends StatefulWidget {\n  const $(FEATURE_CAPITALIZADA)Page({super.key});\n\n  @override\n  State<$(FEATURE_CAPITALIZADA)Page> createState() => _$(FEATURE_CAPITALIZADA)PageState();\n}\n\nclass _$(FEATURE_CAPITALIZADA)PageState extends State<$(FEATURE_CAPITALIZADA)Page> {\n  @override\n  Widget build(BuildContext context) {\n    return const CopelBodyBase(\n      body: [],\n    );\n  }\n}" > $(DIRETORIO_FINAL)/presentation/page/$(FEATURE)_page$(EXTENSAO)

	# [FEATURE]_cubit.dart
	@printf "import 'package:flutter_bloc/flutter_bloc.dart';\n\nimport '$(FEATURE)_state$(EXTENSAO)';\n\nclass $(FEATURE_CAPITALIZADA)Cubit extends Cubit<$(FEATURE_CAPITALIZADA)State>{\n  $(FEATURE_CAPITALIZADA)Cubit(super.initialState);\n}" > $(DIRETORIO_FINAL)/presentation/controller/$(FEATURE)_cubit$(EXTENSAO)
	
	# [FEATURE]_state.dart
	@echo "abstract class $(FEATURE_CAPITALIZADA)State{}" > $(DIRETORIO_FINAL)/presentation/controller/$(FEATURE)_state$(EXTENSAO)
	
	# [FEATURE]_string.dart
	@echo "class $(FEATURE_CAPITALIZADA)Strings{}" > $(DIRETORIO_FINAL)/presentation/resources/$(FEATURE)_string$(EXTENSAO)

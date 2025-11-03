MAKEFLAGS 				+= --warn-undefined-variables
SHELL 					:= bash
.DEFAULT_GOAL			:= help
URIBASE					:=	http://purl.obolibrary.org/obo
TMP_DATA				:=	data/tmp

ROOT_DIR				:=	$(shell pwd)

PHENOTYPE_DIR			:= $(ROOT_DIR)/data/phenotype
RUNNERS_DIR				:= $(ROOT_DIR)/runners
NAME					:= $(shell python -c 'import tomli; print(tomli.load(open("pyproject.toml", "rb"))["tool"]["poetry"]["name"])')
VERSION					:= $(shell python -c 'import tomli; print(tomli.load(open("pyproject.toml", "rb"))["tool"]["poetry"]["version"])')
SEMSIM_BASE_URL			:= https://storage.googleapis.com/data-public-monarchinitiative/semantic-similarity/latest



help: info
	@echo ""
	@echo "help"
	@echo "make setup -- this runs the download and extraction of genomic, phenotypic and runners data"
	@echo "make pheval -- this runs pheval pipeline corpus preparation and run"
	@echo "make all -- this runs the entire pipeline including setup, corpus preparation and pheval run"
	@echo "make help -- show this help"
	@echo ""

info:
	@echo "Project: $(NAME)"
	@echo "Version: $(VERSION)"

.PHONY: prepare-inputs






configurations/exomiser-13.3.0/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/













configurations/exomiser-14.0.0/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype || cp -rf $(PHENOTYPE_DIR)/2402_phenotype $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-14.0.0-2402_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_hg19 || ln -s $(PHENOTYPE_DIR)/2402_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_hg38 || ln -s $(PHENOTYPE_DIR)/2402_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype || ln -s $(RUNNERS_DIR)/exomiser-14.0.0/* $(ROOT_DIR)/$(shell dirname $@)/









SQL_DEPENDENCIES_S01 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql 

configurations/S01/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_S01)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/S01/config.yaml






SQL_DEPENDENCIES_S02 = $(TMP_DATA)/semsim/phenio-equivalent-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-equivalent-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-equivalent-hp-zp.0.4.semsimian.sql 

configurations/S02/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_S02)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-equivalent-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-equivalent-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-equivalent-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/S02/config.yaml






SQL_DEPENDENCIES_S03 = $(TMP_DATA)/semsim/phenio-flat-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-flat-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-flat-hp-zp.0.4.semsimian.sql 

configurations/S03/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_S03)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-flat-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-flat-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-flat-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/S03/config.yaml






SQL_DEPENDENCIES_S04 = $(TMP_DATA)/semsim/phenio-release-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-release-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-release-hp-zp.0.4.semsimian.sql 

configurations/S04/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_S04)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-release-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-release-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-release-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/S04/config.yaml






SQL_DEPENDENCIES_C01 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql 

configurations/C01/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_C01)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/C01/config.yaml






SQL_DEPENDENCIES_C02 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql 

configurations/C02/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_C02)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/C02/config.yaml






SQL_DEPENDENCIES_C05 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql 

configurations/C05/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_C05)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/C05/config.yaml






SQL_DEPENDENCIES_I01 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.7.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.7.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.7.semsimian.sql 

configurations/I01/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_I01)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.7.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.7.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.7.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/I01/config.yaml






SQL_DEPENDENCIES_I02 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.ic.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.ic.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.ic.sql 

configurations/I02/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_I02)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.ic.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.ic.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.ic.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/I02/config.yaml




.PHONY: prepare-corpora


$(TMP_DATA)/semsim/%.tsv:
	mkdir -p $(TMP_DATA)/semsim/
	wget $(SEMSIM_BASE_URL)/$*.tsv -O $@


$(TMP_DATA)/semsim/%.sql:
	mkdir -p $(TMP_DATA)/semsim/
	wget $(SEMSIM_BASE_URL)/$*.sql -O $@



    

    

    

    

    

    

    

    

    

    

    



$(ROOT_DIR)/results/exomiser-13.3.0-lirical-default/results.yml: configurations/exomiser-13.3.0/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-14.0.0-lirical-default/results.yml: configurations/exomiser-14.0.0/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-14.0.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 14.0.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-14.0.0-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-14.0.0/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg



$(ROOT_DIR)/results/C01-lirical-default/results.yml: configurations/C01/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/C01 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/C01-lirical-default/results.yml




#$(ROOT_DIR)/results/C01/gene_rank_stats.svg: $(ROOT_DIR)/results/C01/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/C01/gene_rank_stats.svg



$(ROOT_DIR)/results/C02-lirical-default/results.yml: configurations/C02/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/C02 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/C02-lirical-default/results.yml




#$(ROOT_DIR)/results/C02/gene_rank_stats.svg: $(ROOT_DIR)/results/C02/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/C02/gene_rank_stats.svg



$(ROOT_DIR)/results/C05-lirical-default/results.yml: configurations/C05/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/C05 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/C05-lirical-default/results.yml




#$(ROOT_DIR)/results/C05/gene_rank_stats.svg: $(ROOT_DIR)/results/C05/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/C05/gene_rank_stats.svg



$(ROOT_DIR)/results/S01-lirical-default/results.yml: configurations/S01/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S01 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S01-lirical-default/results.yml




#$(ROOT_DIR)/results/S01/gene_rank_stats.svg: $(ROOT_DIR)/results/S01/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S01/gene_rank_stats.svg



$(ROOT_DIR)/results/S02-lirical-default/results.yml: configurations/S02/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S02 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S02-lirical-default/results.yml




#$(ROOT_DIR)/results/S02/gene_rank_stats.svg: $(ROOT_DIR)/results/S02/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S02/gene_rank_stats.svg



$(ROOT_DIR)/results/S03-lirical-default/results.yml: configurations/S03/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S03 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S03-lirical-default/results.yml




#$(ROOT_DIR)/results/S03/gene_rank_stats.svg: $(ROOT_DIR)/results/S03/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S03/gene_rank_stats.svg



$(ROOT_DIR)/results/S04-lirical-default/results.yml: configurations/S04/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S04 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S04-lirical-default/results.yml




#$(ROOT_DIR)/results/S04/gene_rank_stats.svg: $(ROOT_DIR)/results/S04/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S04/gene_rank_stats.svg



$(ROOT_DIR)/results/I01-lirical-default/results.yml: configurations/I01/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/I01 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/I01-lirical-default/results.yml




#$(ROOT_DIR)/results/I01/gene_rank_stats.svg: $(ROOT_DIR)/results/I01/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/I01/gene_rank_stats.svg



$(ROOT_DIR)/results/I02-lirical-default/results.yml: configurations/I02/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/I02 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/I02-lirical-default/results.yml




#$(ROOT_DIR)/results/I02/gene_rank_stats.svg: $(ROOT_DIR)/results/I02/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/I02/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-phenopacket-store-default/results.yml: configurations/exomiser-13.3.0/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-14.0.0-phenopacket-store-default/results.yml: configurations/exomiser-14.0.0/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-14.0.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 14.0.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-14.0.0-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-14.0.0/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg



$(ROOT_DIR)/results/C01-phenopacket-store-default/results.yml: configurations/C01/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/C01 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/C01-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/C01/gene_rank_stats.svg: $(ROOT_DIR)/results/C01/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/C01/gene_rank_stats.svg



$(ROOT_DIR)/results/C02-phenopacket-store-default/results.yml: configurations/C02/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/C02 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/C02-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/C02/gene_rank_stats.svg: $(ROOT_DIR)/results/C02/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/C02/gene_rank_stats.svg



$(ROOT_DIR)/results/C05-phenopacket-store-default/results.yml: configurations/C05/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/C05 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/C05-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/C05/gene_rank_stats.svg: $(ROOT_DIR)/results/C05/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/C05/gene_rank_stats.svg



$(ROOT_DIR)/results/S01-phenopacket-store-default/results.yml: configurations/S01/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S01 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S01-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/S01/gene_rank_stats.svg: $(ROOT_DIR)/results/S01/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S01/gene_rank_stats.svg



$(ROOT_DIR)/results/S02-phenopacket-store-default/results.yml: configurations/S02/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S02 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S02-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/S02/gene_rank_stats.svg: $(ROOT_DIR)/results/S02/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S02/gene_rank_stats.svg



$(ROOT_DIR)/results/S03-phenopacket-store-default/results.yml: configurations/S03/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S03 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S03-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/S03/gene_rank_stats.svg: $(ROOT_DIR)/results/S03/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S03/gene_rank_stats.svg



$(ROOT_DIR)/results/S04-phenopacket-store-default/results.yml: configurations/S04/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/S04 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/S04-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/S04/gene_rank_stats.svg: $(ROOT_DIR)/results/S04/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/S04/gene_rank_stats.svg



$(ROOT_DIR)/results/I01-lirical-default/results.yml: configurations/I01/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/I01 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/I01-lirical-default/results.yml




#$(ROOT_DIR)/results/I01/gene_rank_stats.svg: $(ROOT_DIR)/results/I01/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/I01/gene_rank_stats.svg



$(ROOT_DIR)/results/I02-lirical-default/results.yml: configurations/I02/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/I02 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/I02-lirical-default/results.yml




#$(ROOT_DIR)/results/I02/gene_rank_stats.svg: $(ROOT_DIR)/results/I02/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/I02/gene_rank_stats.svg




corpora/lirical/default/corpus.yml:
	test -d $(ROOT_DIR)/corpora/lirical/default/ || mkdir -p $(ROOT_DIR)/corpora/lirical/default/

	test -L $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz
	pheval-utils create-spiked-vcfs \
		--hg19-template-vcf $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz  \
		--phenopacket-dir=$(ROOT_DIR)/corpora/lirical/default/phenopackets \
		--output-dir $(ROOT_DIR)/corpora/lirical/default/vcf
	touch $@





corpora/lirical/small_version/corpus.yml:
	test -d $(ROOT_DIR)/corpora/lirical/small_version/ || mkdir -p $(ROOT_DIR)/corpora/lirical/small_version/

	test -L $(ROOT_DIR)/corpora/lirical/small_version/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/small_version/template_exome_hg19.vcf.gz
	pheval-utils create-spiked-vcfs \
		--hg19-template-vcf $(ROOT_DIR)/corpora/lirical/small_version/template_exome_hg19.vcf.gz  \
		--phenopacket-dir=$(ROOT_DIR)/corpora/lirical/small_version/phenopackets \
		--output-dir $(ROOT_DIR)/corpora/lirical/small_version/vcf
	touch $@







corpora/phenopacket-store/default/corpus.yml: $(TMP_DATA)/all_phenopackets/all_phenopackets.zip
	mkdir -p corpora/phenopacket-store/default/phenopackets/
	pheval-utils prepare-corpus -p $(TMP_DATA)/all_phenopackets/unpacked_phenopackets --gene-analysis -g ensembl_id -o $(ROOT_DIR)/$(shell dirname $@)/
	touch $@
	#temporary
	touch $@




.PHONY: pheval
pheval:
	$(MAKE) prepare-inputs
	$(MAKE) prepare-corpora
	$(MAKE) pheval-run
	#$(MAKE) pheval-report

include ./resources/custom.Makefile

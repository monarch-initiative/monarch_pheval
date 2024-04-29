# monarch-pheval

[PhEval](https://github.com/monarch-initiative/pheval) Project Configuration-Base

- [monarch-pheval](#monarch-pheval)
  - [Dependency Graph](#dependency-graph)
  - [PhEval Config Structure](#pheval-config-structure)
  - [Configuring and Running an Experiment](#configuring-and-running-an-experiment)
    - [Installing dependencies](#installing-dependencies)
    - [Generating Makefile](#generating-makefile)
    - [Run the experiment](#run-the-experiment)
- [Acknowledgements](#acknowledgements)

## Dependency Graph

```mermaid
graph TD;
    A[monarch-pheval]---->C[pheval.exomiser];
    A[monarch-pheval]---->C1[pheval.phen2gene];
    A[monarch-pheval]---->C2[pheval.gado];
    C--Depends-->P[pheval];
    C1--Depends-->P[pheval];
    C2--Depends-->P[pheval];
    A--Depends-->P[pheval];
    %% S[setup];
    %% A--Depends-->S[setup];
    %% S---->D[Genotype];
    %% S---->E[Phenotype];
    %% S---->R[Runner];
    %% F[Download];
    %% G[Extract];
    %% R---->F
    %% D---->F
    %% E---->F
    %% F---->G
```

---

> - Straight line represents mandatory dependency;

---

With this new feature, the Makefile can be generated within this repo, and the user can invoke the make pheval goal based on the [pheval configuration file](resources/pheval-config.yaml).

## PhEval Config Structure

The corpora and configuration data were moved from [PhEval](https://github.com/monarch-initiative/pheval) to this new structure.

📦monarch-pheval  
┣ 📂corpora  
┃ ┣ 📂lirical  
┃ ┃ ┗ 📂default  
┃ ┃ ┃ ┣ 📂phenopackets  
┃ ┃ ┃ ┗ 📜corpus.yml  
┣ 📂resources  
┃ ┣ 📜Makefile.j2  
┃ ┣ 📜custom.Makefile  
┃ ┣ 📜generatemakefile.sh  
┃ ┗ 📜pheval-config.yaml

## Configuring and Running an Experiment

### Installing dependencies

```bash
poetry shell
poetry install
```

### Generating Makefile

```bash
./resources/generatemakefile.sh
```

### Run the experiment

```bash
make all
```

---

# Acknowledgements

This [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/README.html) project was developed from the [monarch-project-template](https://github.com/monarch-initiative/monarch-project-template) template and will be kept up-to-date using [cruft](https://cruft.github.io/cruft/).

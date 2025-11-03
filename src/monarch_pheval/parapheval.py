"""ParaPhEval."""

import logging
import os
import shutil
import subprocess
import time
from functools import partial
from pathlib import Path
from typing import Any, Dict, List

import yaml

# Set up logging
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    handlers=[logging.FileHandler("app.log"), logging.StreamHandler()],
)


def get_user_jobs() -> List:
    """

    get current user jobs list.

    Returns:
        List: list of jobs from current user

    """
    username = os.getenv("USER")
    command = f"squeue -u {username} -o '%A %j %T %M %l %R'"
    result = subprocess.run(command, capture_output=True, text=True, shell=True)
    if result.returncode != 0:
        logging.error(f"Error running squeue: {result.stderr}")
        return
    jobs = []
    for line in result.stdout.strip().split("\n")[1:]:
        job_id, name, state, time, time_limit, reason = line.split()
        jobs.append(
            {"job_id": job_id, "name": name, "state": state, "time": time, "time_limit": time_limit, "reason": reason}
        )
    return jobs


def check_last_job_running():
    """Wait for last job to be submitted."""
    jobs = get_user_jobs()
    last_job = jobs[-1]

    while last_job["state"] != "RUNNING":
        jobs = get_user_jobs()
        last_job = jobs[-1]
        logging.info("Waiting job to be submitted")
        time.sleep(5)
    return


def submit_job(id_corpus: str, template: Path, submitted_file: Path):
    """
    submit job to HPC cluster.

    Args:
        id_corpus (str): pheval run id and corpus id
        template (Path): job template file
        submitted_file (Path): name of file that will be created after job submission. it is useful to check.
        if this job have been submited before. when force flag is true this check will be ignored

    """
    shutil.copy(f"./jobs/{id_corpus}.Makefile", "./Makefile")
    cmd = f"sbatch {template}"
    logging.info(f"running {id_corpus}")
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        logging.error(f"Error running sbatch: {result.stderr}")
        return
    Path(submitted_file).touch(exist_ok=True)


def write_conf(filename: str, data: List):
    """
    write new yaml file.

    Args:
        filename (str): new yaml file that will be written
        data (List): configuration content

    """
    os.makedirs("./jobs", exist_ok=True)
    with open(f"./jobs/{filename}", "w") as file:
        yaml.dump(data, file, default_flow_style=False)


def filter_data(section: List[Dict[str, Any]], key: str, value: str) -> List[Dict[str, Any]]:
    """
    Filter configuration in PhEval file based on a key-value pair.

    Args:
        section (List[Dict[str, Any]]): List of dictionaries to filter
        key (str): The key to filter on
        value (str): The value to match

    Returns:
        List[Dict[str, Any]]: Filtered list of dictionaries

    """
    return [d for d in section if d.get(key) == value]


def split_runs(data: Dict[str, Any], run: Dict[str, str]) -> None:
    """
    Split runs into separate YAML files.

    Args:
        data (Dict[str, Any]): Parsed PhEval-Config YAML data
        run (Dict[str, str]): Run data containing configuration, corpus, and corpusvariant

    """
    config_id = run["configuration"]
    copied_data = data.copy()

    filter_func = partial(filter_data, key="id", value=config_id)
    copied_data["configs"] = filter_func(data["configs"])

    copied_data["runs"] = data["runs"]
    for key, value in run.items():
        copied_data["runs"] = filter_data(copied_data["runs"], key, value)

    write_conf(filename=f"{config_id}-{run['corpus']}-{run['corpusvariant']}.yaml", data=copied_data)


def generate_makefile(id_corpus: str = None):
    """
    generate make file based on run configuration id and corpus id.

    Args:
        id_corpus (str, optional): Run ID + Run Corpus forming an ID string present on pheval-config.yaml file.
        Defaults to None.

    """
    os.makedirs("./jobs", exist_ok=True)
    config = "./resources/pheval-config.yaml" if id_corpus is None else f"./jobs/{id_corpus}.yaml"
    output = "./jobs/original.Makefile" if id_corpus is None else f"./jobs/{id_corpus}.Makefile"
    logging.info(f'Generating {"original" if id_corpus is None else id_corpus} Makefile to {output}')
    return subprocess.run(
        [
            "./resources/generatemakefile.sh",
            "--resource=./resources/Makefile.j2",
            f"--config={config}",
            f"--output={output}",
        ],
        capture_output=True,
        text=True,
        shell=False,
    )


def execute_job(template_job: Path, max_jobs: int = -1, force: bool = False):
    """
    Execute job on HPC.

    Args:
        template_job (Path): template file that contains job details
        max_jobs (int, optional): maximum jobs per user. Defaults to -1.
        force (bool, optional): it will be executed even if a job
        was submitted before. Defaults to False.

    """
    logging.info("starting")
    with open("./resources/pheval-config.yaml", "r") as file:
        data = yaml.safe_load(file)
        generate_makefile()
        for run in data["runs"]:
            configuration_id = run["configuration"]
            corpus = run["corpus"]
            corpus_variant = run["corpusvariant"]
            id_corpus = f"{configuration_id}-{corpus}-{corpus_variant}"
            jobs = get_user_jobs()
            if len(jobs) >= max_jobs:
                logging.info("max jobs submitted")
                return
            submitted_file = f"./jobs/{id_corpus}.submitted"
            if os.path.exists(submitted_file) and not force:
                # logging.info(f"{id_corpus} job is already submitted")
                continue
            split_runs(data, run)
            generate_makefile(id_corpus=id_corpus)
            check_last_job_running()
            submit_job(id_corpus=id_corpus, template=template_job, submitted_file=submitted_file)
            logging.info("waiting job start (2 minutes)")
            time.sleep(120)
    # backing to the original makefile
    shutil.copy("./jobs/original.Makefile", "./Makefile")
    logging.info("done")

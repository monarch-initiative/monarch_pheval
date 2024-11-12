import os
from pathlib import Path
import yaml
import subprocess
import shutil
from typing import List
import logging
import time 

# Set up logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler("app.log"),
        logging.StreamHandler()
    ]
)

def generate_job_file(job_name, time, memory):
    sbatch_template = """#!/bin/bash
    #SBATCH --job-name={job_name}
    #SBATCH --output={output_file}
    #SBATCH --time={time}
    #SBATCH --mem={memory}

    python my_script.py {args}
    """

    sbatch_content = sbatch_template.format(
        job_name="my_job",
        output_file="output.log", 
        time="1:00:00",
        memory="4G",
        args="arg1 arg2"
    )

def get_user_jobs():
    username = os.getenv('USER')
    command = f"squeue -u {username} -o '%A %j %T %M %l %R'"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        logging.error(f"Error running squeue: {result.stderr}")
        return
    jobs = []
    for line in result.stdout.strip().split('\n')[1:]:  # Skip the header line
        job_id, name, state, time, time_limit, reason = line.split()
        jobs.append({
            'job_id': job_id,
            'name': name,
            'state': state,
            'time': time,
            'time_limit': time_limit,
            'reason': reason
        })
    return jobs


def check_last_job_running():
    jobs = get_user_jobs()
    last_job = jobs[-1]

    while last_job['state'] != 'RUNNING':
        jobs = get_user_jobs()
        last_job = jobs[-1]
        logging.info("Waiting job to be submitted")
        time.sleep(5)
    return


def submit_job(id:str, template:Path, submitted_file: Path, force:bool=False):
    shutil.copy(f'./jobs/{id}.Makefile', './Makefile')
    cmd = f'sbatch {template}'
    logging.info(f'running {id}')
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        logging.error(f"Error running sbatch: {result.stderr}")
        return
    Path(submitted_file).touch(exist_ok=True)

def write_conf(filename:str, data:List):
    os.makedirs('./jobs', exist_ok=True)
    with open(f'./jobs/{filename}', 'w') as file:
        yaml.dump(data, file, default_flow_style=False)

def filter_data(section:List, key:str, value:str):
    return [d for d in section if d[key] == value]

def split_runs(data:List, id:str):
    copied_data = data.copy()
    copied_data['configs'] = filter_data(data['configs'], 'id', id)
    copied_data['runs'] = filter_data(data['runs'], 'configuration', id)
    write_conf(filename=f'{id}.yaml', data=copied_data)
    
def generate_makefile(id:str=None):
    os.makedirs('./jobs', exist_ok=True)
    config = './resources/pheval-config.yaml' if id is None else f'./jobs/{id}.yaml'
    output = './jobs/original.Makefile' if id is None else f'./jobs/{id}.Makefile'
    logging.info(f'Generating {"original" if id is None else id} Makefile')
    return subprocess.run([
        "./resources/generatemakefile.sh",
        '--resource=./resources/Makefile.j2',
        f'--config={config}',
        f'--output={output}'
    ], capture_output=True, text=True)


def execute_job(template_job: Path, max_jobs:int=-1, force:bool=False):
    logging.info('starting')
    with open('./resources/pheval-config.yaml', 'r') as file:
        data = yaml.safe_load(file)
        # generate_makefile()
        for c in data['runs']:
            id = c['configuration']
            corpus = c['corpus']
            corpus_variant = c['corpusvariant']
            jobs = get_user_jobs()
            if len(jobs) >= max_jobs:
                logging.info('max jobs submitted')
                return
            submitted_file = f'./jobs/{id}-{corpus}-{corpus_variant}.submitted'
            if os.path.exists(submitted_file) and not force:
                # logging.info(f"{id} job is already submitted")
                continue
            split_runs(data, id)
            generate_makefile(id)
            check_last_job_running()
            submit_job(id=id, template=template_job, submitted_file=submitted_file, force=force)
            # backing to the original makefile
            # shutil.copy('./jobs/original.Makefile', './Makefile')
            logging.info('waiting job start (2 minutes)')
            time.sleep(120)
    logging.info('done')



### see jinja generator (python)
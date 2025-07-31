"""ParaPhEval."""

from pathlib import Path

import click

from monarch_pheval.parapheval import execute_job


@click.command(name="execute")
@click.option(
    "--force",
    "-f",
    metavar="force",
    required=False,
    default=False,
    help="Force job submission",
    type=bool,
)
@click.option(
    "--max-jobs",
    "-m",
    metavar="RUNNER",
    default=10,
    help="Maxmium parallel jobs",
)
@click.option(
    "--template-job-file",
    "-t",
    metavar="TEMPLATEJOBFILE",
    required=True,
    help="The path of the slurm job template file",
    type=Path,
)
def execute(
    force: bool,
    max_jobs: int,
    template_job_file: Path,
) -> None:
    """
    Execute PhEval JOB on HPC.

    Args:
        force (bool): _description_
        max_jobs (int): _description_
        template_job_file (Path): _description_

    """
    execute_job(force=force, max_jobs=max_jobs, template_job=template_job_file)

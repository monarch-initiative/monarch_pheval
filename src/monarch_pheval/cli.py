"""Command line interface for monarch_pheval."""

import logging

import click

from monarch_pheval.cli_parapheval import execute

info_log = logging.getLogger("info")


@click.group()
@click.option("-v", "--verbose", count=True)
@click.option("-q", "--quiet")
def main(verbose=1, quiet=False) -> None:
    """
    execute main CLI method for MonarchPhEval.

    Args:
        verbose (int, optional): Verbose flag.
        quiet (bool, optional): Queit Flag.

    """
    if verbose >= 2:
        info_log.setLevel(level=logging.DEBUG)
    elif verbose == 1:
        info_log.setLevel(level=logging.INFO)
    else:
        info_log.setLevel(level=logging.WARNING)
    if quiet:
        info_log.setLevel(level=logging.ERROR)


main.add_command(execute)


if __name__ == "__main__":
    main()

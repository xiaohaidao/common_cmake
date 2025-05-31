#!/bin/python

import os
import sys
from pathlib import Path
import argparse

cmake_template = """
cmake_minimum_required(VERSION 3.14)

project("workspace_project")

# import common configure
set(CUSTOM_LOCAL_COMMON_CMAKE {0})
include({0}/get_cmake.cmake)

{1}

"""

class Cmd(object):

    """Docstring for arg. """

    def __init__(self):
        """TODO: to be defined. """

    def build(self):
        """TODO: Docstring for add_param.
        :returns: TODO

        """
        pass

class Arg(object):

    """Docstring for arg. """

    def __init__(self):
        """TODO: to be defined. """

    def add_param(self, param_str, callback):
        """TODO: Docstring for add_param.
        :returns: TODO

        """
        pass


def get_cmake_text():
    file_path = Path(__file__).resolve().parent
    proj_template = "fetch_add_packet_macro({0} SOURCE_DIR {1})\n"
    get_str = lambda x: proj_template.format(x.name,
                                             "${CMAKE_CURRENT_LIST_DIR}/" + x.name)
    check_path = lambda x: x.is_dir() and x != file_path  and not (x/"CMakeCache.txt").exists()
    proj_str =  [get_str(x) for x in Path.cwd().iterdir() if check_path(x)]
    return cmake_template.format(file_path, "".join(proj_str))

if __name__ == "__main__":
    Path("CMakeLists.txt").write_text(get_cmake_text())
    # Arg arg
    # Cmd cmd
    # arg.add_param("build", cmd.build)
    # arg.add_param("install", cmd.install)

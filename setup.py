import sys
import os
from cx_Freeze import setup, Executable

# ADD FILES
files = ['child.qml', 'data/', 'images/', 'lib/', 'qml/']

# TARGET
target = Executable(
    script="main.py",
    base="Win32GUI",
    icon="images/logo.png"
)

# SETUP CX FREEZE
setup(
    name="DatabaseImporter",
    version="1.4",
    description="Modern GUI for database import applications",
    author="Thien Nguyen Vu",
    options={'build_exe': {'include_files': files}},
    executables=[target]
)

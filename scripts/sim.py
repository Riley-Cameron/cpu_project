import sys
import shlex
import json
import subprocess as sp
import tkinter as tk
from tkinter import simpledialog

BUILD_DIR = 'build'
SOURCE_DIR = 'src'
TEST_DIR = 'test'
SIM_CONFIG_FILE = 'build/sim_config.json'


def prompt_radio_choice(options, title="Select a testbench to run") -> str:
    """
    Launch a popup with radio buttons for the given options.
    
    Args:
        options (list of str): The options to show as radio buttons.
        title (str): Window title.

    Returns:
        str: The selected option, or None if cancelled.
    """
    selected = {"value": None}  # Mutable container to capture selection

    def on_submit():
        selected["value"] = var.get()
        root.destroy()

    root = tk.Tk()
    root.title(title)
    root.resizable(False, False)

    var = tk.StringVar(value=options[0])  # default selection

    # Add a radio button for each option
    for opt in options:
        tk.Radiobutton(root, text=opt, variable=var, value=opt).pack(anchor="w")

    # Submit button
    tk.Button(root, text="OK", command=on_submit).pack(pady=5)

    # Run the popup
    root.mainloop()

    return selected["value"]

def get_sim_files(config_file):
    with open(config_file, 'r') as f:
        data = json.load(f)

    test_files = []
    for file in data['test_files']:
        test_files.append(f"{TEST_DIR}/{file}")
    test_file = prompt_radio_choice(test_files)
    
    source_files = []
    for file in data['source_files']:
        source_files.append(f"{SOURCE_DIR}/{file}")

    return source_files, test_file

def run_cmd(cmd, cwd=None, check=True):
    print("\033[35m>>", shlex.join(cmd))
    try:
        if cwd != None:
            result = sp.run(cmd, check=check, cwd=cwd)
        else:
            result = sp.run(cmd, check=check)
    except sp.CalledProcessError as e:
        print("\033[31mFailed!")
        print(e.stderr)
        sys.exit(e.returncode)


def lint_file(file):
    cmd = ["verilator", "--lint-only", file]
    run_cmd(cmd, check=False)

def main():
    # Get files to include from sim_config.json
    src_files, test_file = get_sim_files(SIM_CONFIG_FILE)

    # Perform linting on all files
    for file in src_files:
        lint_file(file)
    lint_file(test_file)

    # Compile simulation
    sim_cmd = ["iverilog", "-o", f"{BUILD_DIR}/sim.vvp", test_file]
    sim_cmd.extend(src_files)
    run_cmd(sim_cmd)

    # Run simulation
    vvp_cmd = ["vvp", "sim.vvp"]
    run_cmd(vvp_cmd, cwd=BUILD_DIR)


if __name__ == '__main__':
    main()


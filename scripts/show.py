import sys
import shlex
import subprocess as sp

BUILD_DIR = 'build'


def main():
    cmd = ["gtkwave", "dump.vcd"]

    print("\033[35mRunning Command: ", shlex.join(cmd))
    try:
        result = sp.run(cmd, check=True, cwd=BUILD_DIR)
    except sp.CalledProcessError as e:
        print("\033[31mFailed!")
        print(e.stderr)
        sys.exit(e.returncode)

if __name__ == '__main__':
    main()


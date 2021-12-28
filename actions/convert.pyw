import subprocess
from subprocess import CREATE_NO_WINDOW, PIPE
import os
import shutil
import json
import sys


def convert():
    current_dir = os.path.normpath(os.path.dirname(__file__))
    with open(os.path.join(current_dir, ".brg"), mode="r") as file:
        args = json.load(file)
    command = f'"{args["converter"]}" --clean --name="{args["name"]}" --workpath "{os.path.join(current_dir, "build")}" '\
              f'--distpath "{args["distpath"]}" --specpath "{os.path.dirname(args["script"])}" '
    if args["icon"] != "DEFAULT":
        command += f'--icon="{args["icon"]}" '
    for a in args["options"]:
        command += a + " "
    for d in args["data"]:
        path = os.path.dirname(args["script"]) +"/"+ d
        if os.path.isfile(path):
            command += f'--add-data="{path};." '
        else:
            command += f'--add-data="{path};{d}" '
    command += f'"{args["script"]}"'
    p = subprocess.Popen(command, stderr=PIPE, stdout=PIPE, creationflags=CREATE_NO_WINDOW)
    info = ""
    for e in p.stderr:
        info = e.decode()[:-2]
    err = p.wait()
    pth = os.path.join(current_dir, "build", args["name"])
    if os.path.exists(pth):
        shutil.rmtree(pth)
    if err:
        print(info)
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    convert()
    
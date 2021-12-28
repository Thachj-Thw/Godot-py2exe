import PyInstaller


def version():
    return PyInstaller.__version__


if __name__ == "__main__":
    print(version())

# matlab-in-vscode (Windows)
This guide walks through the steps to install MATLAB and use it from VSCode.

## Installing MATLAB
You have 2 options install the desired version of MATLAB:
1. Download & Run the installer from [The MathWorks](https://matlab.mathworks.com) website.
2. Install using [MATLAB Package Manager](https://in.mathworks.com/help/install/ug/get-mpm-os-command-line.html#mw_0160ca92-6196-472c-b137-22eeba2f86ce).

This guide assumes that you have not activated your installation of MATLAB, which is the default mode of installation for MATLAB Package Manager.
If you want to only install and not activate a MATLAB using the installer be sure to select the following option during the install process:

![DownloadWithoutInstalling](https://github.com/user-attachments/assets/fc2f307b-24eb-48ea-bc50-1f7dbce14f84)

## Installing VSCode
[Download and Install VSCode ](https://code.visualstudio.com/Download)

### Recommended Extensions
1. MATLAB Extension for VSCode
2. Python
3. Jupyter

## Installing Miniconda (Or your favorite Python Environment Manager)
```PowerShell
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -o .\miniconda.exe
start /wait "" .\miniconda.exe /S
del .\miniconda.exe
```

## Installing Python
Install your desired Version of Python.
I've used the version I found on the Microsoft Store, which happens to be 3.13 at the time of this writing.
![image](https://github.com/user-attachments/assets/aba073b7-e4a8-46f7-a678-6e93a5c527b0)

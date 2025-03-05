# Install MATLAB R2024b using MATLAB Package Manager
Write-Output "Installing MATLAB R2024b..."
Invoke-WebRequest -Uri https://www.mathworks.com/mpm/win64/mpm -OutFile mpm.exe
# .\mpm.exe install --release=R2024b --destination="C:\Users\$env:USERNAME\matlab" --products=MATLAB
Start-Process -FilePath "mpm.exe" -ArgumentList "install --release=R2024b --destination=C:\Users\$env:USERNAME\matlab --products=MATLAB" -Wait
Remove-Item "mpm.exe"

# Download and install Visual Studio Code
Write-Output "Downloading and installing Visual Studio Code..."
Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile "vscode_installer.exe"
Start-Process -FilePath "vscode_installer.exe" -ArgumentList "/silent" -Wait
Remove-Item "vscode_installer.exe"

# Install MATLAB Extension for Visual Studio Code
Write-Output "Installing MATLAB Extension for Visual Studio Code..."
$env:Path += ";$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin"
code --install-extension MathWorks.language-matlab ms-python.python ms-toolsai.jupyter

# Download and install Python
Write-Output "Downloading and installing Python..."
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe" -OutFile "python_installer.exe"
Start-Process -FilePath "python_installer.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Remove-Item "python_installer.exe"

Write-Output "Installation complete."

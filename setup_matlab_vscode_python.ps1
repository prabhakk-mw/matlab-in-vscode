# To run this script you may need to:
# Run PowerShell as administrator; then
# Run “get-ExecutionPolicy". If this returns “Restricted” 
# Run Set-ExecutionPolicy Unrestricted -Force 

# Define URLs and paths
$matlabPackageManagerUrl = "https://www.mathworks.com/mpm/win64/mpm"
$vscodeInstallerUrl = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"
$pyVersion = "3.11.5"
$pyVerInstallPostFix = "311"
$pythonInstallerUrl = "https://www.python.org/ftp/python/$pyVersion/python-$pyVersion-amd64.exe"

# Define the temporary download directory
$tempDir = "$env:TEMP\Installers"
New-Item -Path $tempDir -ItemType Directory -Force | Out-Null

# Download MATLAB Package Manager
$matlabPackageManagerPath = "$tempDir\mpm.exe"
Invoke-WebRequest -Uri $matlabPackageManagerUrl -OutFile $matlabPackageManagerPath

# Install MATLAB R2024b
matlabInstallDir = "C:\Program Files\MATLAB\R2024b"

Write-Host "Installing MATLAB R2024b..."
Start-Process -FilePath $matlabPackageManagerPath -ArgumentList "install --release=R2024b --destination=$matlabInstallDir --products=MATLAB" -Wait

# Determine MATLAB installation path
# This assumes MATLAB is installed in the default location. Adjust if necessary.
$matlabBinDir = "C:\Program Files\MATLAB\R2024b\bin"

# Add MATLAB to the system PATH
if (Test-Path $matlabBinDir) {
    Write-Host "Adding MATLAB to the system PATH..."
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    if (-not $currentPath.Contains($matlabBinDir)) {
        $newPath = $currentPath + ";" + $matlabBinDir
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    }
} else {
    Write-Host "MATLAB installation directory not found. Please check the installation path."
}

# Download and install Python
$pythonInstallerPath = "$tempDir\python-installer.exe"
Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $pythonInstallerPath
Start-Process -FilePath $pythonInstallerPath -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait


# Download and install VSCode
$vscodeInstallerPath = "$tempDir\vscode-installer.exe"
Invoke-WebRequest -Uri $vscodeInstallerUrl -OutFile $vscodeInstallerPath
Start-Process -FilePath $vscodeInstallerPath -ArgumentList "/silent", "/mergetasks=!runcode" -Wait

# Install VSCode extensions
$extensions = @(
    "MathWorks.language-matlab",
    "ms-toolsai.jupyter",
    "ms-python.python"
)

foreach ($extension in $extensions) {
    Write-Host "Installing VSCode extension: $extension"
    & "C:\Users\$env:USERNAME\AppData\Local\Programs\Microsoft VS Code\bin\code" --install-extension $extension
}

# Configure Python extension to use Conda
$settingsPath = "$env:APPDATA\Code\User\settings.json"

if (-Not (Test-Path $settingsPath)) {
    New-Item -ItemType File -Path $settingsPath -Force | Out-Null
}

$settings = @"
{
    "python.defaultInterpreterPath": "$env:ProgramFiles\Python$pyVerInstallPostFix\\python",
    "MATLAB.signIn": true,
    "jupyter.logKernelOutputSeparately": true,
    "python.condaPath": "C:\\Users\\$env:USERNAME\\Anaconda3\\Scripts\\conda.exe",
    "python.pythonPath": "C:\\Users\\$env:USERNAME\\Anaconda3\\python.exe"
}
"@

Set-Content -Path $settingsPath -Value $settings

# Clean up
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Installation complete."
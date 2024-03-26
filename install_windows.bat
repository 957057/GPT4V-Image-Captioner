@echo off

REM ���python��װ
SET PYTHON_VERSION=3.10.2
SET PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-amd64.exe

python --version >NUL 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Attempting to install Python %PYTHON_VERSION%...
    bitsadmin /transfer "PythonInstaller" %PYTHON_INSTALLER_URL% python-installer.exe
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del /f python-installer.exe
    python --version >NUL 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Failed to install Python.
        pause >nul
        exit /b 1
    )
)

echo Python installed.


REM ���⻷����ⴴ��
if not exist "myenv" (
    echo ���ڴ������⻷��...
    python -m venv myenv
    if %ERRORLEVEL% neq 0 (
        echo �������⻷��ʧ�ܣ����� python �Ƿ�װ����Լ� python �汾�Ƿ�Ϊ64λ�汾��python 3.10����python��Ŀ¼�Ƿ��ڻ�������PATH�ڡ�
        pause >nul
        exit /b 1
    )
)

call myenv\Scripts\activate


REM ͨ���ȸ�����������ʹ�þ���
set "target_url=www.google.com"
set "timeout=3000"

ping %target_url% -n 1 -w %timeout% >nul
if %errorlevel% neq 0 (
    echo Use CN
    set PIP_DISABLE_PIP_VERSION_CHECK=1
    set PIP_NO_CACHE_DIR=1
    set PIP_INDEX_URL=https://mirror.baidu.com/pypi/simple
) else (
    echo Use default
)

set HF_HOME=huggingface

REM ��װ����

echo Installing deps...
echo ��װ����
python -m pip install --upgrade pip
pip install -r ./install_script/requirements.txt
if %ERRORLEVEL% neq 0 (
    echo Deps install failed
    echo ������װʧ�ܡ�
    pause >nul
    exit /b 1
)

echo.
echo Install completed, please run Start to open the GUI
echo ��װ��ϣ�������Start��GUI
echo.

pause
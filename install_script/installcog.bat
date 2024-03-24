@echo off

call myenv\Scripts\activate

set HF_HOME=huggingface
REM ͨ���ٶȼ����������ʹ�þ���
set "target_url=www.baidu.com"
set "timeout=4000"

ping %target_url% -n 1 -w %timeout% >nul
if %errorlevel% equ 0 (
    echo Use CN
    echo ��װ����
    set PIP_DISABLE_PIP_VERSION_CHECK=1
    set PIP_NO_CACHE_DIR=1
    set PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple

    echo ��װ torch...
    pip install torch==2.2.1+cu121 torchvision==0.17.1+cu121 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://pypi.tuna.tsinghua.edu.cn/simple
    if %ERRORLEVEL% neq 0 (
        echo torch ��װʧ�� > install_temp.txt
        pause >nul
        exit /b 1
    )

) else (
    echo Use default
    echo Installing deps...
    pip install torch==2.2.1+cu121 torchvision==0.17.1+cu121 -i https://download.pytorch.org/whl/cu121
)


pip install ./install_script/deepspeed-0.11.2+8ce7471-py3-none-any.whl
pip install -U -I --no-deps xformers==0.0.25
pip install -r ./install_script/require.txt
if %ERRORLEVEL% neq 0 (
    echo Deps install failed / ������װʧ�� > install_temp.txt
    pause >nul
    exit /b 1
)

echo Install completed / ��װ��� > install_temp.txt

pause

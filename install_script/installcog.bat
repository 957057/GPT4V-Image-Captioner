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
    set PIP_INDEX_URL=https://mirror.baidu.com/pypi/simple

    echo ��װ torch...
    pip install torch==2.1.2+cu121 torchvision==0.16.2+cu121 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirror.baidu.com/pypi/simple
    if %ERRORLEVEL% neq 0 (
        echo torch ��װʧ�� > install_temp.txt
        pause >nul
        exit /b 1
    )
    echo ��װ bitsandbytes...
    pip install bitsandbytes==0.41.1 --index-url https://jihulab.com/api/v4/projects/140618/packages/pypi/simple
    if %ERRORLEVEL% neq 0 (
        echo bitsandbytes ��װʧ�� > install_temp.txt
        pause >nul
        exit /b 1
    )

) else (
    echo Use default
    echo Installing deps...
    pip install torch==2.1.2+cu121 torchvision==0.16.2+cu121 --extra-index-url https://download.pytorch.org/whl/cu121
    pip install bitsandbytes==0.41.1
)


pip install ./install_script/deepspeed-0.11.2+8ce7471-py3-none-any.whl
pip install -r ./install_script/require.txt
if %ERRORLEVEL% neq 0 (
    echo Deps install failed / ������װʧ�� > install_temp.txt
    pause >nul
    exit /b 1
)

echo Install completed / ��װ��� > install_temp.txt

pause
$Env:HF_HOME = "huggingface"
$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1
$Env:PIP_NO_CACHE_DIR = 1
$Env:PIP_INDEX_URL = "https://mirror.baidu.com/pypi/simple"

function InstallFail {
    Write-Output "��װʧ�ܡ�"
    Read-Host | Out-Null ;
    Exit
}

function Check {
    param (
        $ErrorInfo
    )
    if (!($?)) {
        Write-Output $ErrorInfo
        InstallFail
    }
}

if (!(Test-Path -Path "myenv")) {
    Write-Output "���ڴ������⻷��..."
    python -m venv myenv
    Check "�������⻷��ʧ�ܣ����� python �Ƿ�װ����Լ� python �汾�Ƿ�Ϊ64λ�汾��python 3.10����python��Ŀ¼�Ƿ��ڻ�������PATH�ڡ�"
}

.\myenv\Scripts\activate
Check "�������⻷��ʧ�ܡ�"

python -m pip install --upgrade pip

Write-Output "��װ����..."
pip install -r requirements.txt
Check "������װʧ�ܡ�"

Write-Output "��װ��ϣ�������Start��GUI"
Read-Host | Out-Null ;
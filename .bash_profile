export HISTTIMEFORMAT="%Y-%M-%D %H:%M:%S "
export HISTFILESIZE=400000
export HISTSIZE=30000
PROMPT_COMMAND="history -a"
#shopt -s histappend
#shopt -s expand_aliases

alias wrap_args='f(){ echo before "$@" after;  unset -f f; }; f'

export HISTCONTROL=erasedups

##########自定义的alias
alias bp="vim ~/.zprofile"
alias sp="source  ~/.zprofile"
alias ad="adb devices"
#########自定义的alias
modify_apk(){
    cd ~/Documents/AndroidProject/RN/Landi/UbaseNative/android/android_landi/
    current_dir=$(pwd)
    dir_apk=$(find . -iname "*.apk")
    dir_prefix=${dir_apk%/*}/
    dir_suffix=${dir_apk##*/}
    cd $dir_prefix
    mv $dir_suffix ${dir_suffix/release/test}
    cd $current_dir

}

#这个主要是用于RN打包的
rnPackage(){
    current_dir=$(pwd)
    cd ../..
    npm run bundle-ad
    cd $current_dir
}
#这个主要是用于安卓同时安装多个平板
madb(){
    echo "当前传递的文件名为$@"
    echo "当前传递的文件数量为$#"

    if [ "0" -eq $# ];then
        echo "请输入apk的地址"
        return 1
    fi

    dev_list=$(adb devices | awk '{if(NR>1)print}' | cut -f 1 -d "	" | xargs -I {} echo {})
    echo "$dev_list"
    if [ -z "$dev_list" ];then
        echo "请检查是否有设备连接"
        return 1
    else
        echo "设备连接成功。。。。"
    fi

    for i in "$@";do
        echo "$i"
        if [[ ! "apk" == $(echo "${i##*.}") ]];
        then
            echo "请确认您的安装包是apk结尾" $i
            return 1
        fi

        for dev in  $(echo $dev_list | cut -f 1 -d "	");do
            echo $i "安装到" "$dev" "设备中"
            adb -s $dev install $i
            if [ "0" -eq $? ];
            then
                echo "安装成功"
            else
                echo "安装失败"
            fi
        done
    done;
}

#
#区分文件和目录start---
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "
#export PS1="\[\033[36m\]\[\033[m\]\[\033[32m\]\[\033[33;1m\]\W\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
#用chrome打开文件
alias chrome="open -a \"Google Chrome\""
#区分文件和目录end---
#
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'

AClearPackage(){
    ./gradlew clean
    ./gradlew assembleRelease
 }

####android end####

#这个主要是开启Unbutu的容器，并且开启
ubuntuDocker(){
	docker start Savannah
	docker exec -it Savannah bash
}
centosDocker(){
	docker start centos 
	docker exec -it centos bash
}
#这个主要是登录远程的服务器
sshCon(){

    if [[ $1 == '-P' ]]; then
        echo '这个是华为云docker上的一台只有python3的服务器，用于测试python3'
        sshpass -p 19930627 ssh -o StrictHostKeyChecking=no root@119.3.237.32 -p 9606
    elif [[ $1 == '-R' ]]; then
        echo '这个是布置在远程的华为docker下的一台ssh的服务器，主要用于远程去连一些其
    它的服务器'
        sshpass -p 19930627 ssh -o StrictHostKeyChecking=no root@119.3.237.32 -p 9607
    elif [[ $1 == '-H' ]]; then
        echo '这个是华为的服务器地址'
        sshpass -p 19930627 ssh -o StrictHostKeyChecking=no Savannah@119.3.237.32
    elif [[ $1 == '-S' ]]; then
        echo '这个是海外的vps'
        ssh Savannah@155.94.137.104
    elif [[ $1 == '-W' ]];then
        echo '这个是兰迪少儿英语 公司的服务器'
        sshpass -p abc360 ssh -o StrictHostKeyChecking=no root@192.168.2.111 -p 1055
    elif [[ $1 == '-L' ]] ;then
        echo '这个是公司的日志ftp服务器'
        sshpass -p luKHm38923pjtA sftp -o StrictHostKeyChecking=no savanna@114.55.175.190
    else
        echo '-P,-R,-H,-S,-W,-L'
    fi
}
sshPyHuaWei(){
    #这个是华为云docker上的一台只有python3的服务器，用于测试python3
    sshpass -p 19930627 ssh -o StrictHostKeyChecking=no root@119.3.237.32 -p 9606
}

sshRemoteSSHHuaWei(){
    #这个是布置在远程的华为docker下的一台ssh的服务器，主要用于远程去连一些其它的服务器
    sshpass -p 19930627 ssh -o StrictHostKeyChecking=no root@119.3.237.32 -p 9607
}
sshHuaWei(){
    #这个是华为的服务器地址
    sshpass -p 19930627 ssh -o StrictHostKeyChecking=no Savannah@119.3.237.32
}

SGit(){
    #这个是海外的vps
    ssh Savannah@155.94.137.104
}

sshWebPy(){
    #这个是兰迪少儿英语 公司的服务器
    sshpass -p abc360 ssh -o StrictHostKeyChecking=no root@192.168.2.111 -p 1055 
}


sshVPN(){
    #这个目前已经用不了了
    sshpass -p Savannah@[]123 ssh -o StrictHostKeyChecking=no root@207.246.67.85
}

sLog(){
    #这个是公司的日志ftp服务器
    sshpass -p luKHm38923pjtA sftp -P 19998 -o StrictHostKeyChecking=no savanna@192.168.2.246 
}

md5sha1(){
    #这个是计算md5和sha1的
    md5 $1
    shasum $1
}

################Custom Operator##############
pcalc(){
    #这个是用于计算式子的，也可以用于其它的计算
    python3 -c "print(eval('$1'))"
}

bashCalc(){
    #这个是可以进行多个数学式子的计算
    cd /Users/zgs/Documents/sh/temp;
    ./test.sh $@
}
jf(){
 #这个是就是格式化json
 #json format 
 #usage jf ‘you input’ dont forget single quote
 echo $1 | python -mjson.tool
}

mu_socket(){
    #这个是发送socker消息给服务端的，服务端需要实现
    while true
    do
        echo 'please input message'
        read content
        python3 -c "import socket
HOST='10.211.55.13'
PORT=65432
s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((HOST,PORT))
content = '$content'
if not content:
    print('message should not be empty')
else:
    print(content)
    s.sendall(content.encode('utf-8'))
    data=s.recv(1024)
    print(data)"
    done

}

calc_salary(){
    #这个是一个计算薪水的一个工具
cd /Users/zgs/venv/PyMacosLearning01/bin
source activate
python3 -c "import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QUrl
from PyQt5.QtWebEngineWidgets import QWebEngineView
from PyQt5.QtWidgets import QApplication, QWidget, QDesktopWidget
from PyQt5 import QtCore
def mainPyQt5():
    url = 'http://119.3.237.32:9605/value/7500'
    app = QApplication(sys.argv)
    browser = QWebEngineView()
    browser.setFixedSize(500,100)
    browser.setWindowOpacity(0.05)
    ag = QDesktopWidget().availableGeometry()
    sg = QDesktopWidget().screenGeometry()
    widget = browser.geometry()
    x = 2.2*ag.width() - widget.width()
    y = ag.height() - sg.height() - widget.height()
docker_ubuntu_mqtt    browser.move(x, y)
    browser.load(QUrl(url))
    browser.setWindowFlag(QtCore.Qt.WindowStaysOnTopHint)
    browser.show()
    sys.exit(app.exec_())

mainPyQt5()"

deactivate
}

translate(){ #使用了腾讯翻译 
       source='en'
    target='zh'
    if [[ -n $1 ]]; then
        if [[ $1=='-C' ]]; then
            source='zh'
            target='en'
        fi
    fi
    while true
    do
    echo 'please enter word'
    read content
    if [[ -z $content ]]; then
        echo 'please re-enter word'
        continue
    fi
    if [[ $content == '-q' ]];then
        echo 'finish translate'
        return  0 
    fi
    cd /Users/zgs/venv/TheGameTranslate/bin && source activate
    echo '............start translating............'
    python3 -c "from tencentcloud.common import credential
from tencentcloud.common.profile.client_profile import ClientProfile
from tencentcloud.common.profile.http_profile import HttpProfile
from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
from tencentcloud.tmt.v20180321 import tmt_client, models
from ast import literal_eval
import time
import json
class Translate(object):
    def translate(self,content):
        time.sleep(2)
        if not content:
            return
        try:
            cred = credential.Credential('AKID2wmP2wkMt8pU8fcTJIBGRZdjdS9kaYlC', 'CHDLj088fS6uZ4pZDhx0pGcjdmh2DRDj')
            httpProfile = HttpProfile()
            httpProfile.endpoint = 'tmt.tencentcloudapi.com'

            clientProfile = ClientProfile()
            clientProfile.httpProfile = httpProfile
            client = tmt_client.TmtClient(cred, 'ap-beijing', clientProfile)
            req = models.TextTranslateRequest()
            params = json.dumps(dict(SourceText=content,Source='$source',Target='$target',ProjectId=0))
            req.from_json_string(params)
            resp = client.TextTranslate(req)
            res = resp.to_json_string()
            return literal_eval(res)['TargetText']
        except TencentCloudSDKException as err:
            print(err)
t  = Translate()
print(t.translate('$content'))"
deactivate
    echo -e '............translated finish......\n'
    done
}

fiddler(){
    cd /Applications/fiddler-mac
    echo '19930627' | sudo -S mono --arch=32 Fiddler.exe
}

################Custom Operator##############
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export NVPACK_ROOT="/Users/zgs/NVPACK"
export ANDROID_SDK="/Users/zgs/Library/AndroidSDK/sdk/"
export ANDROID_NDK="/Users/zgs/Documents/AndroidProject/NDK/android-ndk-r14b"
export ANDROID_HOME=$HOME/Library/AndroidSDK/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
export PATH=$PATH:$JAVA_HOME/bin

#flutter path
export FLUTTER_DIR=/Users/zgs/Documents/Flutter/flutter
export PATH=$PATH:$FLUTTER_DIR/bin


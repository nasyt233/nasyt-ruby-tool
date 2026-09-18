#!/usr/bin/ruby -w
# -*- coding : utf-8 -*-
alias sh system

print <<`EOC` 
#!/usr/bin/bash
# 检查包管理器的函数

version=1.0

if [ $# -ne 0 ]; then
    echo
else
    echo
    echo "当前版本:$version"
    echo "使用方法"
    echo "  nshc [.sh脚本]"
    exit 1
fi


if [ -f /etc/os-release ]; then
    source /etc/os-release #加载变量
fi
if command -v termux-info >/dev/null 2>&1; then
    sys="(Termux 终端)"
    PRETTY_NAME="Termux终端"
    sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list >/dev/null
    pkg_install="pkg install"
    pkg_remove="pkg remove"
    pkg_update="pkg update"
    deb_sys="pkg"
    yes_tg="-y"
    
elif command -v apt-get >/dev/null 2>&1; then
    sys="(Debian/Ubuntu 系列)"
    pkg_install="sudo apt install"
    pkg_remove="sudo apt remove"
    pkg_update="sudo apt update"
    sudo_setup="sudo"
    deb_sys="apt"
    yes_tg="-y"
    
elif command -v dnf >/dev/null 2>&1; then
    sys="(Fedora/RHEL/CentOS 8 及更高版本)"
    pkg_install="sudo dnf install"
    pkg_remove="sudo dnf remove"
    pkg_update="sudo dnf update"
    sudo_setup="sudo"
    deb_sys="dnf"
    yes_tg="-y"
    
elif command -v yum >/dev/null 2>&1; then
    sys="(Fedora/RHEL/Rocky/CentOS 7 及更早版本)"
    pkg_install="sudo yum install"
    pkg_remove="sudo yum remove"
    pkg_update="sudo yum update"
    sudo_setup="sudo"
    deb_sys="yum"
    yes_tg="-y"
    
elif command -v pacman >/dev/null 2>&1; then
    sys="(Arch Linux 系列)"
    pkg_install="sudo pacman -S"
    pkg_remove="sudo pacman -R"
    sudo_setup="sudo"
    deb_sys="pacman"
    yes_tg="-y"
    
elif command -v zypper >/dev/null 2>&1; then
    sys="(openSUSE 系列)"
    pkg_install="sudo zypper in -y"
    pkg_remove="sudo zypper rm"
    sudo_setup="sudo"
    deb_sys="zypper"
    yes_tg="-y"
    
elif command -v apk >/dev/null 2>&1; then
    sys="(Alpine/PostmarketOS系统)"
    sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories
    pkg_install="sudo apk add"
    pkg_remove="sudo apk del"
    sudo_setup="sudo"
    deb_sys="apk"
    yes_tg=""
    
elif command -v emerge >/dev/null 2>&1; then
    sys="(gentoo/funtoo 系统)"
    pkg_install="sudo emerge -avk"
    pkg_remove="sudo emerge -C"
    sudo_setup="sudo"
    deb_sys="emerge"
    yes_tg="-y"
    
elif [[ "$(uname -s)" == "Darwin" ]]; then
    brew_install #brew安装检测
    sys="(MacOS 系统)"
    pkg_install="brew install"
    sudo_setup="sudo"
    deb_sys="brew"
    yes_tg="-y"
    read -p "抱歉，目前没有完全适配MacOS系统"
    
else
    echo -e "$(info) >_<未检测到支持的系统。"
fi


#通用安装
test_install() {
    if command -v $* >/dev/null 2>&1; then
        echo -e "$*已安装,跳过安装"
    else
        echo -e "正在安装"
        $sudo_setup $pkg_install $* $yes_tg
        install_error=$?
        if [ $install_error -ne 0 ]; then
            echo -e "$*安装失败"
            echo -e "$正在更新软件包"
            $pkg_update $yes_tg
            if [ $? -ne 0 ]; then
                echo -e "更新软件包失败"
                esc
            else
                echo -e "更新软件包成功,正在尝试重新安装"
                $sudo_setup $pkg_install $* $yes_tg
            fi
        else
            echo -e "$*安装成功"
        fi
    fi
}

# 定义颜色变量
    color='\033[0m'
    green='\033[0;32m'
    blue='\033[0;34m'
    red='\033[31m'
    yellow='\033[33m'
    grey='\e[37m'
    pink='\033[38;5;218m'
    cyan='\033[96m'

shc_xz=$1

shc_file=${shc_xz%.sh}


if command -v shc >/dev/null 2>&1; then
    echo "正在加密中"
else
    echo "正在安装必备组件,请耐心等待。"
    test_install gcc >/dev/null 2>&1
    test_install shc >/dev/null 2>&1
    error=$?
    if [ $error -ne 0 ]; then
        echo -e "$red 必备组件安装失败$color"
        echo -e "$red 错误代码: $error $color"
        exit 1
    fi
    echo "正在加密中"
fi

shc -f $1 -r >/dev/null 2>&1
error=$?

if [ $error -ne 0 ]; then
    echo "脚本加密失败"
    echo -e "$red错误代码 $error $color"
    exit 1
else
    echo "脚本加密成功"
fi

rm $1.x.c >/dev/null 2>&1

mv $1.x $shc_file >/dev/null 2>&1

chmod +x $shc_file >/dev/null 2>&1
echo
echo "文件名:$shc_file"

EOC

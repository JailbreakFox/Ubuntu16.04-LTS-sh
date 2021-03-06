#运行方式
#sh vnc.sh
#在Ubuntu14.04里这个远程桌面并没有X11VNC好用，可安装另一个sh

#===========vncserver安装============
#apt-get方式安装vncserver
sudo apt-get install vnc4server
#安装gnome（linux的一种图形桌面环境）
sudo apt-get install gnome-core
#设置VNC密码
vncpasswd
#新建配置文件
touch ~/.vnc/xstartup
#往配置文件内添加配置内容
echo "#!/bin/sh  
  
export XKL_XMODMAP_DISABLE=1  
unset SESSION_MANAGER  
unset DBUS_SESSION_BUS_ADDRESS  
  
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup  
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources  
xsetroot -solid grey  
vncconfig -iconic &  
  
gnome-panel &  
gnome-settings-daemon &  
metacity &  
nautilus &  
gnome-terminal & " > ~/.vnc/xstartup
#为xstartup文件添加可执行权限
chmod +x ~/.vnc/xstartup

#===========vncviewer安装============
sudo apt-get install xvnc4viewer

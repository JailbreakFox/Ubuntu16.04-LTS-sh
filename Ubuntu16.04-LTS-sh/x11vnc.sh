#运行方式
#sh x11vnc.sh
#中途需要输入配置的vnc密码以及验证

#===========x11vnc安装============
#教程来自https://blog.csdn.net/gubenpeiyuan/article/details/82229520
#安装 X11VNC
sudo apt-get install x11vnc -y
#配置访问密码
sudo x11vnc -storepasswd /etc/x11vnc.pass
#创建服务
sudo touch /lib/systemd/system/x11vnc.service
#不要随便用chmod -R，这个参数代表修改目录下所有文件的权限！！
sudo chmod 777 /lib/systemd/system/x11vnc.service
echo "[Unit]
Description=Start x11vnc at startup.
After=multi-user.target
[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared
[Install]
WantedBy=multi-user.target" > /lib/systemd/system/x11vnc.service
#修改防火墙配置，配置和启动服务
sudo ufw allow 5900
sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload

#Ubuntu14系统需加入以下配置文件
sudo touch /etc/init/x11vnc.conf
sudo chmod a+w /etc/init/x11vnc.conf
echo "start on login-session-start 
 
script 
x11vnc -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -o /var/log/x11vnc.log -rfbauth /etc/x11vnc.pass -rfbport 5900 
end script " > /etc/init/x11vnc.conf

#重新启动
sudo reboot

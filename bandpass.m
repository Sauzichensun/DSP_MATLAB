%带通滤波器实验代码
load quakes
[p,f] = pspectrum(quakes);%功率谱
figure
semilogx(f,db(p,"power"))%绘制对数坐标图，power-表示基于功率的分贝值
legend("HARP","PAX","WANC","Lowpass WANC","Location","best")%显示图例，并指定location-位置
xlabel("Frequency (Hz)")%x轴标签
ylabel("Power Spectrum (dB)")%y轴标签

%带通滤波后的数据
bandWANC = bandpass(quakes(:,"WANC"),[2,10]);%其中不能用quakes.WANC-这是一个向量，而不是一个时间表

%合并
comfilt = timetable(quakes.Time,quakes.WANC,bandWANC.WANC,'VariableNames',["BandPass","Lowpass"]);%将两个滤波后的数据合并成一个时间表

%创建堆叠图并改变线性刻度
figure
stackedplot(comfilt);
xlim([seconds(2900),seconds(2950)]);%改变x轴时间刻度

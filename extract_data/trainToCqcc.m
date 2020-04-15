function trainToCqcc()
cd I:\合成语音检测\BaselineSystem\CQCC_v1.0

addpath('CQT_toolbox_2013');

%% PARAMETERS
x = zeros(1,100000);
fs = 16000;
B = 96;
fmax = fs/2;
fmin = fmax/2^9;
d = 16;
cf = 19;
ZsdD = 'ZsdD';

file_path = 'E:\音频处理eval\';
save_path = 'E:\音频处理evalCqcc\';
dir_src = dir(file_path);
%读取音频种类
for i = 3:length(dir_src)
%种类名
name = dir_src(i).name;
%种类子路径
audio_path = strcat(file_path,name);
dir_src1 = dir(audio_path);
%遍历每个种类中所有音频
for j  = 3:length(dir_src1)
%每个音频的名字
name1 = dir_src1(j).name;
audio_path1 = strcat(dir_src1(j).folder,'\');
%得到每个音频的路径
audio_path1 = strcat(audio_path1,name1);
%读取音频
[x,fs] = audioread(audio_path1); % from ASVspoof2015 database

if length(x)<=36000
x = [x;zeros(36000-length(x),1)];
end

x=x(1:36000);



[CQcc, LogP_absCQT, TimeVec, FreqVec, Ures_LogP_absCQT, Ures_FreqVec] = ...
    cqcc(x, fs, B, fmax, fmin, d, cf, ZsdD);
cell = strsplit(name1,'.');
name2 = cell{1};

if exist(save_path)==0
mkdir(save_path);
end
save_name = strcat(save_path,name);
if exist(save_name)==0
mkdir(save_name);
end
save_name = strcat(save_name,'\');
save_name = strcat(save_name,name2);
save_name = strcat(save_name,'.mat');


%60x60
%CQccT = CQcc.';
%tmp = CQcc(:,1:200); %*CQccT;
save(save_name,'CQcc');
end
end
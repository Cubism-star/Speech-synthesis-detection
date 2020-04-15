function trainToCqcc()
cd I:\�ϳ��������\BaselineSystem\CQCC_v1.0

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

file_path = 'E:\��Ƶ����eval\';
save_path = 'E:\��Ƶ����evalCqcc\';
dir_src = dir(file_path);
%��ȡ��Ƶ����
for i = 3:length(dir_src)
%������
name = dir_src(i).name;
%������·��
audio_path = strcat(file_path,name);
dir_src1 = dir(audio_path);
%����ÿ��������������Ƶ
for j  = 3:length(dir_src1)
%ÿ����Ƶ������
name1 = dir_src1(j).name;
audio_path1 = strcat(dir_src1(j).folder,'\');
%�õ�ÿ����Ƶ��·��
audio_path1 = strcat(audio_path1,name1);
%��ȡ��Ƶ
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
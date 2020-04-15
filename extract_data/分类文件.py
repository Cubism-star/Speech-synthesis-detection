import os
import shutil
rootdir = 'I:\\合成语音检测\\ASVspoof2019_LA_eval_v1\\ASVspoof2019_LA_eval\\flac'
txt = '''I:\\合成语音检测\\ASVspoof2019_LA_eval_v1\\ASVspoof2019.LA.cm.eval.trl.txt'''
dev = 'E:\\音频处理eval'

file = open(txt)
judge_dict={}
all_kind= {}
for line in file.readlines():
    all_info = line.split(' ')
    kind=all_info[3].replace('\n','')
    if kind =='-':
        kind='bonafide'
    name = all_info[1]
    judge_dict[name]=kind
    if kind not in all_kind:
        all_kind[kind]=1
    else:
        all_kind[kind]+=1


#根据音频攻击种类创建目录
try:
    os.mkdir(dev)
    for key,value in all_kind.items():
        print(key)
        os.mkdir(rootdirection+key)
except:
    pass

list = os.listdir(rootdir)  # 列出文件夹下所有的目录与文件
for i in range(0, len(list)):
    path = os.path.join(rootdir, list[i])
    if os.path.isfile(path):
        # 你想对文件的操作
        try:
            kind =str((judge_dict[str(list[i]).replace('.flac', '')]))
            i_ = dev +'\\'+ kind + '\\' + list[i]
            shutil.copyfile(path, i_)
        except:
            pass
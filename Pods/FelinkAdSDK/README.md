#iOS SDK接入
1.安装CocoaPods
gem install cocoapods

2.安装Git LFS
https://git-lfs.github.com

sudo sh install.sh
git lfs version

pod cache clean Bytedance-UnionAD

3.在工程Podfile

pod 'FelinkAdSDK' 

#在工程目录下 运行以下命令

pod update

# 工程简介
演示Dockerfile的多阶段构建
总共两个Dockerfile文件
1. 本地编译打包
2. 从github远程拉取代码，然后编译打包
   注意ARG参数的阶段可用性，需要再新的阶段再次定义
```
docker build --build-arg url=https://gitee.com/helloyunsheng/dockerfileDemo.git --build-arg appName=dockerfileDemo -t demogit:test -f DockerfileGit .
```
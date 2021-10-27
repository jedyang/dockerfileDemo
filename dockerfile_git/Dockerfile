# 第一阶段:从github拉取代码编译
FROM bitnami/git:2.33.0 AS gitClone
ARG url=""
ARG appName=""

RUN git clone $url

# RUN ls -l
# appName需要是clone的项目名
# RUN cd ${appName} && pwd

# 第二阶段,mvn打包
FROM maven:3.5.0-jdk-8-alpine AS jarBuilder
ARG appName=""

COPY --from=gitClone /${appName} /${appName}

# RUN ls -l /
# RUN echo ${appName}
WORKDIR /${appName}/

# RUN pwd && ls -l

RUN mvn clean package -DskipTests

# 第三阶段，最终镜像
FROM openjdk:8-jre-alpine
# 修改时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

LABEL maintainer="yunsheng"

ARG appName=""

# RUN echo ${appName}

# 从上一个阶段复制jar包
COPY --from=jarBuilder /${appName}/target/*.jar /app.jar

# jvm参数
ENV JAVA_OPTS=""
# spring可设置的应用参数
ENV APP_PARAMS=""

EXPOSE 8080

# 使用"-Djava.security.egd=file:/dev/./urandom"加快随机数产生过程。可以一定程度上加快应用启动。
ENTRYPOINT [ "sh", "-c", "java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -jar /app.jar $APP_PARAMS" ]
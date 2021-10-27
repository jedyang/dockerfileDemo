FROM maven:3.5.0-jdk-8-alpine AS jarBuilder

WORKDIR /app
# copy本地源码
ADD ./ /app

RUN mvn clean package -DskipTests

# 第二阶段
FROM openjdk:8-jre-alpine
# 修改时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

LABEL maintainer="yunsheng"

# 从上一个阶段复制jar包
COPY --from=jarBuilder /app/target/*.jar /app.jar

# jvm参数
ENV JAVA_OPTS=""
# spring可设置的应用参数
ENV APP_PARAMS=""

# 使用"-Djava.security.egd=file:/dev/./urandom"加快随机数产生过程。可以一定程度上加快应用启动。
ENTRYPOINT [ "sh", "-c", "java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -jar /app.jar $APP_PARAMS" ]

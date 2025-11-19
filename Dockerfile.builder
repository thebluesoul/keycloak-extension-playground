FROM maven:3.9-eclipse-temurin-17

# 필요한 도구 설치
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Git 설정 (대용량 저장소를 위한 설정)
RUN git config --global http.postBuffer 524288000 && \
    git config --global core.compression 0

# Maven 메모리 및 Java 17 호환성 설정
ENV MAVEN_OPTS="-Xmx2g -XX:+TieredCompilation -XX:TieredStopAtLevel=1 --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.text=ALL-UNNAMED --add-opens=java.desktop/java.awt.font=ALL-UNNAMED"


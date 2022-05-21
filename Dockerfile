FROM maven:3-openjdk-11 as builder
COPY . /nbvcxz
WORKDIR /nbvcxz
# Build the library jar and download the dependencies
RUN mvn dependency:copy-dependencies && mvn clean package -DskipTests
# Copy the jar to the fuzz folder and copy the dependencies to the fuzz folder
RUN mkdir ./fuzz/deps && find ./target -name "nbvcxz*.jar" -exec cp {} "./fuzz/deps/nbvcxz.jar" \; && python3 fuzz/generate_classpath.py > fuzz/src/Manifest.txt
WORKDIR /nbvcxz/fuzz/src
# # Build the fuzz target
RUN javac -cp "../deps/*" fuzz.java && jar cfme fuzz.jar Manifest.txt fuzz fuzz.class && chmod u+x fuzz.jar && cp fuzz.jar /nbvcxz/fuzz/deps
WORKDIR /nbvcxz/fuzz/deps

# RUN wget https://github.com/CodeIntelligenceTesting/jazzer/releases/download/v0.11.0/jazzer-linux-0.11.0.tar.gz && tar -xvf jazzer-linux-0.11.0.tar.gz && rm jazzer-linux-0.11.0.tar.gz && chmod +x jazzer
# 사용 툴
- CI/CD: Jenkins
- 형상 관리: GitLab
- 프로젝트 기록: Notion, MatterMost
- 이슈 관리: Jira
- 디자인: Figma
- UCC: 모바비

# IDE
- VS CODE `1.85.1`
- Android Studio `2023.2.1 Patch 1`
- IntelliJ `2023.3.2`

# 개발 환경
## Server
- Ubuntu `20.04.6 LTS`
- Docker `26.1.1`
- Nginx `1.18.0`
## Front
- Dart `3.3.3`
- Flutter `3.19.5`
## Back
- JDK `17`
- Spring boot `3.2.5`<br><br>

# 서버 설정
## docker 설치
```bash
$ sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo apt-key fingerprint 0EBFCD88
$ sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io

# 버전 확인
$ sudo docker version

# docker 명령어 쓸 때마다 sudo 해주기 귀찮으니까
$ sudo usermod -aG docker $USER
```

## jekins, mysql, redis 설치

```bash
$ docker run --name jenkins -d -p 9090:8080 jenkins/jenkins:jdk17
$ docker run --name mysql -d -p 3306:3306 mysql:latest
$ docker run --name redis -d -p 6379:6379 redis
```

## Nginx 설치

```bash
$ sudo apt install nginx
$ sudo service nginx start
$ sudo service nginx status
```

## SSL 설정
```bash
$ apt-get update
$ sudo apt-get install certbot
$ apt-get install python3-certbot-nginx
$ sudo certbot certonly --standalone -d {DOMAIN_URL}
```

## Nginx 설정
- nginx/default
```nginx
server {
        root /var/www/html;
        client_max_body_size 2000M;
        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;
         server_name {DOMAIN_URL}; # managed by Certbot



        location / {
                proxy_pass http://{DOMAIN_URL}:{LANDING_PORT_NUMBER};
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
        }

        location /api {
                proxy_pass http://{DOMAIN_URL}:{BACK_PORT_NUMBER};
        }
        location ~ ^/(swagger|webjars|configuration|swagger-resources|v3|csrf) {
               proxy_pass http://{DOMAIN_URL}:8000;
               proxy_set_header Host $host;
               proxy_set_header X-Real-IP $remote_addr;
               proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto $scheme;
        }
        location /ws {
                proxy_pass http://{DOMAIN_URL}:{SOCKET_PORT_NUMBER};
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_ssl_verify off;
        }


    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate {fullchain_PATH}; # managed by Certbot
    ssl_certificate_key {privkey_PATH}; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = {DOMAIN_URL}) {
        return 301 https://$host$request_uri;
    } # managed by Certbot
                                                               11,23-37      Top
```

## Jenkins 파이프라인
```groovy
pipeline {
    agent any
    tools{
        gradle 'gradle'
    }
    environment{
        dockerImage = ''
        CHANGED_FOLDER = 'back'
    }

    stages {
        stage('Check Changes') {
                    steps {
                        dir('./back') {  // 'front' 디렉토리로 이동
                            script {
                                // 마지막 두 커밋 사이의 변경된 파일 목록을 가져옴
                                def changes = sh(script: "git diff --name-only HEAD~1 HEAD", returnStdout: true).trim()
                                echo "Changed files: ${changes}"
                                if (!changes.contains(env.CHANGED_FOLDER)) {
                                    echo "No changes in the specified folder."
                                    currentBuild.result = 'SUCCESS'
                                    return
                                } else {
                                    echo "Changes detected in the specified folder."
                                }
                            }
                        }
                    }
                }
        stage('secret.yml download'){
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps{
                withCredentials([file(credentialsId: '{credential_NAME}', variable: 'configFile')]){
                    script{
                        sh "cp $configFile back/src/main/resources/application.yml"

                    }
                }
            }
        }
        stage('Build'){
        when {
                        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                    }
            steps{
                dir("./back"){
                    sh "chmod +x gradlew"
                    sh "gradle wrapper"
                    sh "./gradlew clean build"
                }
            }
        }
        stage("Build Image"){
        when {
                        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                    }
            steps{
                dir("./back"){
                    script{
                        dockerImage = docker.build("run-time"+":$BUILD_NUMBER")
                      }
                }
            }
        }
         stage('stop prev container'){
         when {
                         expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                     }
            steps {
                script {
                    try {
                        sh 'docker stop run-time'
                        sh 'docker rm run-time'
                    } catch (e) {
                        echo 'no prev container'
                    }
                }
            }
        }

        stage('Run Container') {
        when {
                        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                    }
            steps {
                script {
                    // 이미지를 기반으로 컨테이너 실행
                    dockerImage.run("-p {BACK_PORT_NUMBER}:{BACK_PORT_NUMBER} --name run-time -d")
                }
            }
        }
        stage('Cleaning up'){
        when {
                        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                    }
            steps{
                script {
                    try{
                        // 이전 빌드 번호 계산
                        def previousBuildNumber = BUILD_NUMBER.toInteger() - 1
                        // 이전 이미지 삭제
                        sh "docker rmi run-time:$previousBuildNumber"
                    }catch(e){
                        sh 'echo fail!!'
                    }

                }
            }
        }

    }
        post { //MatterMost 알림
            success {
            	script {
                    def Author_ID = sh(script: "git show -s --pretty=%an", returnStdout: true).trim()
                    def Author_Name = sh(script: "git show -s --pretty=%ae", returnStdout: true).trim()
                    mattermostSend (color: 'good',
                    message: "빌드 성공: ${env.JOB_NAME} #${env.BUILD_NUMBER} by ${Author_ID}",
                    text:":gg-ddabong: "
                    )
                }
            }
            failure {
            	script {
                    def Author_ID = sh(script: "git show -s --pretty=%an", returnStdout: true).trim()
                    def Author_Name = sh(script: "git show -s --pretty=%ae", returnStdout: true).trim()
                    mattermostSend (color: 'danger',
                    message: "빌드 실패: ${env.JOB_NAME} #${env.BUILD_NUMBER} by ${Author_ID}",
                    text:":stupidface: "
                    )
                }
            }
        }
}

```

# Back
application.yml
```yml
server:
  port: {PORT_NUMBER}

spring:
  application:
    name: back
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://{DOMAIN_URL}:{DB_PORT_NUMBER}/{SCHEMA_NAME}?useSSL=true&serverTimezone=Asia/Seoul&useLegacyDatetimeCode=false
    username: {DB_USERNAME}
    password: {DB_PASSWORD}
  data:
    redis:
      port: {REDIS_PORT_NUMBER}
      host: {DOMAIN_URL}
  jpa:
    database-platform: org.hibernate.dialect.MySQL8Dialect
    properties:
      hibernate:
        format_sql: true
        show_sql: true
    hibernate:
      ddl-auto: none
  servlet:
    multipart:
      max-file-size: 100MB
      max-request-size: 200MB
cloud:
  aws:
    credentials:
      accessKey: {AWS_ACCESS_KEY}
      secretKey: {AWS_SECRET_KEY}
    region:
      static: ap-southeast-2

cloudfront:
  url: {CLOUDFRONT_URL}

s3:
  bucket:
    name: {S3_BUCKET_NAME}

oauth:
  kakao:
    client_id: {KAKAO_REST_API_KEY}
    redirect_uri: {KAKAO_REDIRECT_URL}
jwt:
  expiration_time: 86400000 #1일
  secret: {JWT_SECRET_KEY}

notification:
  mattermost:
    enabled: true # mmSender를 사용할 지 여부, false면 알림이 오지 않는다
    webhook-url: "{MATTERMOST_WEBHOOK_URL}" # 위의 Webhook URL을 기입
#    channel: # 기본 설정한 채널이 아닌 다른 채널로 보내고 싶을 때 기입한다
    pretext: "ⓘ를 눌러보세요" # attachments의 상단에 나오게 되는 일반 텍스트 문자
#    color: # attachment에 왼쪽 사이드 컬러. default=red
    author-name: "SpringBoot" # attachment의 상단에 나오는 이름
    author-icon: "https://emojis.slackmojis.com/emojis/images/1643515009/10387/spring-boot.png?1643515009" # author-icon 왼쪽에 나올 아이콘의 url링크
#    footer: # attachment에 하단에 나올 부분. default=현재 시간
```

serviceAccountKey.json
- FCM 권한을 위한 파일
- FCM 플랫폼에서 생성

# Front
root(front_android)/.env
```properties
KAKAO_NATIVE_APP_KEY=Kakao에서 NATIVE APP KEY발급 후 사용
KAKAO_JAVASCRIPT_KEY=Kakao에서 JAVASCRIPT APP KEY발급 후 사용
BASE_URL=백엔드 URL
SOCKET_URL=STOMP 서버 URL
```

root(front_android)/android/local.properties

```properties
kakaoAppKey=Kakao에서 NATIVE APP KEY발급 후 사용 - .env의 KAKAO_NATIVE_APP_KEY와 동일
googleApiKey=Google Map 사용 가능한 api 발급 후 사용
```

## Flutter Package 설치

실행 위치: root(front_android)/

```
flutter pub get
```

​	⁕ 해당 명령어 실행 후에도 오류 발생시 pubspec.yaml 파일을 열고 저장한 후 확인


## FCM 설정

[Flutter 앱에 Firebase 추가](https://firebase.google.com/docs/flutter/setup?hl=ko&_gl=1*z7vfwz*_up*MQ..*_ga*MTU1MDc3NDQ5OC4xNzE2MTQ0ODg3*_ga_CW55HF8NVT*MTcxNjE0NDg4Ny4xLjAuMTcxNjE0NDg4Ny4wLjAuMA..&platform=ios) 참고
## APK 파일 빌드

실행 위치: root(front_android)/

```
flutter build apk --obfuscate --split-debug-info=build/debug_info

// front_android\build\app\outputs\flutter-apk에 app-release.apk 파일 생성
// Kotlin 버전 오류 발생하나 실행에 이상을 발견하지 못함, 단 오류 메세지대로 다운그레이드 시 오류 발생
```
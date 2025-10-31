# Git LFS 서버 Docker 설정

이 문서는 Docker 및 Docker Compose를 사용하여 Git LFS 서버를 설정하고 실행하는 방법을 설명합니다.

## 사전 요구 사항

- Docker
- Docker Compose

## 설정

1.  **`docker-compose.yml`**

    `docker-compose.yml` 파일은 현재 디렉토리의 `dockerfile`에서 Docker 이미지를 빌드하고 Git LFS 서버를 실행하도록 구성됩니다.

    -   **서비스:** `git-lfs-server`
    -   **빌드:** 로컬 `dockerfile`에서 이미지를 빌드합니다.
    -   **포트:** 서버의 포트 `8080`이 호스트 머신의 포트 `9999`에 매핑됩니다.
    -   **환경 변수:**
        -   환경 변수는 `.env` 파일에서 로드됩니다. 해당 파일에서 값을 사용자 지정할 수 있습니다.
        -   `LFS_ADMINUSER`: LFS 서버의 관리자 사용자 이름입니다.
        -   `LFS_ADMINPASS`: LFS 서버의 관리자 암호입니다.
        -   `LFS_SCHEME`: 서버에서 사용하는 프로토콜 체계입니다.
    -   **볼륨:**
        -   바인드 마운트는 호스트 디렉토리 `/docker/lfs_data`를 컨테이너 디렉토리 `/data/lfs-server`에 매핑하는 데 사용됩니다. **컨테이너를 시작하기 전에 호스트 머신에 `/docker/lfs_data` 디렉토리를 만들어야 합니다.**

2.  **실행 방법**

    Git LFS 서버를 시작하려면 `docker-compose.yml` 파일과 동일한 디렉토리에서 다음 명령을 실행하십시오.

    ```bash
    docker-compose up -d
    ```

    `-d` 플래그는 분리 모드에서 컨테이너를 실행합니다.

3.  **서버 접속**

    Git LFS 서버는 `http://<your-docker-host>:9999`에서 액세스할 수 있습니다. 관리자 자격 증명은 `.env` 파일에 설정되어 있습니다.

    -   **사용자 이름:** `.env` 파일의 `LFS_ADMINUSER` 값.
    -   **암호:** `.env` 파일의 `LFS_ADMINPASS` 값.

## Git LFS 구성

이 LFS 서버를 Git 저장소와 함께 사용하려면 로컬 저장소에서 LFS URL을 구성하십시오.

```bash
git config -f .lfsconfig lfs.url "http://<your-docker-host>:9999/jaehyung101/my-repo"
```

`<your-docker-host>`를 Docker 컨테이너를 실행하는 머신의 IP 주소 또는 호스트 이름으로 바꾸고 `my-repo`를 저장소 이름으로 바꾸십시오. LFS 파일을 푸시하면 Git에서 자격 증명을 묻는 메시지를 표시합니다.

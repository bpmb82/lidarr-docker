# lidarr-docker

Lidarr image, updated weekly, running the latest stable version of Lidarr. 

Automatically grabs the API key to do a healthcheck

## Environment

| Environment variable | Description |
| --- | --- |
| `ENABLE_BACKUP` | Set to `1` to enable daily backups of the database. Last 30 days are kept. |

## docker-compose

```
version: '3.3'

services:


  lidarr:
    image: bpmbee/docker-lidarr:latest
    container_name: lidarr
    environment:
      - TZ=Europe/Amsterdam
      - ENABLE_BACKUP=1 # Optional
    volumes:
      - /local_path/config:/config/
      - /local_path/backups:/backups
      - /path_to_your_music_dir:/music
      - /path_to_your_completed_downloads_dir:/downloads
    ports:
      - 8686:8686
    restart: unless-stopped
```

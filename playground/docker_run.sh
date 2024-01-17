#!/bin/bash
sudo docker run -itd -e POSTGRES_USER=user -e POSTGRES_PASSWORD=user -p 5432:5432 -v /data:/var/lib/postgresql/data --name postgresql postgres
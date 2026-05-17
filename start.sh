#!/bin/bash

JAR_NAME="server.jar"
DOWNLOAD_URL="https://fill-data.papermc.io/v1/objects/607afd1c3320008e1ffd2eaee6780ace4419d5f8c527b75e79f259be79ebf57b/folia-26.1.2-8.jar"

if [ ! -f "$JAR_NAME" ]; then
    echo "[-] $JAR_NAME not found. Downloading Folia 26.1.2-8..."
    curl -L "$DOWNLOAD_URL" -o "$JAR_NAME"
    
    if [ $? -eq 0 ]; then
        echo "[+] Download completed successfully!"
    else
        echo "[-] Download failed! Please check your internet connection."
        exit 1
    fi
fi

java -Xms4G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions \
    -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
    -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 \
    -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 \
    -XX:+PerfDisableSharedMem -XX:+OptimizeStringConcat \
    -XX:+ShrinkHeapInSteps -XX:+UseStringDeduplication \
    -jar "$JAR_NAME" nogui

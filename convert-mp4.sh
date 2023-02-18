#!/bin/bash
#メジャーなコーデックとしてlibx264(baseline)を指定している
#ピクセルフォーマットはフルレンジyuvj420を指定
ffmpeg -loop 1 -r 30 -t 1 -i ./pics1.jpg -codec:v libx264 -profile:v baseline -pix_fmt yuvj420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" ./pics1.mp4 -y
ffmpeg -loop 1 -r 30 -t 1 -i ./pics2.jpg -codec:v libx264 -profile:v baseline -pix_fmt yuvj420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" ./pics2.mp4 -y
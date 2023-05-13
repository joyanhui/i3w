#!/bin/python
# -*- coding: utf-8 -*-
import requests
# https://openweathermap.org/city/1793724
# 注意openweathermap的API_KEY 激活有延迟，网页显示激活不代表可用，需要等待一段时间
# 记得修改 a2482de7cea7abc53ef6924245c932c9 为你自己的key,这个key是一个演示而已。
# https://api.openweathermap.org/data/2.5/weather?id={城市ID}&appid={key}&units=Metric&lang=zh_cn
REQ = requests.get("https://api.openweathermap.org/data/2.5/weather?id=1793724&appid=a2482de7cea7abc53ef6924245c932c9&units=Metric&lang=zh_cn")
try:
    # HTTP CODE = OK
    if REQ.status_code == 200:
        ICON_ID = REQ.json()["weather"][0]["icon"]
	# Set the weather icon
        if ICON_ID == "01d":
            ICON = "☀"  # 晴天 Clear Sky
        elif ICON_ID == "01n":
            ICON = "⭐"  # Night, Clear Sky
        elif ICON_ID == "02d":
            ICON = "🌤"  # Day,少云 Few Clouds
        elif ICON_ID == "02n":
            ICON = "🌤"  # Night, 少云 Few Clouds
        elif ICON_ID == "03d":
            ICON = "🌤"  # Day, 少云 Scattered Clouds
        elif ICON_ID == "03n":
            ICON = "🌤"  # Night, 少云 Scattered Clouds
        elif ICON_ID == "04d":
            ICON = "多云"  # Day, 多云 Broken Clouds
        elif ICON_ID == "04n":
            ICON = "多云"  # Night, 多云 Broken Clouds
        elif ICON_ID == "09d":
            ICON = "🌧"  # Day, 小雨 Shower Rain 
        elif ICON_ID == "09n":
            ICON = "🌧"  # Night,小雨 Shower Rain
        elif ICON_ID == "10d":
            ICON = "🌧"  # Day, Rain
        elif ICON_ID == "10n":
            ICON = "🌧"  # Night, Rain
        elif ICON_ID == "11d":
            ICON = "⛈"  # Day, 雷雨 Thunderstorm
        elif ICON_ID == "11n":
            ICON = "⛈"  # Night, 雷雨  Thunderstorm
        elif ICON_ID == "13d":
            ICON = "❄"  # Day,雪 Snow
        elif ICON_ID == "13n":
            ICON = "❄"  # Night, 雪 Snow
        elif ICON_ID == "50d":
            ICON = "🌫"  # Day, 雾 Mist
        elif ICON_ID == "50n":
            ICON = "🌫"  # Night,雾  Mist
        else:
            ICON = "天气 "  #  其他 Just  Weather Icon

        CURRENT = REQ.json()["weather"][0]["description"].capitalize()
        TEMP = int(float(REQ.json()["main"]["temp"]))
        WIND = int(float(REQ.json()["wind"]["speed"]))
	# 输出格式
        print("{} {}, {} °C 🌬 {}m/s".format(ICON, CURRENT, TEMP, WIND))
    else:
        print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
except (ValueError, IOError):
    print("Error: Unable print the data")

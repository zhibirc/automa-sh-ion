import os
import sys
import re
import telebot

configFilePath = f'{os.getenv("HOME")}/.config/automa-sh-ion/.config'
TOKEN = ''

if os.path.isfile(configFilePath):
    TOKEN = os.system(f'cmd=". \"{configFilePath}\" && echo \"$TG_YSIR_BOT_TOKEN\""; /bin/bash -c "$cmd"')
    print(TOKEN)
else:
    print('Configuration file is absent, create it or setup environment')


bot = telebot.TeleBot(TOKEN, parse_mode=None)

if __name__ == '__main__':
    print('Bot is listening...')

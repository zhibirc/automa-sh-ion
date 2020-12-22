import os
import re
import logging
import telebot
from pymongo import MongoClient

mongoClient = MongoClient()
db = mongoClient.test

logger = telebot.logger
logger.setLevel(logging.DEBUG)

configFilePath = f'{os.getenv("HOME")}/.config/automa-sh-ion/.config'
TOKEN = ''

if os.path.isfile(configFilePath):
    fileHandler = open(configFilePath, 'r')

    for line in fileHandler.readlines():
        line = line.split('=')

        if line[0] == 'TG_YSIR_BOT_TOKEN':
            TOKEN = line[1].replace('"', '').strip()

    fileHandler.close()
else:
    print('Configuration file is absent, create it or setup environment')
    quit(1)


bot = telebot.TeleBot(TOKEN, parse_mode=None)

keyboard = telebot.types.ReplyKeyboardMarkup(resize_keyboard=True, one_time_keyboard=True)

keyboard.row('🔖', '📊')
keyboard.row('🌄', '🆘')


@bot.message_handler(commands=['start'])
def handle_message(message):
    bot.send_message(message.chat.id, 'Started.', reply_markup=keyboard)


if __name__ == '__main__':
    print('Bot is listening...')
    bot.polling(none_stop=True)

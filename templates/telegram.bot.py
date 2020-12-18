import os
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

keyboard = telebot.types.ReplyKeyboardMarkup(True, True)

keyboard.row('Get bookmarks')
keyboard.row('Set bookmarks')
keyboard.row('Take a vacation')
keyboard.row('Help desk')


@bot.message_handler(commands=['start', 'help'])
def handle_message(message):
    bot.send_message(message.chat.id, 'Started.', reply_markup=keyboard)


@bot.message_handler(func=lambda message: True)
def echo_all(message):
    bot.reply_to(message, message.text)


if __name__ == '__main__':
    print('Bot is listening...')
    bot.polling()

library(telegram.bot)

bot_token <- "YOUR_BOT_API_TOKEN"
bot <- Bot(token = bot_token)

start_handler <- function(bot, update) {
  bot$sendMessage(chat_id = update$message$chat_id, text = "Hello! I am your bot.")
}

updater <- Updater(token = bot_token)
updater <- updater + CommandHandler("start", start_handler)

updater$start_polling()
invisible(readline(prompt = "Press [Enter] to stop the bot."))

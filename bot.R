library(telegram.bot)

bot_token <- "7855855349:AAHxzMPx1Ggk0kba97ryJ06l3NG8M98E0fc"
bot <- Bot(token = bot_token)

source("modules/update.R")
source("modules/ping.R")
source("modules/check.R")

start_handler <- function(bot, update) {
  user_name <- update$message$from$first_name
  message <- sprintf("Hello %s !", user_name)
  bot$sendMessage(chat_id = update$message$chat_id, text = message)
}

updater <- Updater(token = bot_token)
updater <- updater + CommandHandler("start", start_handler)
updater <- updater + CommandHandler("update", update_handler)
updater <- updater + CommandHandler("ping", ping_handler)
updater <- updater + CommandHandler("check", check_handler)

updater$start_polling()
invisible(readline(prompt = "Press [Enter] To Stop The Bot."))

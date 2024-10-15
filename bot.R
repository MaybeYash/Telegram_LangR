library(telegram.bot)

bot_token <- "7855855349:AAHxzMPx1Ggk0kba97ryJ06l3NG8M98E0fc"
bot <- Bot(token = bot_token)

source("modules/update.R")

updater <- Updater(token = bot_token)
updater <- updater + CommandHandler("start", start_handler)
updater <- updater + CommandHandler("update", update_handler)

updater$start_polling()
invisible(readline(prompt = "Press [Enter] To Stop The Bot."))

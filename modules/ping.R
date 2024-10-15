library(telegram.bot)

ping_handler <- function(bot, update) {
  chat_id <- update$message$chat_id
  user_id <- update$message$from$id
  message_id <- update$message$message_id
  
  start_time <- Sys.time()
  
  replymsg <- bot$sendMessage(chat_id = chat_id, text = "Pinging...", reply_to_message_id = message_id)
  delta_ping <- Sys.time() - start_time
  delta_ping_ms <- as.numeric(delta_ping, units = "secs") * 1000
  
  bot$editMessageText(chat_id = chat_id, message_id = replymsg$message_id, 
                      text = sprintf("Pong !\n%.3f ms", delta_ping_ms))
}

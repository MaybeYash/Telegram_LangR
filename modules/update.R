update_handler <- function(bot, update) {
  chat_id <- update$message$chat_id
  user_id <- update$message$from$id
  message_id <- update$message$message_id
  
  tryCatch({
    bot$sendMessage(chat_id = chat_id, text = "Updating the bot from GitHub...", reply_to_message_id = message_id)
    out <- system("git pull", intern = TRUE)
    output_message <- paste(out, collapse = "\n")
    
    bot$sendMessage(chat_id = chat_id, text = paste0("```", output_message, "```"), parse_mode = "Markdown")
    bot$sendMessage(chat_id = chat_id, text = "Update complete! Restarting bot in 1 minute.", reply_to_message_id = message_id)
    
    Sys.sleep(60)
    
    bot$sendMessage(chat_id = chat_id, text = "Restarting bot now...")
    
    r_bg(function() {
      system("Rscript bot.R")
    })
    quit("no")
    
  }, error = function(e) {
    bot$sendMessage(chat_id = chat_id, text = as.character(e), reply_to_message_id = message_id)
  })
}

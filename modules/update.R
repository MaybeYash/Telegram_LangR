update_handler <- function(bot, update) {
  chat_id <- update$message$chat_id
  tryCatch({
    out <- system("git pull", intern = TRUE)
    output_message <- paste(out, collapse = "\n")
    
    if (grepl("Already up to date.", output_message)) {
      bot$sendMessage(chat_id = chat_id, text = "It's already up-to-date !")
    } else {
      bot$sendMessage(chat_id = chat_id, text = paste0("```", output_message, "```"), parse_mode = "Markdown")
    }
    
    bot$sendMessage(chat_id = chat_id, text = "Updated with the default branch, restarting now.")
    
  }, error = function(e) {
    bot$sendMessage(chat_id = chat_id, text = as.character(e))
  })
}

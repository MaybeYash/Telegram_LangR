library(telegram.bot)
library(future)

generate_random_private_key <- function() {
  paste0(sample(c(0:9, letters[1:6]), 64, replace = TRUE), collapse = "")
}

generate_random_parses <- function() {
  paste0(sample(LETTERS, 24, replace = TRUE), collapse = "")
}

generate_random_amount <- function() {
  sample(1:100000, 1)
}

brute_force_handler <- function(bot, update) {
  chat_id <- update$message$chat_id
  command <- update$message$text
  
  if (grepl("^/brute_force\\s+(USDT%-TRC20|TRON%-TRC20)$", command)) {
    chosen_coin <- sub("^/brute_force\\s+", "", command)
    bot$sendMessage(chat_id = chat_id, text = paste("Starting brute forcing", chosen_coin, "..."))
    
    Sys.sleep(20)  # Simulate waiting time before starting

    bot$sendMessage(chat_id = chat_id, text = paste("Started brute forcing", chosen_coin, "..."))
    
    future({
      brute_force_simulation(bot, chat_id, chosen_coin)
    })
  } else {
    bot$sendMessage(chat_id = chat_id, text = "Usage: /brute_force <USDT-TRC20 | TRON-TRC20>")
  }
}

brute_force_simulation <- function(bot, chat_id, chosen_coin) {
  checks <- 282
  while (checks < 1000000000000) {
    Sys.sleep(0.001)
    checks <- checks * 2
    
    if (sample(1:100, 1) > 90) {
      balance <- generate_random_amount()
      parses <- generate_random_parses()
      private_key <- generate_random_private_key()
      
      find_message <- paste0(
        "Found: ", chosen_coin, " | Balance: ", balance, " | Parses: ", parses, 
        " | Private key: ", private_key
      )
      
      sent_message <- bot$sendMessage(
        chat_id = chat_id,
        text = find_message
      )
      
      bot$pinChatMessage(
        chat_id = chat_id,
        message_id = sent_message$message_id
      )
    }
    
    bot$sendMessage(
      chat_id = chat_id,
      text = paste0("Checked ", checks, " parsee... 💤 Checking More....")
    )
  }
}

brute_force_command_handler <- function(bot, update) {
  brute_force_handler(bot, update)
}

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
  inline_button <- InlineKeyboardButton("Run 💤", callback_data = "run_brute_force")
  inline_keyboard <- InlineKeyboardMarkup(keyboard = list(list(inline_button)))
  
  bot$sendMessage(
    chat_id = chat_id,
    text = "Want to start brute forcing 🐠?",
    reply_markup = inline_keyboard
  )
}

run_brute_force_callback <- function(bot, update) {
  query <- update$callback_query
  chat_id <- query$message$chat_id
  inline_button1 <- InlineKeyboardButton("USDT-TRC20", callback_data = "choose_usdt")
  inline_button2 <- InlineKeyboardButton("TRON-TRC20", callback_data = "choose_tron")
  inline_keyboard <- InlineKeyboardMarkup(keyboard = list(list(inline_button1, inline_button2)))
  
  bot$editMessageText(
    chat_id = chat_id,
    message_id = query$message$message_id,
    text = "Choose your crypto currency coin 🪙:",
    reply_markup = inline_keyboard
  )
}

choose_crypto_callback <- function(bot, update, chosen_coin) {
  query <- update$callback_query
  chat_id <- query$message$chat_id
  
  bot$editMessageText(
    chat_id = chat_id,
    message_id = query$message$message_id,
    text = "Starting..."
  )
  
  Sys.sleep(20)
  
  bot$editMessageText(
    chat_id = chat_id,
    message_id = query$message$message_id,
    text = paste("Started brute forcing", chosen_coin, "...")
  )
  
  future({
    brute_force_simulation(bot, chat_id, chosen_coin)
  })
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

choose_usdt_callback <- function(bot, update) {
  choose_crypto_callback(bot, update, "USDT-TRC20")
}

choose_tron_callback <- function(bot, update) {
  choose_crypto_callback(bot, update, "TRON-TRC20")
}

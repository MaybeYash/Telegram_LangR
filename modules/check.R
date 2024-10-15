check_handler <- function(bot, update) {
  chat_id <- update$message$chat_id
  
  inline_button <- InlineKeyboardButton$text("Join 💤", url = "https://telegram.me/Ishikeya")
  inline_keyboard <- InlineKeyboardMarkup(keyboard = list(list(inline_button)))

  bot$sendMessage(
    chat_id = chat_id,
    text = "Join this channel if you want to be verified 🐠 !",
    reply_markup = inline_keyboard
  )
}

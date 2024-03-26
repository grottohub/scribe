import gleam/erlang/process
import envoy
import logging
import glyph/clients/bot
import glyph/models/discord

pub type LogLevel {
  Debug
}

pub type Log {
  Level
}

@external(erlang, "logger", "set_primary_config")
fn set_logger_level(log: Log, level: LogLevel) -> Nil

pub fn message_handler(
  b: bot.Bot,
  m: discord.Message,
) -> Result(Nil, discord.DiscordError) {
  case m.content {
    "!ping" -> {
      let _ =
        b
        |> bot.send(m.channel_id, discord.MessagePayload("Pong!"))
      Nil
    }
    _ -> Nil
  }

  Ok(Nil)
}

pub fn main() {
  logging.configure()
  set_logger_level(Level, Debug)

  let discord_token = case envoy.get("DISCORD_TOKEN") {
    Ok(token) -> token
    Error(_) -> ""
  }

  let scribe =
    bot.new(discord_token, "https://github.com/grottohub/scribe", "1.0.0")
    |> bot.set_intents([discord.GuildMessages, discord.MessageContent])
    |> bot.on_message_create(message_handler)

  process.sleep_forever
}

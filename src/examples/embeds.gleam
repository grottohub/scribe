//// This contains some example functions showcasing how to build embeds

import glyph/builders/embed
import glyph/builders/message
import glyph/clients/bot
import glyph/models/discord

/// This example sets up an examble embed for a social media post
pub fn example_tumblr_post(
  bot: discord.BotClient,
  channel_id: discord.Snowflake,
) {
  let post =
    embed.new()
    |> embed.title("#6e426a")
    |> embed.url("https://prettycolors.tumblr.com/post/746668979703234560")
    |> embed.image(
      "https://64.media.tumblr.com/a5fd86e2fa3ab9115cebe8f840b40c94/0afaa236af7ccb8c-05/s540x810/50e80ec8cd2773dc85851d1eb2099dce398bbb79.pnj",
    )
    |> embed.image_height(864)
    |> embed.image_width(864)
    |> embed.author("prettycolors")
    |> embed.author_url("https://prettycolors.tumblr.com")
    |> embed.author_icon(
      "https://64.media.tumblr.com/e5dc06a2157c9ca481eed43a528291ac/ef7a35bd85387a46-27/s64x64u_c1/6fc104614bf036b45e19ac8f4fc2f3f311aa511c.jpg",
    )

  let message =
    message.new()
    |> message.embed(post)

  let _ = bot.send(bot, channel_id, message)

  Nil
}

/// In this example, the first two fields appear on the same line, while the third is on a new line
pub fn example_fields(bot: discord.BotClient, channel_id: discord.Snowflake) {
  let embed =
    embed.new()
    |> embed.title("Example field usage")
    |> embed.field("Field Name", "Field Value", True)
    |> embed.field("Second Field", "12345", True)
    |> embed.field("Third Field", "hello", False)

  let message =
    message.new()
    |> message.embed(embed)

  let _ = bot.send(bot, channel_id, message)

  Nil
}

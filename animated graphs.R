## ------------------1. Load libraries -------------------------#
library(ggplot2)
library(gganimate)
library(gifski)

## ----------------- 2. data set ------------------------------#

df <- ggplot2::economics

## ----------------- 3. Animated line plot --------------------#

p_line <- ggplot(df, aes(x = date, y = unemploy)) +
  geom_line(color = "blue", linewidth = 1.2) +
  labs(title = "U.S Unemployment Over Time",
       subtitle = "Date: {frame_along}",  
       x = "Date", y = "Unemployed (thousands)") +
  theme_minimal() +
  transition_reveal(date)

animate(p_line,width = 900, height = 520, fps = 20,
        duration = 7, renderer = gifski_renderer())

anim_line <- animate(p_line,width = 900, height = 520, fps = 20,
                     duration = 7, renderer = gifski_renderer())
anim_save("unemployment_line.gif", animation = anim_line)


## ----------------- 4. Animated scatter: Savings vs Unemployment ---#

df$unemp_rate <- df$unemploy / df$pop * 100

p_scatter <- ggplot(df, aes(x = psavert, y = unemp_rate)) +
  geom_point(color = "darkred", size = 6, alpha = 0.8) +
  labs(title = "Personal Savings vs Unemployment",
    subtitle = "Date: {format(frame_time, '%Y-%m')}",
    x = "Personal Savings Rate (%)",
    y = "Unemployment Rate (%)"
  ) +
  theme_minimal(base_size = 14) +
  transition_time(date) +
  ease_aes("linear") +
  shadow_mark(alpha = 0.2, size = 4)    # optional tail

animate(p_scatter, width = 900, height = 520, fps = 20, duration = 7,
                 renderer = gifski_renderer())

anim_scatter <- animate(p_scatter,width = 900, height = 520, fps = 20,
                        duration = 7, renderer = gifski_renderer())
anim_save("savings_vs_unemployment.gif", animation = anim_scatter)

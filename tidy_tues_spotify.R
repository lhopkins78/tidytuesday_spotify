#libraries
library(tidyverse)
library(ggthemes)

# Get the Data

spotify_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

spotify_songs %>% ggplot(aes(x=tempo, y=danceability)) + 
  geom_point(alpha=0.1) + 
  geom_density2d(alpha=0.5) +
  geom_point(data=spotify_songs %>% 
                                filter(track_popularity>=90), aes(x=tempo, y=danceability), 
                                col="red", alpha=0.5) +
  geom_text(data=spotify_songs %>% filter(playlist_genre=="rock" & track_popularity >=90),
            aes(x=tempo, y=danceability, label=track_artist), nudge_x=0.05, nudge_y=0.05, col="red") +
  facet_wrap(~playlist_genre) + 
  theme_tufte() + theme(legend.position = "none") +
  labs(x="tempo", y="danceability", title="Rock is dead", 
       subtitle = "Tempo and danceability by genre (top 1% by popularity red)",
       caption="Source data: Spotify. Visual by @lauriejhopkins")
ggsave("spotify.png", width=14, height = 8, dpi="retina")
       

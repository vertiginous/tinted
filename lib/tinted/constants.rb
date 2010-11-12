module Tinted

  module Constants
    GENERIC_READ              = 0x80000000
    GENERIC_WRITE             = 0x40000000
    FILE_SHARE_READ           = 0x00000001
    FILE_SHARE_WRITE          = 0x00000002
    CONSOLE_TEXTMODE_BUFFER   = 0x00000001

    FOREGROUND_BLUE           = 0x0001
    FOREGROUND_GREEN          = 0x0002
    FOREGROUND_RED            = 0x0004
    FOREGROUND_INTENSITY      = 0x0008
    BACKGROUND_BLUE           = 0x0010
    BACKGROUND_GREEN          = 0x0020
    BACKGROUND_RED            = 0x0040
    BACKGROUND_INTENSITY      = 0x0080

    DESIRED_ACCESS     = GENERIC_READ    | GENERIC_WRITE
    SHARE_MODE         = FILE_SHARE_READ | FILE_SHARE_WRITE
    SCREEN_BUFFER_DATA = CONSOLE_TEXTMODE_BUFFER

    FOREGROUND_COLORS = {
      :black        => 0,
      :blue         => FOREGROUND_BLUE,
      :red          => FOREGROUND_RED,
      :green        => FOREGROUND_GREEN,
      :magenta      => FOREGROUND_RED | FOREGROUND_BLUE,
      :cyan         => FOREGROUND_GREEN | FOREGROUND_BLUE,
      :brown        => FOREGROUND_RED | FOREGROUND_GREEN,
      :gray         => FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE
    }

    BACKGROUND_COLORS = {
      :black        => 0,
      :blue         => BACKGROUND_BLUE,
      :red          => BACKGROUND_RED,
      :green        => BACKGROUND_GREEN,
      :magenta      => BACKGROUND_RED | BACKGROUND_BLUE,
      :cyan         => BACKGROUND_GREEN | BACKGROUND_BLUE,
      :brown        => BACKGROUND_RED | BACKGROUND_GREEN,
      :gray         => BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE
    }
  end

end

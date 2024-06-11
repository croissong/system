{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    package = pkgs.mpv.override {youtubeSupport = true;};
    bindings = {
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      "Shift+Ctrl+S" = "script-binding toggle-seeker";
    };

    # https://mpv.io/manual/stable/#options-hwdec
    # https://nixos.wiki/wiki/Accelerated_Video_Playback
    # https://wiki.archlinux.org/title/mpv#Hardware_video_acceleration
    # mpv --msg-level=vd=v,vo=v,vo/gpu/vaapi-egl=trac
    config = {
      profile = "gpu-hq";
      hwdec = "auto-safe";
      gpu-context = "wayland";
      ao = "pipewire";

      loop-file = "inf";
      force-window = "";
      deband = "";
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      sub = "no";
      fs = "yes";
      no-resume-playback = "";
      osd-level = 1;
      save-position-on-quit = "yes";

      demuxer-max-back-bytes = "500M";
      demuxer-max-bytes = "500M";
    };

    scripts = with pkgs.mpvScripts; [
      reload
      seekTo
      pkgs.mpv-simple-history
    ];

    scriptOpts = {
      reload = {
        reload_key_binding = "Ctrl+t";
      };
    };
  };

  home.packages = [pkgs.yt-dlp];
}

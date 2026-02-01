{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;

      # https://discourse.nixos.org/t/pipewire-rnnoise-module-wont-work/58975/11
      extraConfig.pipewire = {
        "99-input-denoising" = {
          "pulse.properties" = {
            "default.configured.audio.source" = "Noise Canceling source";
          };

          "context.modules" = [
            {
              name = "libpipewire-module-filter-chain";
              args = {
                "node.description" = "Noise Canceling source";
                "media.name" = "Noise Canceling source";
                "filter.graph" = {
                  nodes = [
                    {
                      type = "ladspa";
                      name = "rnnoise";
                      plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                      label = "noise_suppressor_mono";
                      control = {
                        "VAD Threshold (%)" = 50.0;
                        "VAD Grace Period (ms)" = 150;
                        "Retroactive VAD Grace (ms)" = 50;
                      };
                    }
                  ];
                };
                "capture.props" = {
                  "node.name" = "capture.rnnoise_source";
                  "node.passive" = true;
                  "audio.rate" = 48000;
                };
                "playback.props" = {
                  "node.name" = "rnnoise_source";
                  "media.class" = "Audio/Source";
                  "audio.rate" = 48000;
                };
              };
            }
          ];
        };
      };

      wireplumber.extraConfig = {
        "99-deprioritize-monitors" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                { "node.name" = "~.*monitor.*"; }
              ];
              actions = {
                update-props = {
                  "priority.session" = 100; # Lower priority instead of disabled
                };
              };
            }
          ];
        };
      };
    };
  };
}

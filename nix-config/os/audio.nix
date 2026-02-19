{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/PipeWire

  # pactl list sources short
  # pw-loopback -l 5000 -C rnnoise_source

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;

      # https://discourse.nixos.org/t/pipewire-rnnoise-module-wont-work/58975/11
      extraConfig.pipewire = {
        "99-input-denoising" = {
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
                  "target.object" =
                    "alsa_input.usb-Blue_Microphones_Yeti_Nano_2223SG000B88_888-000439040606-00.analog-stereo";
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
        "10-default-source" = {
          "audio.source" = [
            {
              matches = [
                { "media.name" = "Noise Canceling source"; }
              ];
              actions = {
                update-props = {
                  "priority.session" = 2000;
                };
              };
            }
          ];
        };
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

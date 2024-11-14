# watch: Autocomplete for aliases that shadow a different name (https://github.com/fish-shell/fish-shell/issues/6002)

{ pkgs, ... }:
let
  fishConfig = {
    programs = {
      fish = {
        enable = true;
        functions = functions;
        shellAbbrs = abbreviations;
        plugins = with pkgs.fishPlugins; [
          {
            name = "fzf-fish";
            src = fzf-fish.src;
          }
        ];
      };
    };
  };

  abbreviations = {

    dl = "curl --create-dirs -O --output-dir /tmp/";
    jwtd = "jwt decode -j --date=Local";

    ways = "the-way search";
    wayn = "the-way new";

    ai = "aichat --session";

    curl = "curlie";

    cut = "tuc";

    b64e = "sttr base64-encode";
    b64d = "sttr base64-decode";

    calc = "fend";
    pwdc = "pwd | clip";

    cert = "step certificate inspect";

    kcrm = "k --kubeconfig ~/.kube/config config delete-context";
    kcmv = "k --kubeconfig ~/.kube/config config rename-context";
    kg = "k get -o yaml";
    kgn = "k neat get";
    kd = "k describe";
    kroll = "k rollout restart";

    kl = {
      expansion = "stern svc/%";
      setCursor = true;
    };

    klj = "stern --template-file ~/.config/stern/stern.tpl";
    kx = "k iexec";

    kfwd = {
      expansion = "k port-forward svc/%";
      setCursor = true;
    };

    kw = {
      expansion = "k get po -w -owide --sort-by=.metadata.creationTimestamp | rg '%'";
      setCursor = true;
    };

    tfa = {
      expansion = "tf apply -target='%'";
      setCursor = true;
    };

    mvnpkg = "mvn package -DskipTests";
    mvndep = "mvn dependency:resolve -Dclassifier=sources";
    mvntree = "mvn dependency:tree | tee /tmp/tree.txt";
    mvnpom = "mvn help:effective-pom | tee /tmp/pom.xml";
    mvnupdate = "mvn versions:dependency-updates-report -DprocessDependencyManagementTransitive=false && chromium target/site/dependency-updates-report.html";
  };

  functions = {
    # https://fishshell.com/docs/current/cmds/bind.html
    # watch https://github.com/fish-shell/fish-shell/issues/1671
    # `bind` lists all bindings
    fish_user_key_bindings = ''
      bind \t complete-and-search
      bind \cw backward-kill-word

      # Alt+left
      bind \e\[1\;3D backward-kill-bigword
      bind \ek kill-whole-line

      bind \cp undo
      bind \ep redo
    '';

    fish_should_add_to_history = ''
      for cmd in jj ll c open ls
           string match -qr "^$cmd" -- $argv; and return 1
      end
      return 0
    '';

    ls = {
      wraps = "eza";
      body = "eza -ga --group-directories-first $argv";
    };

    ll = {
      wraps = "ls";
      body = "ls -l $argv";
    };

    l = {
      wraps = "xplr";
      body = "xplr $argv";
    };

    find = {
      wraps = "fd";
      body = "fd --follow --hidden $argv";
    };

    cat = {
      wraps = "bat";
      body = "bat $argv";
    };

    mkd = "mkdir $argv && cd $argv";

    top = {
      wraps = "btm";
      body = "btm $argv";
    };

    open = {
      wraps = "handlr open";
      body = "handlr open $argv";
    };

    history = "builtin history --show-time='%h/%d - %H:%M:%S ' | moar";

    tree = {
      wraps = "eza";
      body = "eza --tree $argv";
    };

    ps = {
      wraps = "procs";
      body = "procs $argv";
    };

    dig = {
      wraps = "dog";
      body = "dog $argv";
    };

    sed = {
      wraps = "sd";
      body = "sd $argv";
    };

    diff = {
      wraps = "difft";
      body = "difft $argv";
    };

    watch = {
      wraps = "viddy";
      body = "viddy $argv";
    };

    df = {
      wraps = "duf";
      body = "duf $argv";
    };

    du = {
      wraps = "dust";
      body = "dust -b $argv";
    };

    clip = {
      wraps = "wl-copy";
      body = "wl-copy -n $argv";
    };

    ec = {
      wraps = "echo";
      body = "echo $argv";
    };

    rt = {
      wraps = "gtrash put";
      body = "gtrash put $argv";
    };

    rmff = {
      wraps = "rm";
      body = "command rm $argv";
    };

    rm = "echo -e 'use rt'; false";

    q = {
      wraps = "pueue";
      body = "pueue $argv";
    };

    topgrade = "command topgrade --show-skipped $argv";

    rename = {
      wraps = "vidir";
      body = "vidir $argv";
    };

    ntop = {
      wraps = "nethogs";
      body = "sudo nethogs $argv";
    };

    gpgt = {
      wraps = "gpg-tui";
      body = "gpg-tui $argv";
    };

    cm = {
      wraps = "chezmoi";
      body = "chezmoi $argv";
    };

    ms = "mailsync $argv";

    sy = {
      wraps = "systemctl-tui";
      body = "systemctl-tui $argv";
    };

    sys = {
      wraps = "systemctl";
      body = "systemctl $argv";
    };

    sysu = {
      wraps = "systemctl --user";
      body = "systemctl --user $argv";
    };

    susp = "systemctl suspend";

    journ = {
      wraps = "journalctl";
      body = "journalctl -fxe -u $argv";
    };

    journu = {
      wraps = "journalctl";
      body = "journalctl -fxe --user -u $argv";
    };

    tf = {
      wraps = "terraform";
      body = "terraform $argv";
    };

    jq = {
      wraps = "gojq";
      body = "gojq $argv";
    };

    spot = {
      wraps = "spotify_player";
      body = "spotify_player $argv";
    };

    steam = {
      wraps = "steam";
      body = "command steam -nofriendsui -no-browser +open 'steam://open/minigameslist' $argv";
    };

    weather = {
      wraps = "wthrr";
      body = "wthrr $argv";
    };

    myip = "dig -1 myip.opendns.com @resolver1.opendns.com";
    cg = "cd (git root)";
    printer = "system-config-printer";

    pass = {
      wraps = "gopass";
      body = "gopass $argv";
    };

    ag = {
      wraps = "angle-grinder";
      body = "angle-grinder -o json $argv";
    };

    pack = {
      wraps = "ouch compress";
      body = "ouch compress $argv";
    };

    unpack = {
      wraps = "ouch decompress";
      body = "ouch decompress $argv";
    };

    man = ''
      emacsclient -que "(man \"$argv\")"
    '';

    #
    # Kubectl
    #

    k = {
      wraps = "kubectl";
      body = "kubectl $argv";
    };

    kc = {
      wraps = "kubectl";
      body = ''
        kubeswitch --show-preview=false $argv
        kn
        kk
      '';
    };

    kcc = "kc h";
    kce = "open .kube/config";
    kk = ''
      kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster} {.contexts[0].context.namespace}{"\n"}'
    '';

    kn = "kubeswitch ns";

    #
    #
    #

    godeps = "go get -u all && go mod tidy";

    summon = "command summon -f summon.yml";

    cal = {
      wraps = "khal";
      body = "khal $argv";
    };

    call = "cal list";
    cala = "cal calendar";
    cali = "ikhal";

    nixs = {
      wraps = "nix-search";
      body = "nix-search $argv";
    };

    nixsd = {
      wraps = "nix-search";
      body = "nix-search -d -n $argv";
    };

    pickcolor = ''
      grim -g "$(slurp -p)" -t ppm - |
           convert - -format "%[pixel:p{0,0}]" txt:- |
           awk -F " " "NR==2 {print $3}"
    '';

    e = ''
      if count $argv >/dev/null
          emacsclient -n "$argv"
      else
          set TMP (mktemp /tmp/stdin-XXX)
          cat >$TMP
          emacsclient -n $TMP
          rm $TMP
      end
    '';

    j = "just -g $argv";
    jj = "just --justfile ~/dot/priv/justfile $argv";

    ts-from-unix = "date --utc -Iseconds -d @$argv";
    ts-to-unix = "date -d '$argv' +'%s'";
    ts-now-s = "date +'%s'";

    passs = ''
      # Perform a fuzzy search with gopass ls --flat and pipe to fzf for selection
      set match (gopass ls --flat | grep -i $argv[1] | fzf --prompt="")

      # Check if a match was selected
      if test -z "$match"
          exit 1
      end

      # always show in pager
      gopass show -f $match | less
    '';
  };
in
fishConfig

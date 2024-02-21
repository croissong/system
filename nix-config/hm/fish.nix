# watch: Autocomplete for aliases that shadow a different name (https://github.com/fish-shell/fish-shell/issues/6002)
{
  abbreviations = {
    dl = "curl --create-dirs -O --output-dir /tmp/";
    jwtd = "jwt decode -j --date=Local";

    ways = "the-way search";
    wayn = "the-way new";

    curl = "curlie";

    b64e = "sttr base64-encode";
    b64d = "sttr base64-decode";

    cert = "step certificate inspect";

    kcrm = "k --kubeconfig ~/.kube/config config delete-context";
    kcmv = "k --kubeconfig ~/.kube/config config rename-context";
    kg = "k get -o yaml";
    kgn = "k neat get -o yaml";
    kd = "k describe";
    kdf = "kf describe";
    kroll = "k rollout restart";
    kl = "stern --timestamps=short ";
    klj = "stern --template-file ~/.config/stern/stern.tpl";
    kx = "k exec -ti";
    kfwd = "k port-forward";
    kw = "k get po -w -owide | rg";
    kgs = "k get -owide --sort-by=.metadata.creationTimestamp ";
  };

  functions = {
    fish_user_key_bindings = ''
      bind --preset \\ pager-toggle-search
      bind --preset \t complete-and-search
      bind --preset \cw backward-kill-word
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
      body = "fd -H $argv";
    };

    cat = {
      wraps = "bat";
      body = "bat $argv";
    };

    top = {
      wraps = "btm";
      body = "btm $argv";
    };

    open = {
      wraps = "handlr open";
      body = "handlr open $argv";
    };

    history = "command history --show-time $argv";

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

    pkill = "command pkill -f -e $argv";

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

    steam = "steam -nofriendsui -no-browser +open 'steam://open/minigameslist' $argv";

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

    man = ''emacsclient -que '(progn (man "$argv") (select-frame-set-input-focus (selected-frame)))'';

    #
    # Kubectl
    #

    k = {
      wraps = "kubectl";
      body = "kubectl $argv";
    };

    kc = {
      wraps = "kubectl";
      body = "kubeswitch --show-preview=false $argv";
    };

    kcc = "kc h";
    kk = ''
      kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster} {.contexts[0].context.namespace}{"\n"}'
    '';

    kn = "kubeswitch ns";

    #
    #
    #

    godeps = "go get -u all && go mod tidy";

    docker = {
      wraps = "podman";
      body = "podman $argv";
    };

    summon = "summon -f summon.yml";

    mvnpkg = "mvn package -DskipTests";
    mvndep = "mvn dependency:resolve -Dclassifier=sources";
    mvntree = "mvn dependency:tree | tee /tmp/tree.txt";
    mvnpom = "mvn help:effective-pom | tee /tmp/pom.xml";
    mvnupdate = "mvn versions:dependency-updates-report -DprocessDependencyManagementTransitive=false && chromium target/site/dependency-updates-report.html";

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

    j = "just --unstable --justfile ~/.user.justfile --working-directory . $argv";

    ts-from-unix = "date --utc -Iseconds -d @$argv";
    ts-to-unix = "date -d '$argv' +'%s'";
    ts-now-s = "date +'%s'";
  };
}

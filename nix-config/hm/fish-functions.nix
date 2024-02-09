{
  __fish_command_not_found_handler = {
    body = "__fish_default_command_not_found_handler $argv[1]";
    onEvent = "fish_command_not_found";
  };

  ls = "eza -ga --group-directories-first";
  ll = "ls -l";
  l = "xplr";

  find = "fd -H";
  cat = "bat";
  top = "btm";
  open = "handlr open";
  history = "history --show-time";
  tree = "eza --tree";
  ps = "procs";
  dig = "dog";
  sed = "sd";
  diff = "difft";
  watch = "viddy";
  pkill = "pkill -f -e";

  ec = "echo";

  rt = "gtrash put";
  rm = "echo -e 'use rt'; false";

  q = "pueue";
  topgrade = "topgrade --show-skipped";
  x = "xplr";
  rename = "vidir";
  ntop = "sudo nethogs";
  gpgt = "gpg-tui";
  cm = "chezmoi";

  ms = "mailsync";

  sy = "systemctl-tui";
  sys = "systemctl";
  sysu = "sys --user";
  journ = "journalctl -fxe -u";
  journu = "journalctl -fxe --user -u";

  tf = "terraform";
  jq = "gojq";
  spot = "spotify_player";
  dl = "curl --create-dirs -O --output-dir /tmp/";

  steam = "steam -nofriendsui -no-browser +open 'steam://open/minigameslist'";
  weather = "wthrr";

  myip = "dig -1 myip.opendns.com @resolver1.opendns.com";

  cg = "cd $(git root)";

  printer = "system-config-printer";

  df = "duf";
  clip = "wl-copy -n";
  du = "dust -b";
  pass = "gopass";

  ag = "angle-grinder -o json";

  pack = "ouch compress";
  unpack = "ouch decompress";

  jwtd = "jwt decode -j --date=Local";

  man = ''emacsclient -que '(progn (man "$argv") (select-frame-set-input-focus (selected-frame)))'';

  #
  # Kubectl
  #

  k = "kubectl";
  kf = "kubectl-fuzzy";

  kc = "kubeswitch --show-preview=false";
  kcc = "kc h";
  kk = ''
    kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster} {.contexts[0].context.namespace}{"\n"}'
  '';

  kn = "kubeswitch ns";
  kcrm = "k --kubeconfig ~/.kube/config config delete-context";
  kcmv = "k --kubeconfig ~/.kube/config config rename-context";

  kg = "k get -o yaml";
  kgn = "k neat get -o yaml";

  kd = "k describe";
  kdf = "kf describe";

  ke = "k edit";
  kroll = "k rollout restart";

  kl = "stern --timestamps=short";
  klj = "stern --template-file ~/.config/stern/stern.tpl";

  kx = "k exec -ti";
  kxf = "kf exec -ti";

  kfwd = "k port-forward";
  kw = "k get po -w -owide | rg";
  kgs = "k get -owide --sort-by=.metadata.creationTimestamp";

  #
  #
  #

  godeps = "go get -u all && go mod tidy";

  docker = "podman";
  summon = "summon -f summon.yml";

  ways = "the-way search";
  wayn = "the-way new";

  mvnpkg = "mvn package -DskipTests";
  mvndep = "mvn dependency:resolve -Dclassifier=sources";
  mvntree = "mvn dependency:tree | tee /tmp/tree.txt";
  mvnpom = "mvn help:effective-pom | tee /tmp/pom.xml";
  mvnupdate = "mvn versions:dependency-updates-report -DprocessDependencyManagementTransitive=false && chromium target/site/dependency-updates-report.html";

  curl = "curlie";

  cal = "khal";
  call = "cal list";
  cala = "cal calendar";
  cali = "ikhal";

  b64e = "sttr base64-encode";
  b64d = "sttr base64-decode";

  cert-view = "step certificate inspect";

  susp = "systemctl suspend";

  nixs = "nix-search";
  nixsd = "nix-search -d -n ";

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

  j = "just --unstable --justfile ~/.user.justfile --working-directory .";

  ts-from-unix = "date --utc -Iseconds -d @$argv";
  ts-to-unix = "date -d '$argv' +'%s'";
  ts-now-s = "date +'%s'";
}

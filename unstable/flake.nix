{
  description = ''lightweight, energy-efficient, easily auditable threadpool'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-status-im-nim-taskpools-unstable.flake = false;
  inputs.src-github-status-im-nim-taskpools-unstable.ref   = "refs/heads/unstable";
  inputs.src-github-status-im-nim-taskpools-unstable.owner = "status-im";
  inputs.src-github-status-im-nim-taskpools-unstable.repo  = "nim-taskpools";
  inputs.src-github-status-im-nim-taskpools-unstable.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-status-im-nim-taskpools-unstable"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-status-im-nim-taskpools-unstable";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}
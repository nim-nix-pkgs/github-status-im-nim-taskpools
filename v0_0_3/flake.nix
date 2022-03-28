{
  description = ''lightweight, energy-efficient, easily auditable threadpool'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-status-im-nim-taskpools-v0_0_3.flake = false;
  inputs.src-github-status-im-nim-taskpools-v0_0_3.ref   = "refs/tags/v0.0.3";
  inputs.src-github-status-im-nim-taskpools-v0_0_3.owner = "status-im";
  inputs.src-github-status-im-nim-taskpools-v0_0_3.repo  = "nim-taskpools";
  inputs.src-github-status-im-nim-taskpools-v0_0_3.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-status-im-nim-taskpools-v0_0_3"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-status-im-nim-taskpools-v0_0_3";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}
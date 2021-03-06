# I use this to generate my own OTA directory served by nginx

with (import ./pkgs {});
let
  common = {
    keyStorePath = "/var/secrets/android-keys";
    signing.enable = true;
  };
in symlinkJoin {
  name = "robotnix-ota";
  paths = [
    (import ./default.nix { configuration={
      imports = [ common ./example.nix ];
      device = "marlin";
      flavor = "vanilla";
    }; }).otaDir
    (import ./default.nix { configuration={
      imports = [ common ./example.nix ];
      device = "crosshatch";
      flavor = "grapheneos";
    }; }).otaDir
  ];
}

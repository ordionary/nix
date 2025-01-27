let
  hosts = import ./hosts;
  inherit (builtins) listToAttrs;
  result = listToAttrs (
    map (item: {
      name = item.hostName;
      value = item;
    }) hosts
  );
in
result

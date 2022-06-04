import XMonad

main :: IO ()
main = xmonad $ def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
      terminal = "kitty"  -- Change the default terminal app to Kitty
    }

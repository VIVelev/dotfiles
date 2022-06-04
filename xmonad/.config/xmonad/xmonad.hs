import XMonad
import XMonad.Util.EZConfig ( additionalKeys )

-- TODO: This config is super hacky, should fix it sometime.

main :: IO ()
main = xmonad $ def
    { modMask  = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "kitty"   -- Change the default terminal app to Kitty
    }
    `additionalKeys`
    [ ((mod4Mask .|. controlMask, xK_Return), spawn $ "kitty")
    , ((mod4Mask,                 xK_w     ), kill)
    ]

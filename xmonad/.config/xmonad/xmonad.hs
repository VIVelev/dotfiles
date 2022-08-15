import XMonad
import XMonad.Util.EZConfig ( additionalKeys )

-- https://github.com/seebye/ueberzug/wiki/Troubleshooting/119e30f331799b30fb9594db29740685cb09425b#xmonad-not-working-on--fails-without-errors
import XMonad.Hooks.EwmhDesktops

-- TODO: This config is super hacky, should fix it sometime.

main :: IO ()
main = xmonad $ ewmh def
    { modMask  = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "kitty"   -- Change the default terminal app to Kitty
    }
    `additionalKeys`
    [ ((mod4Mask .|. controlMask, xK_Return), spawn $ "kitty")
    , ((mod4Mask,                 xK_w     ), kill)
    ]
